#!/usr/bin/env bash

# For each file with the structure $1.f*.gz checks if a .ktab exists, and if not creates it for a certain k

# Careful with the / at the end of the path (do not use)

cwd=$(pwd)
f=($1/*.gz)
echo $cwd
for ((i = 0; i < ${#f[@]}; i++)); do 
        if ! [[ -f "${f[i]%.f*.gz}".ktab ]]; then
        mkdir -p ppp$i
             sbatch -c 8 -t 08:00:00 --wrap="FastK -k17 -Pppp$i -t1 ${f[i]}; Tabex "${f[i]%.f*.gz}".ktab LIST > "${f[i]%.f*.gz}"_17_all"; 
       fi    
done 


