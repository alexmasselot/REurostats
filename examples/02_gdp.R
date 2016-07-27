#these two lines are equivalent to library(Eurostats).
#use devtools loading to load the package from another repository, git or install it locally
#
# check README.md to mirror the dataset

library(devtools)
load_all()

dataset.name = 'nama_10_pc'
dt = eus.data.load(dataset.name, load.description = TRUE)
print(dt$description)

for (f in dt$extra.fields){
  print(paste('extra field=',f))
  c=sort(unique(dt$data[[f]]))
  c.descr=data.frame(description=eus.dic.get.description(f,c))
  rownames(c.descr)=c
  print(c.descr)
}

# and we can go for a plot with more meaningful titles
library(ggplot2)
dt.plot = subset(dt$data,
                   unit=='CP_EUR_HAB' &
                   geo %in% c('FR', 'DE', 'IT', 'ES', 'UK', 'PT') &
                   date.year > 2010
)

q = ggplot(dt.plot, aes(x=date, y=value)) +
  geom_smooth(aes(colour=geo.description), lwd=1.5) +
  facet_wrap( "na_item.description", scales="free_y") +
  labs(title=paste(dt$description,
                   eus.dic.get.description('unit', 'CP_EUR_HAB'), sep='\n')
       ) +
  theme_bw()
print(q)

