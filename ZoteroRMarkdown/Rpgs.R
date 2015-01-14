# Creating R packages Bib file
RpackagesUsed <- c('knitcitations', 'knitr', 'roxygen2', 'PASWR2')
library(knitr)
write_bib(RpackagesUsed, file = './hw03/Rpkgs.bib')
