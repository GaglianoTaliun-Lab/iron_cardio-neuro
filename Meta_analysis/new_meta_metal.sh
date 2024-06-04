

#  THE FIRST BENYAMIN FILE
MARKER chpos
ALLELE A1 A2
EFFECT EFFECT_A1
PVALUE P
WEIGHT N
PROCESS /home/wuaame/projects/def-gsarah/wuaame/final_metal/final/iron_benyamin.txt


#THE SECOND BLSA FILE
MARKER SNP
ALLELE A1 A2
EFFECT BETA
PVALUE P
WEIGHT NMISS
PROCESS /home/wuaame/projects/def-gsarah/wuaame/final_metal/final/iron_BLSA.txt


#THE THIRD ICM FILE
MARKER chpos
ALLELE Allele2 Allele1
EFFECT BETA
PVALUE Pvalue
WEIGHT N
PROCESS /home/wuaame/projects/def-gsarah/wuaame/iron_icm.txt

#THE FOURTH MOKSNES FILE

MARKER chpos
ALLELE effect_allele other_allele
EFFECT beta
PVALUE p_value
WEIGHT N
PROCESS /home/wuaame/projects/def-gsarah/wuaame/moksnes/iron_moksens37.txt


OUTFILE METANALYSIS.tbl
AVERAGEFREQ ON
MINMAXFREQ ON
ANALYZE


