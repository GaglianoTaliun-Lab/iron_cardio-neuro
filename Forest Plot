library(dplyr)
library(forestplot)

#Put MR results in one dataframe

result_df <- data.frame()
#input_list contain the harmonised exposure and outcome data using harmonise_data(exp_dat,out_dat)
input_list=list(dat_AD,dat_PD,dat_SLA,dat_TC,dat_TG,dat_HDL)
for (i in 1:length(input_list)) {
    result <- mr(input_list[[i]])
    outcome <- result$outcome
    exposure <- result$exposure
    method <- result$method
    nsnp <- result$nsnp
    mean <- result$b
    stderr <- result$se
    p <- result$pval
    result_row <- data.frame(outcome, exposure, method, nsnp, mean, stderr, p)
    result_df <- rbind(result_df, result_row)
}


result_df <- result_df %>% rename(labeltext = outcome)

result_df$lower <- result_df$mean - 1.96 * result_df$stderr
result_df$upper <- result_df$mean +1.96 * result_df$stderr

font ="sans"
result_df |>
group_by(method) |>
  forestplot(
fn.ci_norm = c(fpDrawNormalCI, fpDrawCircleCI,fpDrawDiamondCI,fpDrawPointCI),
             clip = c(-1, 1),
	boxsize = .15,
             vertices=TRUE,
             xlog = FALSE,xlab = "Beta Coefficients") |>
  
  fp_set_style(box = c("steelblue","darkred","royalblue","darkblue")|> lapply(function(x) gpar(fill = x, col = "#555555")),
               default = gpar(vertices = TRUE),txt_gp = fpTxtGp(label = list(gpar(fontfamily = font,cex=1.25),
                                             gpar(fontfamily = "",
                                                  col = "#660000")),
                                ticks = gpar(fontfamily = "", cex = 0.8),
                                xlab  = gpar(fontfamily = font, cex = 1.15)) )|> 


  fp_set_zebra_style("#EFEFEF")
