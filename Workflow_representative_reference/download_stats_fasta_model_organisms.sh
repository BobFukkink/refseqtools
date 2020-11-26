#!usr/bin/env bash

#Assembly Statistics files
time ncbi-genome-download \
	-s refseq \
	-F assembly-stats \
	-l all \
	-A GCF_000001405.39,GCF_000001635.27,GCF_000001895.5\
	--output-folder Statistics_files_refseq_accessions/ \
	--parallel 3 \
	-v \
	vertebrate_mammalian
	
#Fasta files
time ncbi-genome-download \
	-s refseq \
	-F fasta \
	-l all \
	-A GCF_000001405.39,GCF_000001635.27,GCF_000001895.5\
	--output-folder Fasta_files_refseq_accessions/ \
	--parallel 3 \
	-v \
	vertebrate_mammalian
