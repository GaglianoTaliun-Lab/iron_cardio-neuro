
#  THE SECOND BENYAMIN FILE
MARKER chpos
ALLELE A1 A2
EFFECT EFFECT_A1
PVALUE P
WEIGHT N
PROCESS /home/wuaame/projects/def-gsarah/wuaame/final_metal/final/benyamin_update.txt


#THE FOURTH BLSA FILE
MARKER SNP
ALLELE A1 A2
EFFECT BETA
PVALUE P
WEIGHT NMISS
PROCESS /home/wuaame/projects/def-gsarah/wuaame/final_metal/final/blsa_update.txt


#THE ICM INPUT FILE
MARKER chpos
ALLELE Allele2 Allele1
EFFECT BETA
PVALUE Pvalue
WEIGHT N
PROCESS /home/wuaame/projects/def-gsarah/wuaame/icm_converted5.txt

#THE MOKSNES INPUT FILE

MARKER chpos
ALLELE effect_allele other_allele
EFFECT beta
PVALUE p_value
WEIGHT N
PROCESS /home/wuaame/projects/def-gsarah/wuaame/moksnes/iron_moksens37_cnv3.txt


OUTFILE NEWMETANALYSIS.tbl
AVERAGEFREQ ON
MINMAXFREQ ON
ANALYZE


