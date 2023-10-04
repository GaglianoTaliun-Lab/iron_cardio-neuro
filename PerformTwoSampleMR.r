version R 4.3.1


library(TwoSampleMR)
library(ggplot2)
library(MRPRESSO)



#import the exposure data in this case our exposure is iron
iron_exp_dat <- read_exposure_data(
    filename = "//path to exposure data//",
    sep = "\t",
    snp_col = "//SNP column name//",
    beta_col = "//beta column name//",
    se_col = "//se column name//",
    effect_allele_col = "//effect_allele column name//"",
    other_allele_col = "//other_allele column name//"",
    eaf_col = "//eaf column name//",
    pval_col = "//pval column name//",
    samplesize_col = "//sample size column name//"
)

iron_exp_dat$exposure <- "iron"

#Selection of instruments for MR analysis


iron_inst_AD <- iron_exp_dat[iron_exp_dat$SNP %in% c('rs186149452','rs574916933','rs147493146','rs3129803','rs12205407','rs562809762','rs2005682','rs558565346','rs2076085','rs1961660','rs12534526','rs7655524','rs7627907','rs77262773','rs1958078','rs183315458','rs199710259','rs2075672','rs7587033','rs4759827','rs8177252','rs553450815','rs61804206','rs6726348'), ]


#import the outcome data in this case our outcome is AD

outcome_AD <- read_outcome_data(
    snps = iron_inst_AD$SNP,
    filename = "//path to outcome data",
    sep = "\t",
    snp_col = "//SNP column name//",
    beta_col = "//beta column name//",
    se_col = "//se column name//",
    effect_allele_col = "//effect_allele column name//"",
    other_allele_col = "//other_allele column name//"",
    eaf_col = "//eaf column name//",
    pval_col = "//pval column name//",
    samplesize_col ="//sample size column name//"
)

outcome_AD$outcome <- "AD"


# harmonise the exposure data and the outcome data

dat_AD <- harmonise_data(
    exposure_dat = iron_inst_AD, 
    outcome_dat = outcome_AD)


#heterogeneity test
mr_heterogeneity(dat_AD)

# pleiotropy test
mr_pleiotropy_test(dat_AD)


#Perform MR 
res_AD<-mr(dat_AD)
res_AD

res_single_AD <- mr_singlesnp(dat_AD, all_method = c("mr_weighted_median","mr_ivw", "mr_weighted_mode","mr_egger_regression"))
res_single_AD


# MR PRESSO test

mr_presso(BetaOutcome = "beta.outcome", BetaExposure = "beta.exposure", SdOutcome = "se.outcome", SdExposure = "se.exposure", OUTLIERtest = TRUE, DISTORTIONtest = TRUE, data = dat_AD)


#Scatter plot 
p_ad<- mr_scatter_plot(res_AD, dat_AD)
ggsave(p_ad[[1]], file = "path to output file")


#Forest plot 
p2_ad<- mr_forest_plot(res_single_AD)
ggsave(p2_ad[[1]], file = "path to output file")
