#!/bin/bash -l

#SBATCH -A snic2021-5-20
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 24:00:00
#SBATCH -J linkage_map_vanessa_ref_qualimap
#SBATCH -e linkage_map_vanessa_ref_qualimap2.error
#SBATCH --mail-user karin.nasvall@ebc.uu.se
#SBATCH --mail-type=ALL

module load bioinfo-tools
module load R/4.0.0
module load R_packages/4.0.0
module load QualiMap/2.2.1

cd /proj/uppstore2017185/b2014034_nobackup/Karin/link_map_vanessa/working

OUT_DIR=/proj/uppstore2017185/b2014034_nobackup/Karin/link_map_vanessa/output/04f_qualimap_noradtag
INPUT_LIST=input_bam_qualimap_noradtag.txt

mkdir $OUT_DIR

unset DISPLAY
qualimap multi-bamqc -c -d $INPUT_LIST -outdir $OUT_DIR -r

