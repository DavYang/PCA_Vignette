# Pre-step 1) Prepare conda environment
The conda environment with all necessary programs can be activated by running:
conda activate /gs/gsfs0/users/davyang/.conda/envs/anc_vig

* To install from using conda:

conda create --name ancestry_vignette
conda activate ancestry_vignette

conda install -c bioconda bcftools plink plink2
bcftools --version
plink --version
plink2 --version

# Step 1) Download files 
Download variants (*.vcf) and accompanying files into their repsected directories:
```bash
sbatch 1_get-data.sh
```
