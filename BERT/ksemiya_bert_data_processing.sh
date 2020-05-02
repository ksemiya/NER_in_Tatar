#!/bin/bash
#TODO normal if statement

#wget -O all_texts_in_utf8_renamed_analyzed_mv1.02.zip "https://www.dropbox.com/s/akghkvur9akawhn/all_texts_in_utf8_renamed_analyzed_mv1.02.zip?dl=1"
curl -L "https://www.dropbox.com/s/kn7foa0ndddlses/ttwiki-bio-only-entity.txt?dl=1" \
| tr '\t' ' ' > ttwiki-bio-only-entity.txt 
python3 bert_data_creating.py
cat train.txt dev.txt test.txt | cut -d " " -f 2 | grep -v "^$"| sort | uniq > labels.txt
