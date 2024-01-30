#!/bin/bash
#SBATCH --job-name=pca
#SBATCH --time=2-00:00:00
#SBATCH --partition=normal
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=david.yang2@einsteinmed.edu
#SBATCH --nodes=2
#SBATCH --mem=8gb
#SBATCH --tasks-per-node=8
#SBATCH --output=log7-pca.%A_%a.out

# Load Conda environment
source /public/apps/conda3/etc/profile.d/conda.sh
conda activate anc_vig

# Set directories
main_dir="/gs/gsfs0/shared-lab/greally-lab/David/test-pca"
INP="$main_dir/merge"
OUT="$main_dir/PCA"

mkdir $OUT

plink --bfile $INP/merge --pca --out $OUT