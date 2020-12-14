#!/bin/bash

fasta_file_list=$(find library/ -type f -name "*.fna")
for fasta_file in ${fasta_file_list}; do
   cat ${fasta_file} >> ${out}${name}.fna
done;
