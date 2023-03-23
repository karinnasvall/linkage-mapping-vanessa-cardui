#glean results from Qualimap

INPUT_PATH=/proj/uppoff2020002/private/group_member_backups/KarinN/projects/2019_04_linkmap_vanessa/output/04_bwa_bam_hic_noradtag/
OUTPUT_PATH=../output/04f_qualimap_hic_noradtag

grep "HiC_scaffold" $INPUT_PATH/*_stats/genome_results.txt | cut -f4- -d "/" | sed -E 's/_stats\/genome_results.txt:|HiC_scaffold_//g' | awk 'BEGIN{print "individual scaffold length reads mean sd"}1' > $OUTPUT_PATH/reads_scaffold.txt

#mapping quality
grep "mean mapping quality"  $INPUT_PATH/*_stats/genome_results.txt |cut -f4- -d"/" > $OUTPUT_PATH/mapping_quality.txt

#number of reads
grep "number of mapped reads"  $INPUT_PATH/*_stats/genome_results.txt | cut -f4- -d"/" | tr -d "," > $OUTPUT_PATH/mapped_reads.txt
