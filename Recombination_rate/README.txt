#prepare maps for rec rate analysis
#use maps from LepMak3r_220120

Main script is scripts/rec_rate_plots_tables.R

#Input
#both intervals and distances from LepMap3
#For mareymaps use distances (no need to recalculate)
#check maps in r order_all_dist_mod.txt (mod because 2 uncertain markers from chr55 are removed)

#split maps per chr
awk '{print>$3}' maps_for_ms/order_all_dist_mod.txt 
#mv LR* maps_for_rearr/

#Reverse "negative" maps and start from 0 in maps where lower nr marker have been removed
#in r script

#concatenate the maps to one file
cat maps_after_rearr/* > order_dist_rearr.txt

#change order of columns, and add columns for MareyMap
awk '{print $5="Vcard", $3, $1, $4, $2}' order_dist_rearr.txt > input_marey_map_temp.txt

#final adjustments i r.script
#Use MareyMapR GUI
#first use 2 wind min 2 markers per window
#use output to check neg rec rate
#run MareyMap again unvalidate the markers causing the ned rec rate, save the new estimate as marey_output_..._corr.txt

Output in result/ folder

#continue with ../result/marey_output_..._corr.txt in r-script to get summary data of the rec rate est


