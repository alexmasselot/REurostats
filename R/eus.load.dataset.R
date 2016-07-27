library(dplyr)
library(tidyr)
library(lubridate)

eus.load.dataset = function(dataset.name){
  filename = system.file("extdata", paste(dataset.name,'.tsv.gz', sep=''), package = "REurostats")

  dt.orig=read.delim(filename, header = T, sep='\t')
  c0=colnames(dt.orig)[1]
  colnames(dt.orig)[1]='C0'

  dt.trans = dt.orig %>%
    gather(key=period,value=value, -C0)  %>%
    separate(C0, into = c("index", "adjusted", "country.code"), sep = ",")

  dt.trans$date = as.Date(paste(dt.trans$period, "01"), "X%YM%m %d")
  dt.trans$date.month = month(dt.trans$date)
  dt.trans$date.year = year(dt.trans$date)

  dt.trans$is.seasonaly.adjusted = dt.trans$adjusted == 'SA'

  dt.trans$value  = as.numeric(dt.trans$value)
  dt.trans = subset(dt.trans, ! is.na(value))

  list(
    data=dt.trans,
    description=eus.toc.get.description(dataset.name),
    description.lineage=eus.toc.get.description.lineage(dataset.name)
  )
}
