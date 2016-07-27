library(dplyr)
library(tidyr)
library(lubridate)

.date.tag.conversion = list(
  M01 = '0131',
  M02 = '0228',
  M03 = '0331',
  M04 = '0430',
  M05 = '0531',
  M06 = '0630',
  M07 = '0731',
  M08 = '0831',
  M09 = '0930',
  M10 = '1031',
  M11 = '1130',
  M12 = '1231',
  Q01 = '0331',
  Q02 = '0630',
  Q03 = '0930',
  Q04 = '1231',
  S01 = '0630',
  S02 = '1231',
  Y01 = '1231'
)

eus.data.load = function(dataset.name, load.description=F){
  filename = system.file("extdata/data", paste(dataset.name,'.tsv.gz', sep=''), package = "REurostats")

  dt.head = read.delim(filename, header = F, sep='\t', nrows = 1)
  c0=dt.head[1,1]
  c0 = gsub('\\\\time', '', c0)

  dt.orig=read.delim(filename, header = T, sep='\t')
  colnames(dt.orig)[1]='C0'

  extra.fields = strsplit(c0, ',')[[1]]
  dt.trans = dt.orig %>%
    gather(key=period,value=value, -C0)  %>%
    separate(C0, into = extra.fields, sep = ",")

  #replace the Mxx and co tag name with actual month/day
  .date.tag = substr(dt.trans$period, nchar(dt.trans$period)-2, nchar(dt.trans$period))
  .date.tag = sapply(.date.tag, function(t){.date.tag.conversion[[t]]})
  .date.str = paste(substr(dt.trans$period, 1, nchar(dt.trans$period)-3),
                    .date.tag,
                    sep='')

  dt.trans$date = as.Date(.date.str, "X%Y%m%d")
  dt.trans$date.month = month(dt.trans$date)
  dt.trans$date.year = year(dt.trans$date)

  dt.trans$value  = as.numeric(dt.trans$value)
  dt.trans = subset(dt.trans, ! is.na(value))

  if(load.description){
    for (f in extra.fields){
      f.descr = paste(f, 'description', sep='.')
      dt.trans[[f.descr]] =  eus.dic.get.description(f, dt.trans[[f]])
    }
  }

  list(
    data=dt.trans,
    description=eus.toc.get.description(dataset.name),
    description.lineage=eus.toc.get.description.lineage(dataset.name),
    extra.fields=extra.fields
  )
}
