#!/bin/bash

#SBATCH --ntasks=1


#SBATCH --gpus=1

#SBATCH --qos=basic

#SBATCH -t 24:00:00  # time requested in hour:minute:se

eval "$(/home/bedward/anaconda3/bin/conda shell.bash hook)"
conda activate surgical-landmarks

PARAMS=$1

cd /home/bedward/workspace/eddie/surgical-handmarks
python run.py $params


