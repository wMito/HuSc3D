#!/bin/bash
#SBATCH --job-name=mipsplat
#SBATCH --qos=normal
#SBATCH --gres=gpu:1
#SBATCH --mem=256G
#SBATCH --partition=rtx4090
#SBATCH --cpus-per-task=8

conda init
conda activate ./env


MAIN_DIR="husc3d/"

for SCENE_PATH in "$MAIN_DIR"/*; do
    if [ -d "$SCENE_PATH" ]; then
        SCENA=$(basename "$SCENE_PATH")
        echo "Processing scene: $SCENA"
	
	if [[ "hanna" == "$SCENA" || "jaroslaw" == "$SCENA" ]]; then
		i=8
	else 
		i=4
		continue
	fi
	echo "$i"
        python train.py -s "$SCENE_PATH" -m "output/all/$SCENA" -r "$i" --eval
        python render.py -m "output/all/$SCENA" 
        python  metrics.py -m "output/all/$SCENA" -r "$i"
    fi
done
