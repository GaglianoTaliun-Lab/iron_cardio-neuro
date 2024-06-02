#Reformating Summary Statistics
python2 ./ldsc/munge_sumstats.py --sumstats summary_statistics.txt --N Sample_size --out outcome --merge-alleles ./w_hm3.snplist --snp SNP --p p_value --signed-sumstats odds_ratio,1 --a1 effect_allele --a2 other_allele

#Estimating Genetic correlation 

python2 ./ldsc/ldsc.py \
--rg exposure.sumstats.gz,outcome.sumstats.gz \
--ref-ld-chr eur_w_ld_chr/ \
--w-ld-chr eur_w_ld_chr/ \
--out exposure_outcome

#Estimating Heritability 

python2 ./ldsc/ldsc.py \
--rg exposure.sumstats.gz \
--ref-ld-chr eur_w_ld_chr/ \
--w-ld-chr eur_w_ld_chr/ \
--out exposure
