#!/bin/bash
#SBATCH --job-name=wget1
#SBATCH --time=2-00:00:00
#SBATCH --partition=normal
#SBATCH --nodes=1
#SBATCH --mem=8gb
#SBATCH --output=log1-wget.%A_%a.out

# Make directories for data and metadata
data_dir="raw-data_1KG"
metadata_dir="metadata_1KG"

mkdir $data_dir
echo "Directory created: $data_dir"

mkdir $metadata_dir
echo "Directory created: $metadata_dir"

# Download the data
cd $data_dir

echo "Downloading data..."
prefix="ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr" ;

suffix=".phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz" ;

for chr in {1..22}; do
    wget "${prefix}""${chr}""${suffix}" "${prefix}""${chr}""${suffix}".tbi ;
done
echo "Done"

echo "Downloading PED file..."
wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/working/20130606_sample_info/20130606_g1k.ped 


