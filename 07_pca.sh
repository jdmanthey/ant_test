# start interactive session
interactive -p quanah -c 4 -m 8G

# move to directory
workdir=/lustre/scratch/jmanthey/01_ants
cd ${workdir}/06_structure

# make chromosome map for the vcfs
grep -v "#" taen.vcf | cut -f 1 | uniq | awk '{print $0"\t"$0}' > chrom_map.txt


#plink output format
source activate bcftools
vcftools --vcf herc_group.vcf  --plink --chrom-map chrom_map.txt --out herc_group 

vcftools --vcf laev.vcf  --plink --chrom-map chrom_map.txt --out laev 

vcftools --vcf penn.vcf  --plink --chrom-map chrom_map.txt --out penn 

vcftools --vcf new.vcf  --plink --chrom-map chrom_map.txt --out new 

vcftools --vcf taen.vcf  --plink --chrom-map chrom_map.txt --out taen 


# convert  with plink
plink --file ${workdir}/06_structure/herc_group --recode12 --allow-extra-chr --out ${workdir}/06_structure/herc_group_plink

plink --file ${workdir}/06_structure/laev --recode12 --allow-extra-chr --out ${workdir}/06_structure/laev_plink

plink --file ${workdir}/06_structure/penn --recode12 --allow-extra-chr --out ${workdir}/06_structure/penn_plink

plink --file ${workdir}/06_structure/new --recode12 --allow-extra-chr --out ${workdir}/06_structure/new_plink

plink --file ${workdir}/06_structure/taen --recode12 --allow-extra-chr --out ${workdir}/06_structure/taen_plink



# run pca on each dataset
plink --file ${workdir}/06_structure/herc_group_plink --pca --allow-extra-chr --out ${workdir}/06_structure/herc_group_plink_pca

plink --file ${workdir}/06_structure/laev_plink --pca --allow-extra-chr --out ${workdir}/06_structure/laev_plink_pca

plink --file ${workdir}/06_structure/penn_plink --pca --allow-extra-chr --out ${workdir}/06_structure/penn_plink_pca

plink --file ${workdir}/06_structure/new_plink --pca --allow-extra-chr --out ${workdir}/06_structure/new_plink_pca

plink --file ${workdir}/06_structure/taen_plink --pca --allow-extra-chr --out ${workdir}/06_structure/taen_plink_pca










