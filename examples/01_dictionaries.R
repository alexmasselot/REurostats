#these two lines are equivalent to library(Eurostats).
#use devtools loading to load the package from another repository, git or install it locally
#
# check README.md to mirror the dataset

library(devtools)
load_all()


#a functional way to resolve dic/key
eus.dic.get.description('indic')('BS-CCI-BAL')
#a classic way
eus.dic.get.description('indic', 'BS-CCI-BAL')


# for a dataset, I want to see the inndic + meaning
dt = eus.data.load('ei_bsbu_m_r2')
dt$data$indic.description = eus.dic.get.description('indic', dt$data$indic)
dt$data$geo.description = eus.dic.get.description('geo', dt$data$geo)
dt$data$geo.description = gsub('\\s*\\(.*\\)', '', dt$data$geo.description)

# and we can go for a plot with more meaningful titles
library(ggplot2)
dt.plot = subset(dt$data,
                   s_adj=='NSA' &
                   geo %in% c('FR', 'DE', 'IT', 'ES', 'UK', 'PT') &
                   date.year > 2010
)

q = ggplot(dt.plot, aes(x=date, y=value)) +
  geom_smooth(aes(colour=geo.description), lwd=1.5) +
  facet_wrap( "indic.description", scales="free_y") +
  labs(title=paste(dt$description,
                   eus.dic.get.description('s_adj', 'NSA'), sep='\n')
       ) +
  theme_bw()
print(q)

