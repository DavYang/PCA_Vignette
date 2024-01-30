#!/bin/bash
#SBATCH --job-name=plink
#SBATCH --time=2-00:00:00
#SBATCH --partition=normal
#SBATCH --nodes=1
#SBATCH --mem=8gb
#SBATCH --tasks-per-node=8
#SBATCH --output=log4-plink.%A_%a.out

# source /public/apps/conda3/etc/profile.d/conda.sh
# conda activate ancestry_vignette

# Set directories
main_dir=$(pwd) 
INP="$main_dir/bcf_1KG-para"
OUT="$main_dir/plink_1KG"

cd $INP
mkdir -p $OUT  # Use -p to create parent directories if they don't exist

for chr in {1..22}; do
    echo "Processing chromosome $chr"

    echo "Converting BCF to PLINK format..."
    plink --noweb \
      --bcf $INP/ALL.chr"${chr}".phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.bcf \
      --keep-allele-order \
      --vcf-idspace-to _ \
      --const-fid \
      --allow-extra-chr 0 \
      --split-x b37 no-fail \
      --make-bed \
      --out $OUT/ALL.chr"${chr}".phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes ;

    echo "Chromosome $chr processing completed."
done
