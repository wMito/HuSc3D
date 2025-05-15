#!/bin/bash

helpFunction_launch_train()
{
   echo "Usage: $0 [-v <vis>] [-s] [<gpu_list>]"
   echo -e "\t-v <vis>: Visualization method. <vis> can be wandb or tensorboard. Default is tensorboard."
   echo -e "\t-s: Launch a single training job per gpu."
   echo -e "\t<gpu_list> [OPTIONAL] list of space-separated gpu numbers to launch train on (e.g. 0 2 4 5)"
   exit 1
}

vis="tensorboard"
single=true

# Parse arguments
while getopts "v:s" opt; do
  case "$opt" in
    v ) vis="$OPTARG" ;;
    s ) single=true ;;
    ? ) helpFunction_launch_train ;;
  esac
done

shift $((OPTIND-1))

# Deal with GPU list
GPU_IDX=("$@")
if [ -z "${GPU_IDX[0]+x}" ]; then
    echo "no gpus set... finding available gpus"
    num_device=$(nvidia-smi --query-gpu=name --format=csv,noheader | wc -l)
    START=0
    END=$((num_device - 1))
    GPU_IDX=()
    for (( id=START; id<=END; id++ )); do
        free_mem=$(nvidia-smi --query-gpu=memory.free --format=csv -i $id | grep -Eo '[0-9]+')
        if [[ $free_mem -gt 10000 ]]; then
            GPU_IDX+=( "$id" )
        fi
    done
fi
echo "available gpus... ${GPU_IDX[*]}"

DATASETS=("hanna" "jaroslaw" "tosia" "wiktor" "kacper" "paulina")
METHODS=("splatfacto-mcmc"  "instant-ngp" "nerfacto" "mipnerf")

date
tag=$(date +'%Y-%m-%d')
trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

for method_name in "${METHODS[@]}"; do
    echo "Running method: $method_name"
    idx=0
    len=${#GPU_IDX[@]}
    GPU_PID=()
    timestamp=$(date "+%Y-%m-%d_%H%M%S")

    for dataset in "${DATASETS[@]}"; do
        if "$single" && [ -n "${GPU_PID[$idx]+x}" ]; then
            echo "Waiting for GPU ${GPU_IDX[$idx]}"
            wait "${GPU_PID[$idx]}"
            echo "GPU ${GPU_IDX[$idx]} is available"
        fi

        export CUDA_VISIBLE_DEVICES="${GPU_IDX[$idx]}"

        if [[ "$dataset" == "hanna" || "$dataset" == "jaroslaw" ]]; then
            downscale_factor=8
        else
            downscale_factor=4
        fi

        dataparser="colmap --colmap_path sparse/0"

        ns-train "${method_name}" \
                 --data="/shared/sets/datasets/muzea/${dataset}" \
                 --experiment-name="${method_name}_muzea_${dataset}_${tag}" \
                 --relative-model-dir=nerfstudio_models/ \
                 --steps-per-save=1000 \
                 --logging.local-writer.enable=False  \
                 --logging.profiler="none" \
                 --vis "${vis}" \
                 --timestamp "$timestamp" \
                 ${dataparser} \
                 --downscale_factor "$downscale_factor" & GPU_PID[$idx]=$!

        echo "Launched ${method_name} ${dataset} on gpu ${GPU_IDX[$idx]}, downscale_factor=$downscale_factor"

        ((idx=(idx+1)%len))
    done
    wait
done

echo "Done."
