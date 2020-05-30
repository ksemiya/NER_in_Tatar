#!/bin/bash
#TODO normal if statement

#curl -L "https://www.dropbox.com/s/kn7foa0ndddlses/ttwiki-bio-only-entity.txt?dl=1" \
#| tr '\t' ' ' > ttwiki-bio-only-entity.txt 
python3 bert_data_creating.py
cat train.txt dev.txt test.txt | cut -d " " -f 2 | grep -v "^$"| sort | uniq > labels.txt
