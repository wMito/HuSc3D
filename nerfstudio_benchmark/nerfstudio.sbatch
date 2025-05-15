#!/bin/bash
#SBATCH --job-name=nerfstudio
#SBATCH --qos=normal
#SBATCH --gres=gpu:1
#SBATCH --mem=256G
#SBATCH --partition=rtx4090
#SBATCH --cpus-per-task=8

conda init
conda activate ./env


MAIN_DIR="husc3d/"

bash nerfstudio.sh
