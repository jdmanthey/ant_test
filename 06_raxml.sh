#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=raxml
#SBATCH --partition nocona
#SBATCH --nodes=1 --ntasks=8
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G

raxmlHPC-PTHREADS-SSE3 -T 8 -f a -x 50 -m GTRCAT -p 253 -N 100 \
-s /lustre/scratch/jmanthey/01_ants/06_structure/phylo.fasta \
-n camponotus_full.tre \
-w /lustre/scratch/jmanthey/01_ants/06_structure/
