#!usr/bin/env bash

# remove old log file
rm log_download_from_ftp.out

# write all output to new log file
exec 3>&1 1>>log_download_from_ftp.out 2>&1


# remove old folders
rm -rf Assembly_stats_bacteria/
rm -rf Genomic_FNA_bacteria/

# create new folders
mkdir Assembly_stats_bacteria/
mkdir Genomic_FNA_bacteria/




# get list of all Refseq accessions
Refseq_accession_list=$(cat assembly_summary_bacteria.txt |  grep 'representative genome\|reference genome' | awk -F'\t' '{print $1}')

# get list of al ftp folders links
Refseq_FTP_list=$(cat assembly_summary_bacteria.txt | grep 'representative genome\|reference genome' | awk -F'\t' '{print $20}')




# loop through all the ftp folder links
for FTP_link_folder in ${Refseq_FTP_list}; do	
	# get refseq accession with ncbi ID
	Refseq_accession_ncbiID=$(echo "$FTP_link_folder"| awk -F'/' '{print $NF}')
	
	# get only refseq accession
	#Refseq_accession=$(echo "$FTP_link_folder"| awk -F'/' '{print $NF}'|awk -F'_' '{print $1,$2}'|tr " " "_")
	
	#statistic file download using wget
	wget "$FTP_link_folder"/"$Refseq_accession_ncbiID""_assembly_stats.txt" -P Assembly_stats_bacteria/ 
	
	#fasta file download using wget	
	wget "$FTP_link_folder"/"$Refseq_accession_ncbiID""_genomic.fna.gz" -P Genomic_FNA_bacteria/ 
	
done

echo "PIPELINE FINISHED!"

