#!usr/bin/env bash

#Assembly Statistics files
time ncbi-genome-download \
	-s refseq \
	-F assembly-stats \
	-l all \
	-A assembly_list_refseq_accessions.txt \
	--output-folder Statistics_files_refseq_accessions/ \
	--parallel 32 \
	-v \
	bacteria

#Fasta files	
time ncbi-genome-download \
	-s refseq \
	-F fasta \
	-l all \
	-A assembly_list_refseq_accessions.txt \
	--output-folder Statistics_files_refseq_accessions/ \
	--parallel 32 \
	-v \
	bacteria
