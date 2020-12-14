#!/usr/bin/env bash
# TaxIDs bacteria dataset Kraken Genus|Species|Strain.
taxids_kraken="642 644 1073377 1386 1396 1053231 816 817 1073387 670516 36809 1001740 365348 365349 1149860 1060 1063 272943 1279 1280 1213734 1301 1313 170187 662 666 991923 338 53413 1185664 0 1"

# TaxIDs viruses dataset.
taxids_SRA="12059 12059 147711 147712 463676 186938 12730 10509 129951 162387 162145 693996 277944 694002 290028 197911 11320 641809 2560195 39744 1979161 11224 1507401 329641 197912 11520 518987 1868215 11250 0 1"

# Put list of kreports space seperated.
file_list_Kraken="/exports/sascstudent/bob/Tests_By_Jasper/analysis/01_ANY/HiSeq/HiSeq_kreport.tsv /exports/sascstudent/bob/Tests_By_Jasper/analysis/02_COMPLETE/HiSeq/HiSeq_kreport.tsv"

# Put list of kreports space seperated.
file_list_SRA_kreport=""

# Output folder.
PATH_folder="$(pwd)/output_loop_taxid"

# Remove Output folder if already existing.
rm -rfd $PATH_folder

# Make Output folder.
mkdir $PATH_folder

# Loop through kreports.
for tsv_file in ${file_list_Kraken}; do
    # Substring name of file without extension.
    tsv_filename_without_extension=${tsv_file::-4}

    # Create file.
    (echo "$tsv_filename_without_extension") >> $PATH_folder/$tsv_file

    # Loop through TaxIDs.
    for i in ${taxids_kraken}; do
        # Grep TaxID in kreport.
        grep_output=$(cat "$tsv_file" | grep -w "$i" |awk -F "\t" '{if ($5 == '$i') {print $2}}')

        # If TaxID count is empty, then write 0 to file.
        if [ -z "$grep_output" ]
        then
            printf "0\n" >> $PATH_folder/$tsv_file
        # else write count to file
        else
            printf "$grep_output\n" >> $PATH_folder/$tsv_file 	
        fi
    done
done

# Go to Output folder.
cd $PATH_folder/

# Print table in terminal.
paste ${file_list_Kraken}

# Write table to combined output file.
paste ${file_list_Kraken} > $PATH_folder/combined_taxids_table.tsv

printf "\nOutput folder:"
printf "$PATH_folder"

printf "\nCombined output table:"
printf "$PATH_folder/combined_taxids_table.tsv\n"
