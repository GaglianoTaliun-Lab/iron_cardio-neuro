arg=commandArgs(T); df.file=arg[1]; out.file=arg[2]
library(biomaRt)

# Initialize a connection to the Ensembl database
ensembl = useEnsembl(biomart="ensembl", dataset="hsapiens_gene_ensembl", GRCh=37)
 
retrieve_data <- function(row) {
  result <- getBM(
    attributes = c("entrezgene_id", "external_gene_name"),
    filters = c("chromosome_name", "start", "end", "biotype"),
    values = list(row['chr'], row['start'], row['stop'], "protein_coding"),
    mart = ensembl
  )
  
  if (nrow(result) > 0) {
    ensembl_gene_ids <- as.character(result$entrezgene_id)
    gene_names <- as.character(result$external_gene_name)
    row['ensembl_gene_ids'] <- paste(ensembl_gene_ids, collapse = ", ")
    row['gene_names'] <- paste(gene_names, collapse = ", ")
  } else {
    row['ensembl_gene_ids'] <- NA
    row['gene_names'] <- NA
  }
  
  return(row)
}


df=read.table(df.file, header=TRUE, sep='\t', dec='.')
# Use the apply function to retrieve data for each row and store it in new columns
df <- t(apply(df, 1, retrieve_data))

write.table(df, file = out.file, sep = "\t",row.names = FALSE, col.names = TRUE, quote=FALSE)

