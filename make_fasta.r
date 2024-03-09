read_vcf <- function(input_file) {
  header <- readLines(input_file)
  header <- header[grep('^#C', header)]
  header <- strsplit(header, "\t")[[1]]
  vcf <- read.table(input_file, header=F)
  colnames(vcf) <- header
  return(vcf)
}

xxx <- read_vcf("phylo.vcf")
	output_fasta <- "phylo.fasta"

	
	for(a in 10:ncol(xxx)) {
		xxx[,a] <- substr(xxx[,a], 1, 3)
	}
	
	# subset genotypes and reference alleles
	genotypes <- xxx[,10:ncol(xxx)]
	ref_allele <- as.character(xxx[,4])
	alt_allele <- as.character(xxx[,5])
	heterozygote_allele <- rep("?", length(ref_allele))

	# fill in heterozygous ambiguity codes
	heterozygote_allele[ref_allele == "A" & alt_allele == "C"] <- "M"
	heterozygote_allele[ref_allele == "C" & alt_allele == "A"] <- "M"
	heterozygote_allele[ref_allele == "A" & alt_allele == "G"] <- "R"
	heterozygote_allele[ref_allele == "G" & alt_allele == "A"] <- "R"
	heterozygote_allele[ref_allele == "A" & alt_allele == "T"] <- "W"
	heterozygote_allele[ref_allele == "T" & alt_allele == "A"] <- "W"
	heterozygote_allele[ref_allele == "C" & alt_allele == "G"] <- "S"
	heterozygote_allele[ref_allele == "G" & alt_allele == "C"] <- "S"
	heterozygote_allele[ref_allele == "C" & alt_allele == "T"] <- "Y"
	heterozygote_allele[ref_allele == "T" & alt_allele == "C"] <- "Y"
	heterozygote_allele[ref_allele == "G" & alt_allele == "T"] <- "K"
	heterozygote_allele[ref_allele == "T" & alt_allele == "G"] <- "K"

	# loop for each individual
	for(a in 1:ncol(genotypes)) {
		genotypes[genotypes[,a] == "0/0",a] <- ref_allele[genotypes[,a] == "0/0"]
		genotypes[genotypes[,a] == "0/1",a] <- heterozygote_allele[genotypes[,a] == "0/1"]
		genotypes[genotypes[,a] == "1/1",a] <- alt_allele[genotypes[,a] == "1/1"]
		genotypes[genotypes[,a] == "./.",a] <- "?"	
	}

	individuals <- colnames(genotypes)
		# write output
		for(a in 1:ncol(genotypes)) {
			a_name <- paste(">", individuals[a], sep="")
			a_genotype <- paste(genotypes[,a], collapse="")
			if(a == 1) {
				write(a_name, file=output_fasta, append=F)
				write(a_genotype, file=output_fasta, append=T)
			} else {
				write(a_name, file=output_fasta, append=T)
				write(a_genotype, file=output_fasta, append=T)
			}
		}
	
