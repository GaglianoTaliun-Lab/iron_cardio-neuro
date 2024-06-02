library(tidyverse)
library(here)
library(gghighlight)
library(stringr)
library(reshape2)
library(corrplot)
library(gridExtra)
library(ggpubr)

process_file <- function(file_name, phen2) {
  df <- read.csv(file_name, sep=" ")
  df$p_bonf <- 0.05 / nrow(df)
  df$phen1 <- 'Iron'
  df$phen2 <- phen2
  return(df)
}

# List of files and corresponding phenotypes
files <- list(
  "IRON.LDL.bivar.lava" = "LDL",
  "IRON.HDL.bivar.lava" = "HDL",
  "IRON.nonHDL.bivar.lava" = "nonHDL",
  "IRON.TG.bivar.lava" = "TG",
  "IRON.TC.bivar.lava" = "TC",
  "HF_IRON_corr.bivar.lava" = "HF",
  "IRON.AD.bivar.lava" = "AD",
  "IRON.CAD.bivar.lava" = "CAD",
  "IRON.PD.bivar.lava" = "PD",
  "SLA_IRON_corr.bivar.lava" = "SLA",
  "STROKE_IRON_corr.bivar.lava" = "STROKE"
)

# Process all files and combine into a single data frame
all_data <- do.call(rbind, lapply(names(files), function(file) {
  process_file(file, files[[file]])
}))

########################18#######################

bivar_to_plot <-
  all_data %>%
  dplyr::filter(., locus == 950) %>%
  tidyr::separate(phen1, c("phen1_clean", NA), sep = "_") %>%
  tidyr::separate(phen2, c("phen2_clean", NA), sep = "_") %>%
  mutate(., order_phen1 = factor(phen1_clean, levels = c("AD","PD","CAD","ALS","LDL","HDL","TC",'TG','HF','Stroke','nonHDL')),
         fill_rho = case_when(
           p < 0.05 ~ round(rho, 2)
         ),
         sig = case_when(
           p < p_bonf ~ "**"
         ),
         nom_sig = case_when(
           p < 0.05 & p >= p_bonf ~ "s",
         ),
         not_sig = case_when(
           p >= 0.05 ~ "ns"
         ),
         chr_pos = str_c("chr ",chr,": ", start, "-", stop)
  )

plot_950 <- ggplot(bivar_to_plot, aes(x=phen2_clean, y=phen1_clean)) + 
  geom_count(colour = "black", shape = 15, size = 10) +
  geom_count(aes(colour = fill_rho), shape = 15, size = 9) +
  coord_fixed() +
  theme_bw() +
  scale_colour_distiller(
    palette = "RdYlBu",
    limits = c(-1, 1), breaks = c(-1,0,1), na.value = "grey") +
  labs(x = "", y = "", title = "") +
  guides(colour = guide_colourbar(title = "Regional rg")) +
  theme(axis.text.x = element_text(size = 13, angle = 90, hjust = 0.5, vjust = 0.5,colour = "black"),
        axis.text.y = element_text(size = 13,colour = "black"),
        axis.title.x = element_text(size =11,colour = "black"),
        axis.title.y = element_text(size = 11,colour = "black"),
        legend.title = element_text(size = 13,colour = "black"),
        legend.text = element_text(size = 13,colour = "black"),
        strip.text.x = element_text(size = 12),
        strip.text.y = element_text(size = 13)) +
  geom_text(aes(label=sig), size = 4, vjust = 0.75) +
  geom_text(aes(label=nom_sig), size = 6, vjust = 0.1) +
  geom_text(aes(label=not_sig), size = 5, vjust = 0.4) +
  coord_flip() +
  facet_wrap(~chr_pos)


#/////

bivar_to_plot <-
  all_data %>%
  dplyr::filter(., locus == 965) %>%
  tidyr::separate(phen1, c("phen1_clean", NA), sep = "_") %>%
  tidyr::separate(phen2, c("phen2_clean", NA), sep = "_") %>%
  mutate(., order_phen1 = factor(phen1_clean, levels = c("maladie d'Alzheimer","maladie de Parkinson","maladie coronarienne","SLA","cholestérol de lipoprotéine à faible densité","cholestérol de lipoprotéines à haute densité","cholestérol total","Triglycérides")),
         fill_rho = case_when(
           p < 0.05 ~ round(rho, 2)
         ),
         sig = case_when(
           p < p_bonf ~ "**"
         ),
         nom_sig = case_when(
           p < 0.05 & p >= p_bonf ~ "s",
         ),
         not_sig = case_when(
           p >= 0.05 ~ "ns"
         ),
         chr_pos = str_c("chr ",chr,": ", start, "-", stop)
  )

plot_965<- ggplot(bivar_to_plot, aes(x=phen2_clean, y=phen1_clean)) + 
  geom_count(colour = "black", shape = 15, size = 10) +
  geom_count(aes(colour = fill_rho), shape = 15, size = 9) +
  coord_fixed() +
  theme_bw() +
  scale_colour_distiller(
    palette = "RdYlBu",
    limits = c(-1, 1), breaks = c(-1,0,1), na.value = "grey") +
  labs(x = "", y = "", title = "") +
  guides(colour = guide_colourbar(title = "Regional rg")) +
  theme(axis.text.x = element_text(size = 13, angle = 90, hjust = 0.5, vjust = 0.5,colour = "black"),
        axis.text.y = element_text(size = 13,colour = "black"),
        axis.title.x = element_text(size =11,colour = "black"),
        axis.title.y = element_text(size = 11,colour = "black"),
        legend.title = element_text(size = 13,colour = "black"),
        legend.text = element_text(size = 13,colour = "black"),
        strip.text.x = element_text(size = 12),
        strip.text.y = element_text(size = 13)) +
  geom_text(aes(label=sig), size = 5, vjust = 0.75) +
  geom_text(aes(label=nom_sig), size = 6, vjust = 0.1) +
  geom_text(aes(label=not_sig), size = 5, vjust = 0.4) +
  coord_flip() +
  facet_wrap(~chr_pos)

