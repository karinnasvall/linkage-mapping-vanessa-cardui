#!/bin/bash -l

#SBATCH -A snic2021-5-20
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 48:00:00
#SBATCH -J linkage_map_vanessa_ref_pileup
#SBATCH -e linkage_map_vanessa_ref_pileup.error
#SBATCH --mail-user karin.nasvall@ebc.uu.se
#SBATCH --mail-type=ALL

module load bioinfo-tools
module load samtools/1.9

cd /proj/uppstore2017185/b2014034_nobackup/Karin/link_map_vanessa/output/bwa_noradtag_filtered

#ls *.bam | tr "\n" " " > list_filtered_bam.txt

samtools mpileup -q 10 -Q 10 -s $(cat list_filtered_files.txt) > mpileup.txt
java -cp ../../../programs/lep-map3-code/bin/ Pileup2Likelihoods pileup=mpileup.txt | gzip  > post.gz

#with default values (minCoverage=3, numLowerCoverage=0.3 (missing ind))
#usage: samtools mpileup -q 10 -Q10 -s $(cat sorted_bams)|java Pileup2Likelihoods [options] >post.txt
#options:
#         pileup=file          load pileup from a file [-]
#         mapping=file         load individual names (same order as bams) from a file [mapping.txt]
#         minCoverage=NUM      minimum coverage per individual [3]
#         numLowerCoverage=NUM number (or proportion) individuals allowed with lower than minCoverage [0.3]
#         minAlleleFreq=NUM    minimum number (or proportion) of an allele [0.1]
#         minQuality=NUM       minimum quality value [0.001]
#         minCoverageSum=NUM   minimum total (summed) coverage
