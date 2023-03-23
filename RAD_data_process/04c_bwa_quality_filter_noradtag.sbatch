#!/bin/bash -l

#SBATCH -A snic2021-5-20
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 12:00:00
#SBATCH -J linkage_map_vanessa_ref
#SBATCH -e linkage_map_vanessa_ref_q10_uniq_noradtag.error
#SBATCH --mail-user karin.nasvall@ebc.uu.se
#SBATCH --mail-type=ALL

module load bioinfo-tools
module load samtools/1.9

cd /proj/uppstore2017185/b2014034_nobackup/Karin/link_map_vanessa/working/

INPUT_PATH=/proj/uppoff2020002/private/group_member_backups/KarinN/projects/2019_04_linkmap_vanessa/output/04_bwa_bam_noradtag/
OUTPUT_PATH=../output/bwa_noradtag_filtered/
mkdir $OUTPUT_PATH

ls $INPUT_PATH/*.bam > list_input_bam_filter.txt

for file in $(cat list_input_bam_filter.txt | tail -n 41)
do
baseFilename=`basename $file .sorted.bam`

samtools view -h -q 10 $file | grep -v -e "XA:Z:" -e "SA:Z:" | samtools view -b -h  > $OUTPUT_PATH/${baseFilename}.filtered.bam
samtools flagstat $OUTPUT_PATH/${baseFilename}.filtered.bam > $OUTPUT_PATH/${baseFilename}_flagstat.txt 
done
wait

#-q 10 Skip alignments with MAPQ smaller than INT [0]. Set to 10 due to recommended pipeline for LepMap3:
#samtools mpileup -q 10 -Q 10 -s $(cat sorted_bams)|java -cp bin/ Pileup2Likelihoods|gzip >post.gz
