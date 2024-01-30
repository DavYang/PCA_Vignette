#!/bin/bash
#SBATCH --job-name=merge
#SBATCH --time=2-00:00:00
#SBATCH --partition=normal
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=david.yang2@einsteinmed.edu
#SBATCH --nodes=2
#SBATCH --mem=8gb
#SBATCH --tasks-per-node=8
#SBATCH --output=log6-merge.%A_%a.out

# Load Conda environment
source /public/apps/conda3/etc/profile.d/conda.sh
conda activate anc_vig

# Set directories
main_dir="/gs/gsfs0/shared-lab/greally-lab/David/test-pca"
INP="$main_dir/Pruned"
OUT="$main_dir/merge"

# # Navigate to the Pruned directory
# mkdir -p $OUT  # Ensure the output directory exists or create it

cd $INP
# Create a list of .bim files and remove the extension
echo 'writing merge list'
find . -name "*.bim" | grep -e "genotypes" > ForMerge.list 
sed -i 's/.bim//g' ForMerge.list 


# Perform PLINK merge using the list
echo 'merging...'
plink --merge-list ForMerge.list --out $OUT/merge
