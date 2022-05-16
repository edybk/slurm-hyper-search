#!/bin/bash

#SBATCH --ntasks=1


#SBATCH --gpus=1

#SBATCH --qos=normal

#SBATCH -t 12:00:00  # time requested in hour:minute:se

eval "$(/home/bedward/anaconda3/bin/conda shell.bash hook)"
conda activate surgical-landmarks

which python

# srun --container-image ~/nvidia+pytorch+21.11-py3.sqsh 

# export TMPDIR=/scratch/surgical-handmarks/tmp

DIR=$1
PARAMS_OFFSET=$2

PARAMS_FILE="${DIR}/params"
RESULTS_FILE="${DIR}/results"
RUNLOG_FILE="${DIR}/runlog"

if [ -z "$PARAMS_OFFSET" ]
then
    PARAMS_OFFSET=0
fi

if [ ! -d "$DIR" -o ! -f "$PARAMS_FILE" ]
then
    echo "Usage: $0 DIR [PARAMS_OFFSET]"
    echo "where DIR is a directory containing a file 'params' with the parameters."
    exit 1
fi

PARAMS_ID=$(( $SLURM_ARRAY_TASK_ID + $PARAMS_OFFSET ))
JOB_NAME="${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}"

echo "$PARAMS_ID|$JOB_NAME|$SLURM_SUBMIT_DIR" >> $RUNLOG_FILE

PARAMS=$(tail -n +${PARAMS_ID} ${PARAMS_FILE} | head -n 1)

echo "*** TRAIN ***"
MODEL_FILE=$(mktemp)

python train.py --output-file $MODEL_FILE

#-action train --model TCN2 --dataset apas_tcn_v2 --num_epochs 200 --features_dim 96 $PARAMS --split all --custom-features smooth_final --eval-rate 5 --output-file $MODEL_FILE

# exit if training failed
test $? -ne 0 && exit 1

echo "*** TEST ***"
# we assembled the needed data to a single line in $TMPFILE
TMPFILE=$(mktemp)
echo -n "$PARAMS_ID|$PARAMS|$JOB_NAME|$BN|" > $TMPFILE

python eval.py ${MODEL_FILE} | tr '\n\t' '| ' >> $TMPFILE
echo >> $TMPFILE

# only at the end we append it to the results file
cat $TMPFILE >> $RESULTS_FILE

# cleanup
rm $TMPFILE
rm ${MODEL_FILE}


