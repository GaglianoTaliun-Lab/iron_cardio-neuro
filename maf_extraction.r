library(dplyr)
library(magrittr)
library(MafDb.1Kgenomes.phase3.hs37d5)
mafdb <- MafDb.1Kgenomes.phase3.hs37d5

data=read.table("/path/", header = TRUE, sep = "\t", dec = ".")
# data contain a rsids column
mafs <- GenomicScores::gscores(x = mafdb, ranges = data$rsids %>% as.character(), pop = "EUR_AF")
mafs <- mafs %>%
  as.data.frame() %>%
  tibble::rownames_to_column(var = "rsids") %>%
  dplyr::rename(maf = EUR_AF) %>%
  dplyr::select(rsids, maf)

data <- data %>%
  inner_join(mafs, by = c("rsids" = "rsids"))


