#!/bin/bash
#SBATCH --job-name=bcf_all_chr
#SBATCH --time=2-00:00:00
#SBATCH --partition=normal
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=david.yang2@einsteinmed.edu
#SBATCH --nodes=1
#SBATCH --mem=8gb
#SBATCH --tasks-per-node=8
#SBATCH --output=log3-bcf_all_chr.%A_%a.out

# Set directories
main_dir="/gs/gsfs0/shared-lab/greally-lab/David/test-pca"
REF="$main_dir/grch37_ref"
INP="$main_dir/raw-data_1KG"
OUT="$main_dir/bcf_1KG"

mkdir -p $OUT  # Use -p to create parent directories if they don't exist

# Loop through all chromosomes and submit jobs
for chr in {1..22}; do
    sbatch --export=CHR=$chr process_chr.sh $chr
done

