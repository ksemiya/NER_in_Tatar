#!/bin/bash
#SBATCH -c 2 -G 1
#SBATCH --output=result_2.out
module load Python/Anaconda_v10.2019

source deactivate
source activate ksemiya_env_1

export MAX_LENGTH=128
export BERT_MODEL=bert-base-multilingual-cased
export OUTPUT_DIR=germeval-model
export BATCH_SIZE=32
export NUM_EPOCHS=3
export SAVE_STEPS=750
export SEED=1
python run_ner.py --data_dir ./ \
--model_type bert \
--labels ./labels.txt \
--model_name_or_path $BERT_MODEL \
--output_dir $OUTPUT_DIR \
--max_seq_length  $MAX_LENGTH \
--num_train_epochs $NUM_EPOCHS \
--per_gpu_train_batch_size $BATCH_SIZE \
--save_steps $SAVE_STEPS \
--seed $SEED \
--do_train \
--do_eval \
--do_predict


