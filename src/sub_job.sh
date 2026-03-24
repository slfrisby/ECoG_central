#!/bin/bash

dirp=/group/mlr-lab/Saskia/ECoG_central
if [ ! -d $dirp/work/logs/ ]; then
mkdir -p $dirp/work/logs/
fi

# run all participants
for p in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 17 20 21 22; do

echo "$p"

# runs hands-off section of preprocessing
# standard queue
#sbatch -o "$dirp/work/logs/"$p"preprocess.out" -c 16 --job-name=ECoG_"$p" --export=p=${p} $dirp/src/sub_matlabjob.sh
# - or lopri queue 
# sbatch -o $dirp/work/logs/"$p"preprocess.out -c 16 -q lopri --job-name=ECoG_"$p" --export=p=${p} $dirp/src/sub_matlabjob.sh

# runs preprocessing following visual inspection
# standard queue
sbatch -o "$dirp/work/logs/"$p"rejectartefacts.out" -c 16 -t 7-0:00 --job-name=ECoG_"$p" --export=p=${p} $dirp/src/sub_matlabjob.sh
# - or lopri queue 
# sbatch -o $dirp/work/logs/"$p"rejectartefacts.out -c 16 -q lopri -t 7-0:00 --job-name=ECoG_"$p" --export=p=${p} $dirp/src/sub_matlabjob.sh


done

#01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 17 20 21 22

	

