#!/bin/bash

#Specify folder with all fasta data
#Get a list of all fasta (*.fna.gz) files in the folder
fasta_file_list=$(find folder/ -type f -name "*.fna.gz")

#Loop through list of files and write each file to new combined file
for fasta_file in ${fasta_file_list}; do
   cat ${fasta_file} >> Combined_fasta/combined_fasta_data.fna.gz
done;
