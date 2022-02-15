#!/usr/bin/env bash

# Exits a table with unique kmers and total kmers for one 
# genome for a range of k values

# Stop at any error
set -eo pipefail

cwd=$(pwd)

echo 
SECONDS=0
g1=false
output_folder=temp
maxk=17
show_help=false 

# read the options
cmd=$0" "$@
TEMP=`getopt -o i:o:m:h: -l genome:,output-folder:,max-k:,help: -n 'ukmers_check' -- "$@"`
eval set -- "$TEMP"

# extract options and their arguments into variables.
while true ; do
    case "$1" in
        -i|--genome) g1=$2 ; shift 2 ;;
        -o|--output-folder) output_folder=$2 ; shift 2 ;;
        -m|--max-k) maxk=$2 ; shift 2 ;;
        -h|--help) show_help=true ; shift ;;
        --) shift ; break ;;
        *) echo "$2" "Internal error!" ; exit 1 ;;
    esac
done


if [[
     $g1 == false
   ]];
then
    show_help=true
    >&2 echo "Mandatory argument -i"
fi



if [ $show_help == true ];
then
    echo "options:"
    echo "    -i, --genome             file    Genome to analyse"
    echo "    -o, --output-folder      dir     Output folder"
    exit
fi

mkdir -p $output_folder
cd $output_folder

gs1="${g1%.fa}"  # Removes .fa
name1="${gs1##*/}"  # Removes path until filename

echo
echo "==> Genome: $name1"
echo "==> Output folder: $output_folder"
echo
echo "=================================================="
echo

cd $cwd

for i in $(seq 11 2 $maxk); do 
                FastK -k$i -t1 $g1
                Tabex "$gs1".ktab LIST > "$name1"_all
                echo $i `awk '$4 ==1 { count++ } END { print "\t" count "\t" NR-1}' "$name1"_all` >> "$name1"_stats
done

