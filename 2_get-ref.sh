#!/bin/bash
#SBATCH --job-name=wget2
#SBATCH --time=2-00:00:00
#SBATCH --partition=normal
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=david.yang2@einsteinmed.edu
#SBATCH --nodes=1
#SBATCH --mem=8gb
#SBATCH --tasks-per-node=8
#SBATCH --output=log2-wget.%A_%a.out

mkdir grch37_ref
cd grch37_ref

# Download reference genome
wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/human_g1k_v37.fasta.gz 
wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/human_g1k_v37.fasta.fai 
gunzip human_g1k_v37.fasta.gz 