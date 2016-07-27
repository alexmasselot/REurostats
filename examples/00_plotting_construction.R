#these two lines are equivalent to library(Eurostats).
#use devtools loading to load the package from another repository, git or install it locally
library(devtools)
load_all()
eus.toc.get.description('ei_bsbu_m_r2')
dt = eus.load.dataset('ei_bsbu_m_r2')
