#!/bin/sh
#SBATCH --chdir=./
#SBATCH --job-name=filter
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --partition=nocona
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1-31

source activate bcftools

# define main working directory
workdir=/lustre/scratch/jmanthey/01_ants

# define variables
region_array=$( head -n${SLURM_ARRAY_TASK_ID} ${workdir}/scaffolds.txt | tail -n1 )

# filter based on missing data for each of the subsets of data
vcftools --vcf ${workdir}/04_vcf/${region_array}.vcf --keep phylo.txt --max-missing 0.9 --min-alleles 2 --max-alleles 2 --max-maf 0.49 --mac 2 --remove-indels --recode --recode-INFO-all --out ${workdir}/05_filtered_vcf/${region_array}_phylo

vcftools --vcf ${workdir}/04_vcf/${region_array}.vcf --keep herc_group.txt --max-missing 1.0 --min-alleles 2 --max-alleles 2 --max-maf 0.49 --mac 2 --remove-indels --recode --recode-INFO-all --out ${workdir}/05_filtered_vcf/${region_array}_herc_group

vcftools --vcf ${workdir}/04_vcf/${region_array}.vcf --keep laev.txt --max-missing 1.0 --min-alleles 2 --max-alleles 2 --max-maf 0.49 --mac 2 --remove-indels --recode --recode-INFO-all --out ${workdir}/05_filtered_vcf/${region_array}_laev

vcftools --vcf ${workdir}/04_vcf/${region_array}.vcf --keep new.txt --max-missing 1.0 --min-alleles 2 --max-alleles 2 --max-maf 0.49 --mac 2 --remove-indels --recode --recode-INFO-all --out ${workdir}/05_filtered_vcf/${region_array}_new

vcftools --vcf ${workdir}/04_vcf/${region_array}.vcf --keep penn.txt --max-missing 1.0 --min-alleles 2 --max-alleles 2 --max-maf 0.49 --mac 2 --remove-indels --recode --recode-INFO-all --out ${workdir}/05_filtered_vcf/${region_array}_penn

vcftools --vcf ${workdir}/04_vcf/${region_array}.vcf --keep taen.txt --max-missing 1.0 --min-alleles 2 --max-alleles 2 --max-maf 0.49 --mac 2 --remove-indels --recode --recode-INFO-all --out ${workdir}/05_filtered_vcf/${region_array}_taen

