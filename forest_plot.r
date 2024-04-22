arg=commandArgs(T); df.file=arg[1]; plot.file=arg[2]; out.col=arg[3]; est.col=arg[4]; se.col=arg[5]

library(dplyr)
library(forestplot)
df=read.table(df.file, header=TRUE, sep='\t', dec='.')

df <- df %>% rename(labeltext = out.col)
mean =est.col
se=se.col
df$lower <- df$mean - 1.96 * df$se
df$upper <- df$mean +1.96 * df$se

font ="sans"

png(plot.file, width = 800, height = 600)
df |>
group_by(method) |>
  forestplot( clip = c(-1.5, 1.5),
	boxsize = .11,
             xlog = FALSE,xlab = "Beta Coefficients") |>
  
  fp_set_style(box = c("steelblue","darkred","grey","darkblue")|> lapply(function(x) gpar(fill = x, col = "#555555")),
               default = gpar(vertices = TRUE),txt_gp = fpTxtGp(label = list(gpar(fontfamily = font,cex=1.8),
                                             gpar(fontfamily = "",
                                                  col = "#660000")),
                                ticks = gpar(fontfamily = "", cex = 1),
                                xlab  = gpar(fontfamily = font, cex = 1.5)) )|> 


  fp_set_zebra_style("#EFEFEF")
dev.off()

