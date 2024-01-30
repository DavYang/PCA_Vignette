#!/bin/bash
#SBATCH --job-name=pca
#SBATCH --time=2-00:00:00
#SBATCH --partition=normal
#SBATCH --nodes=1
#SBATCH --mem=8gb
#SBATCH --tasks-per-node=8
#SBATCH --output=log7-pca.%A_%a.out

# Load Conda environment
source /public/apps/conda3/etc/profile.d/conda.sh
conda activate anc_vig

# Set directories
main_dir=$(pwd) 
INP="$main_dir/merge"
OUT="$main_dir/PCA"

mkdir $OUT

plink --bfile $INP/merge --pca --out $OUT