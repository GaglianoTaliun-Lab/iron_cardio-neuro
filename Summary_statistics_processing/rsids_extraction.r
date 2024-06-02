library(usethis)
library(devtools)
library(biomaRt)
library(BSgenome)
library(SNPlocs.Hsapiens.dbSNP144.GRCh37)
data=read.table("/path/", header = TRUE, sep = "\t", dec = ".")
dbsnp_144 <- SNPlocs.Hsapiens.dbSNP144.GRCh37
data_rsids<-colochelpR::convert_loc_to_rs(df=data,dbsnp_144)
write.table(data_rsids, file = "/outputpath", sep = "\t",row.names = FALSE, col.names = TRUE)

