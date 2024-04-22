arg=commandArgs(T); df.file=arg[1]; plot.file=arg[2]; out.col=arg[3]; est.col=arg[4]; se.col=arg[5]

library(dplyr)
library(forestplot)
df=read.table(df.file, header=TRUE, sep='\t', dec='.')

df <- df %>% rename(labeltext = out.col)
mean =est.col
se=se.col


df$beta <- df$mean 
df$mean =exp(df$mean)


df$lower <- exp(df$beta - 1.96 * df$se)
df$upper <- exp(df$beta +1.96 * df$se)



df$`OR (95% CI)` <- ifelse(is.na(df$se), "",
                           sprintf("%.2f (%.2f to %.2f)",
                                   df$mean, df$lower, df$upper))
font ="sans"

png(plot.file, width = 800, height = 600)
fp_female<- df |>
  filter(Sex == "female") |>
  group_by(Method) |>
  forestplot(
    fn.ci_norm = c(fpDrawNormalCI, fpDrawCircleCI,fpDrawDiamondCI,fpDrawPointCI),
    title="Female",
    boxsize = .1,
    vertices=TRUE,
    
    xlog = TRUE,xlab = "Odds Ratio")
fp_male<- df |>
  filter(Sex == "male") |>
  group_by(Method) |>
  forestplot(
    fn.ci_norm = c(fpDrawNormalCI, fpDrawCircleCI,fpDrawDiamondCI,fpDrawPointCI),
    title="Male",
    boxsize = .1,
    vertices=TRUE,
    
    xlog = TRUE,xlab = "Odds Ratio")
library(grid)
grid.newpage()
borderWidth <- unit(4, "pt")
width <- unit(convertX(unit(1, "npc") - borderWidth, unitTo = "npc", valueOnly = TRUE)/2, "npc")
pushViewport(viewport(layout = grid.layout(nrow = 1, 
                                           ncol = 3, 
                                           widths = unit.c(width,
                                                           borderWidth,
                                                           width))
)
)
pushViewport(viewport(layout.pos.row = 1,
                      layout.pos.col = 1))
fp_female |> 
  fp_set_style(box = c("steelblue","darkred","royalblue","darkblue")|> lapply(function(x) gpar(fill = x, col = "#555555")),
               default = gpar(vertices = TRUE),txt_gp = fpTxtGp(label = list(gpar(fontfamily = font,cex=1.25),
                                                                             gpar(fontfamily = "",
                                                                                  col = "#660000")),
                                                                ticks = gpar(fontfamily = "", cex = 0.8),
                                                                xlab  = gpar(fontfamily = font, cex = 1)) )|> 
  
  
  fp_set_zebra_style("#EFEFEF")
upViewport()
pushViewport(viewport(layout.pos.row = 1,
                      layout.pos.col = 2))
grid.rect(gp = gpar(fill = "#dddddd", col = "#eeeeee"))
upViewport()
pushViewport(viewport(layout.pos.row = 1,
                      layout.pos.col = 3))
fp_male |> 
  fp_set_style(box = c("steelblue","darkred","royalblue","darkblue")|> lapply(function(x) gpar(fill = x, col = "#555555")),
               default = gpar(vertices = TRUE),txt_gp = fpTxtGp(label = list(gpar(fontfamily = font,cex=1.25),
                                                                             gpar(fontfamily = "",
                                                                                  col = "#660000")),
                                                                ticks = gpar(fontfamily = "", cex = 0.8),
                                                                xlab  = gpar(fontfamily = font, cex = 1)) )|> 
  
  
  fp_set_zebra_style("#EFEFEF")
upViewport(2)
dev.off()

