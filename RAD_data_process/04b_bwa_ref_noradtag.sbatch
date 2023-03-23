#!/bin/bash -l

#SBATCH -A snic2021-5-20
#SBATCH -p core
#SBATCH -n 10
#SBATCH -t 48:00:00
#SBATCH -J linkage_map_vanessa_ref
#SBATCH -e linkage_map_vanessa_ref_bwa2.error
#SBATCH --mail-user karin.nasvall@ebc.uu.se
#SBATCH --mail-type=ALL

module load bioinfo-tools
module load samtools/1.9
module load bwa/0.7.17

cd /proj/uppstore2017185/b2014034_nobackup/Karin/link_map_vanessa/working/

assembly=../data/vanessa_assembly_dtol/genome_assemblies_genome_fasta/ncbi-genomes-2021-03-13/GCA_905220365.1_ilVanCard2.1_genomic.fna.gz
input_path=/proj/uppoff2020002/private/group_member_backups/KarinN/projects/2019_04_linkmap_vanessa/output/03_process_radtag_cf_noradtag
output_path=/proj/uppoff2020002/private/group_member_backups/KarinN/projects/2019_04_linkmap_vanessa/output/04_bwa_bam_noradtag

mkdir $output_path

#copy files to temp directory
for file in $(cat list_proc_noradtag)
do
cp $input_path/$file $SNIC_TMP/
done
wait

mkdir $SNIC_TMP/output

for file in $(cat list_proc_noradtag | grep "\.1.")
do
baseFilename=`basename $file .1.fq.gz`

bwa mem -t 10 -M $assembly $SNIC_TMP/$file $SNIC_TMP/${baseFilename}.2.fq.gz | samtools sort - -o $SNIC_TMP/output/${baseFilename}.sorted.bam

done

wait
cp $SNIC_TMP/output/* $output_path/


#bwa
#-t INT nr of threds
#-T INT default quality limit, Don’t output alignment with score lower than INT. This option only affects output. [30]
#-M 	Mark shorter split hits as secondary (for Picard compatibility). 
