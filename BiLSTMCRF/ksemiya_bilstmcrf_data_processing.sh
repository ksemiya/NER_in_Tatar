#!/bin/bash
curl -L "https://www.dropbox.com/s/kn7foa0ndddlses/ttwiki-bio-only-entity.txt?dl=1 ttwiki-bio-only-entity.txt"
git clone https://github.com/meizhiju/layered-bilstm-crf
python3 bilstmcrf_data_creating.py

