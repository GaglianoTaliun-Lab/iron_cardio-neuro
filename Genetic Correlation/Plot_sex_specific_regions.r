library(karyoploteR)
library(ggplot2)

library(dplyr)
library(GenomicRanges)

# Function to generate rows
generate_rows <- function(row) {
  if (row$rho >= 0) {
    rho_values <- seq(0, row$rho, by = 0.005)
  } else {
    rho_values <- seq(row$rho, 0, by = 0.005)
  }
  row_count <- length(rho_values)

  data.frame(
    locus = rep(row$locus, row_count),
    chr = rep(row$chr, row_count),
    start = rep(row$start, row_count),
    stop = rep(row$stop, row_count),
    n.snps = rep(row$n.snps, row_count),
    n.pcs = rep(row$n.pcs, row_count),
    phen1 = rep(row$phen1, row_count),
    phen2 = rep(row$phen2, row_count),
    rho = rho_values,
    rho.lower = rep(row$rho.lower, row_count),
    rho.upper = rep(row$rho.upper, row_count),
    r2 = rep(row$r2, row_count),
    r2.lower = rep(row$r2.lower, row_count),
    r2.upper = rep(row$r2.upper, row_count),
    p = rep(row$p, row_count)
  )
}

# Function to read data from a file and generate rows
read_and_generate_rows <- function(file_path) {
  data <- read.table(file_path, header = TRUE, sep = ' ', dec = '.')

  expanded_data <- data %>%
    rowwise() %>%
    do(generate_rows(.))

  expanded_data$chr <- paste("chr", expanded_data$chr, sep = "")

  gr_data <- GRanges(
    seqnames = expanded_data$chr,
    ranges = IRanges(start = expanded_data$start, end = expanded_data$stop),
    pval = expanded_data$rho
  )

  expanded_data$p_bonf <- 0.05 / nrow(data)
  bonf_data <- expanded_data[expanded_data$p < expanded_data$p_bonf, ]

  gr_bonf_data <- GRanges(
    seqnames = bonf_data$chr,
    ranges = IRanges(start = bonf_data$start, end = bonf_data$stop),
    pval = bonf_data$rho
  )

  return(list(data = gr_data, bonf_data = gr_bonf_data))
}

# Command-line arguments
args <- commandArgs(trailingOnly = TRUE)

# Check if the correct number of arguments is provided
if (length(args) != 3) {
  stop("Usage: Rscript script.R pd_male_path pd_female_path disease_name")
}

# Paths to the text files
df_male_path <- args[1]
df_female_path <- args[2]
disease_name <- args[3]

# Generate data for male and female
df_male_data <- read_and_generate_rows(df_male_path)
df_female_data <- read_and_generate_rows(df_female_path)

# Output plot to a PNG file
png(sprintf("%s_lava.png", disease_name), width = 1500, height = 800)

# PlotKaryotype for male data
kp<- plotKaryotype(plot.type = 4)
kpAddMainTitle(kp, main = sprintf("Regions of local correlations between iron and %s ", disease_name))
kp <- kpPlotManhattan(kp, data = df_male_data$data, r0 = 0.5, r1 = 1, ymax = 1, logp = FALSE,
                      highlight = df_male_data$bonf_data, suggestiveline = 0, highlight.col = "red")

# PlotKaryotype for female data
kp <- kpPlotManhattan(kp, data = df_female_data$data, r0 = 0.5, r1 = 0, ymax = 1, logp = FALSE,
                      highlight = df_female_data$bonf_data, suggestiveline = 0, highlight.col = "red")

legend(x = "bottomright", fill = c("red"), legend = c("regions identified at Bonferroni-adjusted significance threshold"))
# Save the plot
dev.off()

