!wget -O all_texts_in_utf8_renamed_analyzed_mv1.02.zip "https://www.dropbox.com/s/akghkvur9akawhn/all_texts_in_utf8_renamed_analyzed_mv1.02.zip?dl=1"
python3 data_creating.py
export MAX_LENGTH=128
export BERT_MODEL=bert-base-multilingual-cased
export OUTPUT_DIR=germeval-model
export BATCH_SIZE=32
export NUM_EPOCHS=3
export SAVE_STEPS=750
export SEED=1
python3 run_ner.py --data_dir ./ \
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