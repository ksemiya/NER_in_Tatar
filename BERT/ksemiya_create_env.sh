#!/bin/bash
conda create -n ksemiya_env_1 python=3
conda init zshrc
conda activate ksemiya_env_1
pip install numpy
pip install -U scikit-learn
pip install seqeval
pip install torch
conda install pytorch torchvision cudatoolkit=10.2 -c pytorch
pip install tqdm
pip install transformers==2.8.0
