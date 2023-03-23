#! /bin/bash -l
#SBATCH -A snic2021-5-20
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 02:00:00
#SBATCH -J Linkage_map_vanessa_ref
#SBATCH -e Linkage_map_vanessa_ref_index_DTOL.error
#SBATCH --mail-user karin.nasvall@ebc.uu.se
#SBATCH --mail-type=ALL

module load bioinfo-tools 
module load bwa/0.7.17

cd /proj/uppstore2017185/b2014034_nobackup/Karin/link_map_vanessa/data/vanessa_assembly_dtol/genome_assemblies_genome_fasta/ncbi-genomes-2021-03-13/

bwa index GCA_905220365.1_ilVanCard2.1_genomic.fna.gz
