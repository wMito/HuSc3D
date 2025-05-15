#!/bin/bash
#SBATCH --job-name=2dgs
#SBATCH --qos=normal
#SBATCH --gres=gpu:1
#SBATCH --mem=256G
#SBATCH --partition=rtx4090
#SBATCH --cpus-per-task=8

conda init
conda activate ./env


MAIN_DIR="husc3d/"

for SCENE_PATH in "$MAIN_DIR"/*; do
	if [[ "hanna" == "$SCENA" || "jaroslaw" == "$SCENA" ]]; then
		i=8
	else 
		i=4
		continue
	fi
        path="${MAIN_DIR}/${SCENE_PATH}"
        SCENA=$(basename "$SCENE_PATH")
        echo "Processing scene: $SCENA"

        python train.py -s "$path" -m "output/all/$SCENA" -r $i --eval
        python render.py -m "output/all/$SCENA" --skip_mesh
        python metrics.py -m "output/all/$SCENA"
    
done
