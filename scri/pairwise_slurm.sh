#!/usr/bin/env bash

# Computes in hpc pairwise distances of a set of genomes
# $1 is the folder where all the assemblies to be analized are stored, gz compressed.
# $2 is the lenght of kmers to use (default 17)
# $3 is the name of the file where to append the results.

cwd=$(pwd)
f=($1/*.gz)
echo $f
for ((i = 0; i < ${#f[@]}; i++)); do 
      for ((j = i + 1; j < ${#f[@]}; j++)); do   
            sbatch -c 4 -t 02:00:00 scri/ukmers_distance -1 ${f[i]} -2 ${f[j]} -f Ypotree4 -o results; 
            # sleep .1s    
      done;
  done 


