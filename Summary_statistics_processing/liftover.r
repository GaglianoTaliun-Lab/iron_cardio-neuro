data <- readr::read_delim("path",
                                   delim = " ",
                                   col_types =
                                     readr::cols(
                                       CHR = readr::col_factor(),
                                       BP = readr::col_integer()
                                     )
)
library(rutils)
data_converted <-
  liftover_coord(
    df = data %>%
      dplyr::select(CHR , BP , Allele1 , Allele2 , AF_Allele2 , imputationInfo, N, BETA , SE , Tstat , p.value ,varT),
    path_to_chain = "/path/hg38ToHg19.over.chain"
  )
write.table(data_converted, file = "/outputpath/", sep = "\t",row.names = FALSE, col.names = TRUE)


