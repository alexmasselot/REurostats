#these two lines are equivalent to library(Eurostats).
#use devtools loading to load the package from another repository, git or install it locally
#
# check README.md to mirror the dataset

library(devtools)
load_all()

eus.toc.get.description('ei_bsbu_m_r2')
dt = eus.data.load('ei_bsbu_m_r2')

library(ggplot2)
dt.plot = subset(dt$data,
                 indic == 'BS-CTA-BAL' &
                 s_adj=='SA' &
                 geo %in% c('FR', 'DE', 'IT', 'ES', 'UK', 'BE', 'NL', 'PT', 'EU28') &
                date.year > 2000
)

q = ggplot(dt.plot, aes(x=date, y=value)) +
  geom_smooth(aes(colour=geo), lwd=1.5) +
  facet_wrap( "indic", scales="free_y") +
  theme_bw()
print(q)
