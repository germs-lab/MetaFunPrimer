#!/bin/bash

input_file=$1
info=$(awk '{
    if(NR==1)
    {
        min = $5
        max = $5
    }
    if($5 < min)
    {
        min = $5
    }
     
}
END {
    print min","max
}' $input_file)

awk -v var=$info '
BEGIN {
    split(var, info, ",")
    min = info[1]
    max = info[2]
    OFS = "\t"
} 
{
    left = (max - $5) / NR;
    NR==20 ? right = 0: right = ($5 - min) / (20 - NR) 
    print $0 OFS left - right

}' $input_file
#mv temp gene_presences.tsv



#$opt_info=($(awk '{if(max<$3){max=$3;opt_perc=$fin;num_clusters=$2}}END{print opt_perc num_clusters}' gene_abundances.tsv) )

#echo "Optimum to include clusters up to: ${opt_info[0]}"
#echo "Number of clusters: ${opt_info[1]}"

