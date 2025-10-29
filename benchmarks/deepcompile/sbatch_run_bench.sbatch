#!/bin/bash
#
# SBATCH 提交脚本：单节点运行 deepcompile 基准测试
# 使用前请修改 TOKENIZER_PATH / DATASET_PATH / MODEL_DIR 等路径为本地实际位置
#
#SBATCH --job-name=deepcompile_bench
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --gres=gpu:8               # 根据实际需要调整 GPU 数量
#SBATCH --output=logs/slurm-%j.out.log

# 优先使用 SLURM 分配的 GPU 数目
export NGPUS_PER_NODE=${SLURM_GPUS_ON_NODE:-${SLURM_GPUS_PER_NODE:-${SLURM_JOB_GPUS:-1}}}
export NUM_NODES=${SLURM_NNODES:-1}
export MASTER_ADDR=${MASTER_ADDR:-"127.0.0.1"}
export MASTER_PORT=${MASTER_PORT:-$((15000 + RANDOM % 10000))}

# 运行基准脚本
srun bash ./run_bench.sh
