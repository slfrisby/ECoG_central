#!/bin/bash
echo "
++++++++++++++++++++++++" 

#p is set in sub_job.sh 
#p=$1
dirp=/group/mlr-lab/Saskia/ECoG_central
work=/group/mlr-lab/Saskia/ECoG_central/work

# runs hands-off section of preprocessing 
matlab_r2023b -nodisplay -nodesktop -r "addpath('$dirp/src/');preprocess('"$p"');exit"



