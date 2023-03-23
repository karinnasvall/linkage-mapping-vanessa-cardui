#script for multiple MarkerOrder runs
#OBS! Have to change nr of iterations and nr of linkage groups in the loop and in loop retrieving maps
#run with bash Desktop/Link_map/scripts/LepMap3_order_5_fam_noradtag_swe.sh lodlim_sepchrom lodlim_js

#specify input and output files and directories
#Change these !!!
#prefix and main directory
PREFIX=

#input path for main directory
INPUT_PATH=.

#Called data from ParentCall or Filtering
DATA_CALL=data.call

#number of linkage groups
#LG=31
array_lg=(31)

INPUT_DATA=$INPUT_PATH/$DATA_CALL
OUTPUT_PATH=$INPUT_PATH/chr_54_55/last_reeval_55/Ordermarker_reeval_thin_mod2

mkdir $OUTPUT_PATH

#the map from JoinSingles that is most optimal
#MAP_FILE=$INPUT_PATH/JoinSingles_map_${LOD_LIM}_${PREFIX}/${PREFIX}_${LOD_LIM}_${LOD_LIM_JS}.js.map


#make a file with genome position for all markers
#cut -f1-2 $INPUT_DATA | awk 'NR>7{print $0}' > $INPUT_PATH/snps_${DATA_CALL}.txt

#run ordermarker

#5 iterations
for i in {1..5}
do 
#for nr of lg
for lg in ${array_lg[@]}
do
INPUT_FILE=$(ls chr_54_55/last_reeval_55/Ordermarker_reeval_thin/ordered.31.1.intervals_mod.mapped)

java -Xmx2048m -cp /Applications/lepmap3/bin OrderMarkers2\
 data=$INPUT_DATA\
 evaluateOrder=$INPUT_FILE\
 improveOrder=1\
 calculateIntervals=$OUTPUT_PATH/ordered.${lg}.${i}.intervals\
 numThreads=2\
 recombination2=0\
 chromosome=${lg}\
 > $OUTPUT_PATH/ordered.${lg}.${i}.intervals.log1 2> $OUTPUT_PATH/ordered.${lg}.${i}.intervals.log2
wait

#maps the markers to genomic coordinates
awk '(NR==FNR){s[NR]=$0}(NR!=FNR){if ($1 in s) $4=s[$1];print}' $INPUT_PATH/snps.txt $OUTPUT_PATH/ordered.${lg}.${i}.intervals > $OUTPUT_PATH/ordered.${lg}.${i}.intervals.mapped

done
done


#if no iterations (i=1) and comment away likelihood comparisons
#i=1

grep "likelihood =" $OUTPUT_PATH/ordered.*.intervals.log1 > $OUTPUT_PATH/likelihoods.txt
#make a list of best likelihoods

#OBS!! Set nr according to nr of lg
#for lg in $(seq 1 1 $LG); do 
#file=$(awk -v lg=$lg 'NR==lg' $OUTPUT_PATH/list_best_likelihoods.txt| cut -f1 -d ":" |sed 's/\.log1//g')
#awk -v lg=$lg '{print $4, $5, $6=lg, $1, $2, $3}' $file | sed 's/\*//g' >> $OUTPUT_PATH/order_all_int.txt
#done

#awk 'BEGIN{print "scaffold position lg marker_nr min_int max_int"}{print $0}' $OUTPUT_PATH/order_all_int.txt > $OUTPUT_PATH/${PREFIX}_order_all_int.table