#######################################


bivar_to_plot <-
  all_data %>%
  dplyr::filter(., locus == 955) %>%
  tidyr::separate(phen1, c("phen1_clean", NA), sep = "_") %>%
  tidyr::separate(phen2, c("phen2_clean", NA), sep = "_") %>%
  mutate(., order_phen1 = factor(phen1_clean, levels = c("maladie d'Alzheimer","maladie de Parkinson","maladie coronarienne","SLA","cholestérol de lipoprotéine à faible densité","cholestérol de lipoprotéines à haute densité","cholestérol total","Triglycérides")),
         fill_rho = case_when(
           p < 0.05 ~ round(rho, 2)
         ),
         sig = case_when(
           p < p_bonf ~ "**"
         ),
         nom_sig = case_when(
           p < 0.05 & p >= p_bonf ~ "s",
         ),
         not_sig = case_when(
           p >= 0.05 ~ "ns"
         ),
         chr_pos = str_c("chr ",chr,": ", start, "-", stop)
  )

plot_955<- ggplot(bivar_to_plot, aes(x=phen2_clean, y=phen1_clean)) + 
  geom_count(colour = "black", shape = 15, size = 10) +
  geom_count(aes(colour = fill_rho), shape = 15, size = 9) +
  coord_fixed() +
  theme_bw() +
  scale_colour_distiller(
    palette = "RdYlBu",
    limits = c(-1, 1), breaks = c(-1,0,1), na.value = "grey") +
  labs(x = "", y = "", title = "") +
  guides(colour = guide_colourbar(title = "Regional rg")) +
  theme(axis.text.x = element_text(size = 13, angle = 90, hjust = 0.5, vjust = 0.5,colour = "black"),
        axis.text.y = element_text(size = 13,colour = "black"),
        axis.title.x = element_text(size =11,colour = "black"),
        axis.title.y = element_text(size = 11,colour = "black"),
        legend.title = element_text(size = 13,colour = "black"),
        legend.text = element_text(size = 13,colour = "black"),
        strip.text.x = element_text(size = 12),
        strip.text.y = element_text(size = 13)) +
  geom_text(aes(label=sig), size = 5, vjust = 0.75) +
  geom_text(aes(label=nom_sig), size = 6, vjust = 0.1) +
  geom_text(aes(label=not_sig), size = 5, vjust = 0.4) +
  coord_flip() +
  facet_wrap(~chr_pos)


#######################################

bivar_to_plot <-
  all_data %>%
  dplyr::filter(., locus == 951) %>%
  tidyr::separate(phen1, c("phen1_clean", NA), sep = "_") %>%
  tidyr::separate(phen2, c("phen2_clean", NA), sep = "_") %>%
  mutate(., order_phen1 = factor(phen1_clean, levels = c("maladie d'Alzheimer","maladie de Parkinson","maladie coronarienne","SLA","cholestérol de lipoprotéine à faible densité","cholestérol de lipoprotéines à haute densité","cholestérol total","Triglycérides")),
         fill_rho = case_when(
           p < 0.05 ~ round(rho, 2)
         ),
         sig = case_when(
           p < p_bonf ~ "**"
         ),
         nom_sig = case_when(
           p < 0.05 & p >= p_bonf ~ "s",
         ),
         not_sig = case_when(
           p >= 0.05 ~ "ns"
         ),
         chr_pos = str_c("chr ",chr,": ", start, "-", stop)
  )

plot_951<- ggplot(bivar_to_plot, aes(x=phen2_clean, y=phen1_clean)) + 
  geom_count(colour = "black", shape = 15, size = 10) +
  geom_count(aes(colour = fill_rho), shape = 15, size = 9) +
  coord_fixed() +
  theme_bw() +
  scale_colour_distiller(
    palette = "RdYlBu",
    limits = c(-1, 1), breaks = c(-1,0,1), na.value = "grey") +
  labs(x = "", y = "", title = "") +
  guides(colour = guide_colourbar(title = "Regional rg")) +
  theme(axis.text.x = element_text(size = 13, angle = 90, hjust = 0.5, vjust = 0.5,colour = "black"),
        axis.text.y = element_text(size = 13,colour = "black"),
        axis.title.x = element_text(size =11,colour = "black"),
        axis.title.y = element_text(size = 11,colour = "black"),
        legend.title = element_text(size = 13,colour = "black"),
        legend.text = element_text(size = 13,colour = "black"),
        strip.text.x = element_text(size = 12),
        strip.text.y = element_text(size = 13)) +
  geom_text(aes(label=sig), size = 5, vjust = 0.75) +
  geom_text(aes(label=nom_sig), size = 6, vjust = 0.1) +
  geom_text(aes(label=not_sig), size = 5, vjust = 0.4) +
  coord_flip() +
  facet_wrap(~chr_pos)

#######################################
ggarrange(plot_950,plot_965,plot_955,plot_951,
          ncol = 2, nrow = 2)

ggsave("Regions_of_interest.png",width = 200, height = 100, units = "cm")

