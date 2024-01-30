#!/bin/bash
#SBATCH --job-name=prune
#SBATCH --time=2-00:00:00
#SBATCH --partition=normal
#SBATCH --nodes=1
#SBATCH --mem=8gb
#SBATCH --tasks-per-node=8
#SBATCH --output=log5-prune.%A_%a.out

source /public/apps/conda3/etc/profile.d/conda.sh
conda activate anc_vig

main_dir=$(pwd) 
INP="$main_dir/plink_1KG"
OUT="$main_dir/Pruned"

cd $INP
# mkdir $OUT

for chr in {1..22}; do
    plink --noweb \
      --bfile $INP/ALL.chr"${chr}".phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes \
      --maf 0.10 --indep 50 5 1.5 \
      --out $OUT/ALL.chr"${chr}".phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes ;

    plink --noweb \
      --bfile $INP/ALL.chr"${chr}".phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes \
      --extract $OUT/ALL.chr"${chr}".phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.prune.in \
      --make-bed \
      --out $OUT/ALL.chr"${chr}".phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes ;
done