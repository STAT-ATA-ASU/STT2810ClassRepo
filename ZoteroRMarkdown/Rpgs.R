# Creating R packages Bib file --- updated 1/14/15 
RpackagesUsed <- c('knitcitations', 'knitr', 'roxygen2', 'PASWR2')
library(knitr)
write_bib(RpackagesUsed, file = './ZoteroRMarkdown/Rpkgs.bib')
