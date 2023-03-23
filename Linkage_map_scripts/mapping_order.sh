#script to mapp markers to assembly
#OBS! Have to change nr of iterations and nr of linkage groups in the loop and in loop retrieving maps

#specify input and output files and directories
INPUT_PATH=.
OUTPUT_PATH=$INPUT_PATH/mapped_order_pretrim

#INPUT_DATA=$INPUT_PATH/data.call.gz

LG=31

mkdir $OUTPUT_PATH/

#make a file with genome position for all markers
#zcat $INPUT_DATA | cut -f1-2 | awk 'NR>7{print $0}' > $INPUT_PATH/snps.txt

for lg in $(cut -f2,3 -d "/" best.likelihoods)
do
awk '(NR==FNR){s[NR]=$0}(NR!=FNR){if ($1 in s) $3=s[$1];print}' $INPUT_PATH/snps.txt $lg > ${lg}.mapped
mv ${lg}.mapped $OUTPUT_PATH/
done


#grep "likelihood" $OUTPUT_PATH/  | sort -k4g > $OUTPUT_PATH/likelihoods.txt

#make a list of best likelihoods
#sort -k7 $OUTPUT_PATH/likelihoods.txt | sort -k4 | awk 'NR%5==1' | sort -gk4 > $OUTPUT_PATH/list_best_likelihoods.txt


#set nr according to nr of lg
for i in $(seq 1 1 $LG); do 
#file=$(awk -v i=$i 'NR==i' $OUTPUT_PATH/filenames.txt| cut -f1 -d ":")
awk -v i=$i 'NR>2{print $1, $2, $3, $4, $5=i}' $OUTPUT_PATH/ordered.${i}.*.mapped | sed 's/*//g' >> $OUTPUT_PATH/order_all.txt
done
wait

awk 'BEGIN{print "marker_nr male_position scaffold position lg"}{print $0}' $OUTPUT_PATH/order_all.txt > $OUTPUT_PATH/order_all.table
