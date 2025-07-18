#!/bin/bash

dirp=/group/mlr-lab/Saskia/ECoG_central
if [ ! -d $dirp/work/logs/ ]; then
mkdir -p $dirp/work/logs/
fi

# test
for q in 12; do
# run all participants
#for q in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 17 20 21 22; do

echo "$q"

# runs hands-off section of preprocessing 
sbatch -o $dirp/work/logs/"$q"preprocess.out -c 16 --job-name=ECoG_"$q" --export=p=${q} $dirp/src/sub_matlabjob.sh

done

#01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 17 20 21 22

	

