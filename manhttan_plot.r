library(ggplot2)
library(ggmanh)
###import data
Data=read.table("metal_3.txt", header = TRUE, sep = "\t", dec = ".")

# Data preprocess
Data$CHR <- as.numeric(as.character(Data$CHR))

Data$BP <- as.numeric(as.character(Data$BP))

Data$pval <- as.numeric(as.character(Data$pval))

Data$CHR[is.na(Data$CHR)]=23



## annotation
Data_ann=read.table("min_p_500k.txt", header = TRUE, sep = "\t", dec = ".")


## annotation data preprocess
Data_ann$CHR <- as.numeric(as.character(Data_ann$CHR))

Data_ann$BP <- as.numeric(as.character(Data_ann$BP))

Data_ann$pval <- as.numeric(as.character(Data_ann$pval))

Data_ann$CHR[is.na(Data_ann$CHR)]=23




##Filetring Data
#sig <- Data$SNP %in% Data_ann$SNP

# creation of label column
Data$label <- ''
#Data$label[sig] <- sprintf("%s", Data$SNP)
Data$label <- ifelse(Data$MarkerName %in%  Data_ann$MarkerName , Data$MarkerName , NA)



mpdata <- manhattan_data_preprocess(x = Data, pval.colname = "P.value", chr.colname = "CHR", pos.colname = "BP")



##plot manhattan


a <- manhattan_plot(x=mpdata ,label.colname = "label", plot.title='manhattan plot 500000' ,y.label="-log10(P)")


## Highlight points



#Save_plot

ggsave("plot_manhattan_500k.png", plot = a, dpi = 300,width = 70, height = 40, units = "cm")
