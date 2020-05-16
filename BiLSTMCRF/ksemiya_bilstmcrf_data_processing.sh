#!/bin/bash
#wget -O all_texts_in_utf8_renamed_analyzed_mv1.02.zip "https://www.dropbox.com/s/akghkvur9akawhn/all_texts_in_utf8_renamed_analyzed_mv1.02.zip?dl=1"
curl -L "https://www.dropbox.com/s/kn7foa0ndddlses/ttwiki-bio-only-entity.txt?dl=1 ttwiki-bio-only-entity.txt"
git clone https://github.com/meizhiju/layered-bilstm-crf
python3 bilstmcrf_data_creating.py

