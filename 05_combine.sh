grep "#" scaffold0031_taen.recode.vcf > taen.vcf

grep "#" scaffold0031_herc_group.recode.vcf > herc_group.vcf

grep "#" scaffold0031_laev.recode.vcf > laev.vcf

grep "#" scaffold0031_new.recode.vcf > new.vcf

grep "#" scaffold0031_phylo.recode.vcf > phylo.vcf

grep "#" scaffold0031_penn.recode.vcf > penn.vcf

for i in $( ls *taen.recode* ); do grep -v "#" $i >> taen.vcf; done

for i in $( ls *new.recode* ); do grep -v "#" $i >> new.vcf; done

for i in $( ls *herc_group.recode* ); do grep -v "#" $i >> herc_group.vcf; done

for i in $( ls *laev.recode* ); do grep -v "#" $i >> laev.vcf; done

for i in $( ls *penn.recode* ); do grep -v "#" $i >> penn.vcf; done

for i in $( ls *phylo.recode* ); do grep -v "#" $i >> phylo.vcf; done
