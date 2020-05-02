#!/bin/bash
#SBATCH -c 2 -G 1
#SBATCH --output=result.out
module load Python/Anaconda_v10.2019

machine_name=$(uname -n)
if [[ $machine_name == cn-* ]];
then
  echo "Executing on HPC cluster, setting up env"
  env_scripts=/home/pnzhizhin/anaconda3/bin

  module load Python/Anaconda_v10.2019
  source deactivate
  source activate ksemiya_env_1
fi

cd layered-bilstm-crf/src/
python3 train.py
python3 test.py


