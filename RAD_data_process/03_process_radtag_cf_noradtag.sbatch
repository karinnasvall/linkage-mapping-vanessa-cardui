#!/bin/bash -l

#SBATCH -A snic2021-5-20
#SBATCH -p core
#SBATCH -n 10
#SBATCH -t 24:00:00
#SBATCH -J linkmap_vanessa
#SBATCH -e linkmap_vanessa_process_radtag_noradtag.error
#SBATCH --mail-user karin.nasvall@ebc.uu.se
#SBATCH --mail-type=ALL

module load bioinfo-tools
module load Stacks/2.2
module load FastQC/0.11.8
module load MultiQC/1.9

cd /proj/uppstore2017185/b2014034_nobackup/Karin/link_map_vanessa/working/

#copy data files to temporary directory
cp ../output/02_clone_filter_raw/*.fq.gz $SNIC_TMP

input_path=$SNIC_TMP
mkdir $SNIC_TMP/output/

output_path=/proj/uppoff2020002/private/group_member_backups/KarinN/projects/2019_04_linkmap_vanessa/output/03_process_radtag_cf_noradtag/
mkdir $output_path


for R1 in $(cat list_cf_files_R1.txt); do # Loop to iterate over all read 1 files
  R2=$(echo $R1 | sed 's/R1_001.1/R2_001.2/g') # Assuming that your R1 and R2 have the same name excepting R1 for R2, assign the right name for R2 to a variable called R2
process_radtags -i gzfastq -1 $input_path/$R1 -2 $input_path/$R2 -e ecoRI --adapter_1 CTGTCTCTTATA --adapter_2 CTGTCTCTTATA --adapter_mm 2 --disable_rad_check -r -c -q -t 120 -o $SNIC_TMP/output
sleep 1
done
wait


cp $SNIC_TMP/output/* $output_path/

cd $output_path
fastqc -t 6 *.{1..2}.{1..2}.fq.gz
multiqc .

