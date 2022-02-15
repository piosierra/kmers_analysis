#!/usr/bin/env bash

# Computes in hpc pairwise distances of a set of genomes

cd $1
f=(*.gz)
echo $f
for ((i = 0; i < ${#f[@]}; i++)); do 
      for ((j = i + 1; j < ${#f[@]}; j++)); do     
          sbatch -c 8 -t 08:00:00 ukmers_distance -1 ${f[i]} -2 ${f[j]};     
      done;
  done 


