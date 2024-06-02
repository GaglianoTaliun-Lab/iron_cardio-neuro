library(ggplot2)
library(ggmanh)

# Load data
Data <- read.table("FOR_ANNOTATED.txt", header = TRUE, sep = "\t", dec = ".")

#chromosome colors
chromosomes_ <- c(as.character(1:23), "X")
colors_ <- c("#1E88E5", "#1A237E")
chromosome_colors <- setNames(rep(colors_, length.out = length(chromosomes_)), chromosomes_)

mpdata <- manhattan_data_preprocess(x = Data, pval.colname = "pval", chr.colname = "CHR", pos.colname = "BP",chr.order=c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "X"),chr.col = chromosome_colors,signif=5e-8)

a <- manhattan_plot(x=mpdata ,y.label="-log10(P)",label.colname = "gene",label.font.size=4)  

ggsave("manhattan_plot.png", plot = a, dpi = 300,width = 30, height = 20, units = "cm)


