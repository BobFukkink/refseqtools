#!/bin/bash

#Model downloaded with ncbi-genome-download get the taxids
grep -r "Taxid" /home/bob/Documents/download_stats_genbank_acc/model_test_results/genbank/vertebrate_mammalian/ | awk '{print $NF}' > /home/bob/Documents/download_stats_genbank_acc/total_output/model_taxids_list.txt

#Model downloaded with ncbi-genome-download get the accessions
grep -r "GenBank assembly accession" /home/bob/Documents/download_stats_genbank_acc/model_test_results/genbank/vertebrate_mammalian/ | awk '{print $NF}' > /home/bob/Documents/download_stats_genbank_acc/total_output/model_genbank_accessions_list.txt

#Model downloaded with ncbi-genome-download get the genome-length
grep -r -m 1 "	total-length" /home/bob/Documents/download_stats_genbank_acc/model_test_results/genbank/vertebrate_mammalian/ | awk '{print $NF}' > /home/bob/Documents/download_stats_genbank_acc/total_output/model_lengths_list.txt


#Bacteria downloaded with ncbi-genome-download get the taxids
grep -r "Taxid" /home/bob/Documents/download_stats_genbank_acc/bacteria_test_results/ | awk '{print $NF}' > /home/bob/Documents/download_stats_genbank_acc/total_output/bacteria_taxids_list.txt

#Bacteria downloaded with ncbi-genome-download get the accessions
grep -r "GenBank assembly accession" /home/bob/Documents/download_stats_genbank_acc/bacteria_test_results/ | awk '{print $NF}' > /home/bob/Documents/download_stats_genbank_acc/total_output/bacteria_genbank_accessions_list.txt

#Bacteria downloaded with ncbi-genome-download get the genome-length
grep -rP -m 1 "\ttotal-length\t" /home/bob/Documents/download_stats_genbank_acc/bacteria_test_results/ | awk '{print $NF}' > /home/bob/Documents/download_stats_genbank_acc/total_output/bacteria_lengths_list.txt




