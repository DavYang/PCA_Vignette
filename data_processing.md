# Pre-step 1) Prepare conda environment
The conda environment with all necessary programs can be activated by running:
```bash
conda activate /gs/gsfs0/users/davyang/.conda/envs/anc_vig
```
* To install from using conda:
```bash
conda create --name ancestry_vignette
conda activate ancestry_vignette
conda install -c bioconda bcftools plink plink2
bcftools --version
plink --version
plink2 --version
```

# Step 1) Download files 
Download variants (*.vcf) and accompanying files into their repsected directories:
```bash
sbatch 1_get-data.sh
```
# Step 2) Download the GRCh37 reference genome
```bash
sbatch 2_get-ref.sh
```
# Step 3) Convert the 1KG dataset into a BCF for easier handling (start here) 
```bash
sbatch 3_para-convert2bcf.sh
```

- Ensure that multi-allelic calls are split and that indels are left-aligned compared to reference genome (1st pipe)
- Sets the ID field to a unique value: CHROM:POS:REF:ALT (2nd pipe)
- Removes duplicates (3rd pipe)
- -I +'%CHROM:%POS:%REF:%ALT' means that unset IDs will be set to CHROM:POS:REF:ALT*
- -x ID -I +'%CHROM:%POS:%REF:%ALT' first erases the current ID and then sets it to CHROM:POS:REF:ALT*

*Continuous error for chr2 (below):

Processing chromosome 2
Normalizing and re-annotating variants...
[E::bgzf_uncompress] Inflate operation failed: 3
Lines   total/split/joined/realigned/skipped:   432433/2320/0/578/0
Lines   total/split/joined/realigned/skipped:   434860/0/0/0/0
Indexing the BCF file...
Chromosome 2 processing completed.

# Step 4) Convert the BCF files into PLINK format

sbatch 4_convert2PLINK.sh

# Step 5) Prune variants from each chromosome ("LD pruning")
Linkage disequilibrium (LD) refers to the non-random association of alleles at different loci in a given population. LD pruning, or linkage disequilibrium pruning, is a process used in population genetics and genetic association studies to reduce the redundancy of genetic information by selecting a subset of variants that are less correlated. 

For this exercise, we will prune variants to reduce redundancy and improve computational efficiency.
```bash
sbatch 5_LD-prune.sh
```
- --maf 0.10, only retain SNPs with MAF greater than 10%
- --indep [window size] [step size/variant count)] [Variance inflation factor (VIF) threshold]

How many variants remain?

# Step 6) Merge all chromosomes into a single plink file
```bash
sbatch 6_merge.sh
```
# Step 7) Run Principal Components Analysis (PCA)
```bash
sbatch 7_pca.sh
```

# Step 8) Plot the PCA results w/python
Open the "plot_PCA.ipynb" using jupyter notebook, and follow the steps to format and plot the PCA results
```bash
jupyter notebook
```
copy and paste one of the URLs into your web browser in a new tab.