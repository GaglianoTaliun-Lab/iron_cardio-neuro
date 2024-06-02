library(karyoploteR)
library(ggplot2)

male=read.table('male_data.txt', header=TRUE, sep='\t', dec='.')
female=read.table('female_data.txt', header=TRUE, sep='\t', dec='.')

male$CHR <- paste("chr", male$CHR, sep = "")
gr_male <- GRanges(
  seqnames = male$CHR,
  ranges = IRanges(start = male$BP, end = male$BP),
  pval=male$P.value)

female$CHR <- paste("chr", female$CHR, sep = "")
gr_female <- GRanges(
  seqnames = female$CHR,
  ranges = IRanges(start = female$BP, end = female$BP),
  pval=female$P.value)



#Annotation

gr_male_ann <- GRanges(
  seqnames =male_annotation$CHR ,
  ranges = IRanges(start = male_annotation$BP, end = male_annotation$BP),
  strand = "*",
  pval = male_annotation$P_value,
  y = -log10(male_annotation$P_value),
  color = "#888888" # 
)



female_annotation$CHR <- paste("chr", female_annotation$CHR, sep = "")
gr_female_ann <- GRanges(
  seqnames = female_annotation$CHR,
  ranges = IRanges(start = female_annotation$BP, end = female_annotation$BP),
  strand = "*",
  pval = female_annotation$P_value,
  y = -log10(female_annotation$P_value),
  color = "#888888" # 
)


png("Miami_plot.png", width = 1500, height = 700)

kp <- plotKaryotype(plot.type=4)

kpAddLabels(kp, labels = "Male", srt=90, pos=3, r0=0.6, r1=1, cex=1.5,label.margin = 0.035)
kpAddLabels(kp, labels = expression(-log[10](italic(p))), srt=90, pos=3, r0=0.6, r1=1, cex=1,label.margin = 0.0235)
kpAxis(kp, ymin=0, ymax=30, r0=0.5,tick.pos = c(5,15,30),cex=1)
kp <- kpPlotManhattan(kp, data=gr_male, r0=0.5, r1=1, ymax=30,suggestiveline=0)
kpText(kp, data = gr_male_ann, labels = names(gr_male_ann), ymax=30,r0=0.5, r1=1, pos=3)


kpAddLabels(kp, labels = "Female", srt=90, pos=3, r0=0, r1=0.5, cex=1.5, label.margin = 0.035)
kpAddLabels(kp, labels = expression(-log[10](italic(p))), srt=90, pos=3, r0=0, r1=0.5, cex=1,label.margin = 0.0235)


kpAxis(kp, ymin=0, ymax=30, r0=0.5, r1=0, tick.pos = c(5,15,30),cex=1)
kp <- kpPlotManhattan(kp, data=gr_female, r0=0.5, r1=0, ymax=30, points.col = "2blues",suggestiveline=0)

kpText(kp, data = gr_female_ann, labels = names(gr_male_ann), ymax=30, r0=0.4, r1=0,pos=3)


dev.off()


