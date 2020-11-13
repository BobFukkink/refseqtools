# Workflow downloading Representative and Reference genomes from bacterial domain and add Model organisms (human, mouse, rat)

## 1. Download representative and reference accession list from assembly database
### Bottom of the page "Send to", "File", "ID Table", "Accession"

https://www.ncbi.nlm.nih.gov/assembly/?term=Bacteria%5BOrganism%5D+AND+(representative_genome%5Bfilter%5D+OR+reference_genome%5Bfilter%5D)+AND+latest_refseq%5Bfilter%5D

## 2. Get only the Refseq assembly accessions from the file

```bash
cat assembly_result.txt | egrep -o "GCF_[0-9]{9}.[0-9]" > assembly_list_refseq_accessions.txt
```

## 3. Download genomes assembly-stats and fasta files using ncbi-genome-download

### Assembly Statistics files
```bash
#!usr/bin/env bash

time ncbi-genome-download \
	-s refseq \
	-F assembly-stats \
	-l all \
	-A assembly_list_refseq_accessions.txt \
	--output-folder Statistics_files_refseq_accessions/ \
	--parallel 32 \
	-v \
	bacteria
```
### Fasta files
```bash
#!usr/bin/env bash

time ncbi-genome-download \
	-s refseq \
	-F fasta \
	-l all \
	-A assembly_list_refseq_accessions.txt \
	--output-folder Statistics_files_refseq_accessions/ \
	--parallel 32 \
	-v \
	bacteria
```
## 4. It may occur that some Refseq accessions are “replaced” or “suppressed” so these need to be downloaded using the ftp website of NCBI.

https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/

## 5. To create the phylogenetic tree we need a DNA file for the Bacteria
### File should contain format: accession | taxid | genome length
#### You should be in the folder: Statistics_files_refseq_accessions/refseq/

##### command Accessions (we already have accessions but this if to get them in the correct order)

```bash
grep -rP "RefSeq assembly accession" bacteria/ | awk '{print $NF}' > bacteria_refseq_accessions_list.txt
```

##### command Taxonomic IDs

```bash
grep -rP "Taxid" bacteria/ | awk '{print $NF}' > bacteria_taxids_list.txt
```

##### command Genome Lengths

```bash
grep -rP -m 1 "\ttotal-length\t" bacteria/ | awk '{print $NF}' > bacteria_lengths_list.txt
```

## 5 Download data for model organisms (human (GCF_000001405.39), mouse (GCF_000001635.27), rat (GCF_000001895.5))

### Assembly Statistics files
```bash
#!usr/bin/env bash

time ncbi-genome-download \
	-s refseq \
	-F assembly-stats \
	-l all \
	-A GCF_000001405.39,GCF_000001635.27,GCF_000001895.5\
	--output-folder Statistics_files_refseq_accessions/ \
	--parallel 3 \
	-v \
	vertebrate_mammalian
```
### Fasta files
```bash
#!usr/bin/env bash

time ncbi-genome-download \
	-s refseq \
	-F fasta \
	-l all \
	-A GCF_000001405.39,GCF_000001635.27,GCF_000001895.5\
	--output-folder Fasta_files_refseq_accessions/ \
	--parallel 3 \
	-v \
	vertebrate_mammalian
```

## 6. To create the phylogenetic tree we need a DNA file for the Model organisms
### File should contain format: accession | taxid | genome length
#### You should be in the folder: Statistics_files_refseq_accessions/refseq/

##### command Accessions (we already have accessions but this if to get them in the correct order)

```bash
grep -rP "RefSeq assembly accession" vertebrate_mammalian/ | awk '{print $NF}' > models_refseq_accessions_list.txt
```

##### command Taxonomic IDs

```bash
grep -rP "Taxid" vertebrate_mammalian/ | awk '{print $NF}' > models_taxids_list.txt
```

##### command Genome Lengths

```bash
grep -rP -m 1 "\ttotal-length\t" vertebrate_mammalian/ | awk '{print $NF}' > models_lengths_list.txt
```
## 7. Concatenate DNA files from Bacteria and Model

```python
import pandas as pd

path_to_files = "PATH/TO/FOLDER"


def load_model_files_into_dataframe():
    dataframe_accessions = pd.read_csv(path_to_files + '/models_refseq_accessions_list.txt', header=None, sep='\t')
    dataframe_taxids = pd.read_csv(path_to_files + '/models_taxids_list.txt', header=None, sep='\t')
    dataframe_sequence_lengths = pd.read_csv(path_to_files + '/models_lengths_list.txt', header=None, sep='\t')
    
    concatenated_dataframes_representatives = pd.concat([dataframe_accessions, dataframe_taxids, dataframe_sequence_lengths], axis=1)
    
    concatenated_dataframes_representatives.to_csv(path_to_files + '/model_bacteria_file_accession_taxid_length.DNA', header=None, index=None, sep='\t', mode='w')

def load_bacteria_files_into_dataframe():
    dataframe_accessions = pd.read_csv(path_to_files + '/bacteria_refseq_accessions_list.txt', header=None, sep='\t')
    dataframe_taxids = pd.read_csv(path_to_files + '/bacteria_taxids_list.txt', header=None, sep='\t')
    dataframe_sequence_lengths = pd.read_csv(path_to_files + '/bacteria_lengths_list.txt', header=None, sep='\t')

    concatenated_dataframes_representatives = pd.concat([dataframe_accessions, dataframe_taxids, dataframe_sequence_lengths], axis=1)

    concatenated_dataframes_representatives.to_csv(path_to_files + '/model_bacteria_file_accession_taxid_length.DNA', header=None, index=None, sep='\t', mode='a')

def main():
    load_model_files_into_dataframe()
    load_bacteria_files_into_dataframe()

main()

```

## 8. Gzip the concatenated DNA file and convert to a json file

```bash 
gzip model_bacteria_file_accession_taxid_length.DNA
```

```bash
python convert_acc2taxid_to_json.py -i model_bacteria_file_accession_taxid_length.DNA.gz -o model_bacteria_file_accession_taxid_length.DNA.json
```

## 9. Create phylogenetic tree

```bash
python refseqtools/annotate_tree.py -t 1 -db path_to_sqlite_db_folder/ -j model_bacteria_file_accession_taxid_length.DNA.json -r model_bacteria_genomes_superkingdom.png -prune superkingdom
```

## 10. Download Viral, Archaea, Fungi domains

```bash
python download_refseq_domain.py -d viral -o viral -p 32
```

```bash
python download_refseq_domain.py -d archaea -o archaea -p 32
```

```bash
python download_refseq_domain.py -d fungi -o fungi -p 32
```

## 11. Copy all bacteria and model  files to one directory (needed to get Refseq accessions to sequence accessions)
### Use both on bacteria and model fasta files

```bash
find . -name \*fna.gz -exec cp {} Fasta_bacteria_model/ \;
```

## 12. Create file of Refseq accessions to sequence accessions
### Use in Fasta_bacteria_model directory

```bash
zgrep -H ">" *.fna.gz |tr " " "\t" | awk '{print $1}' | tr ":" "\t" | tr "_" "\t" | awk -v OFS='\t' '{print $1,$2,$(NF-1),$NF}' | tr "\t" "_" | sed 's/_>/\t/' > Refseq_acc_to_sequence_acc_bacteria_model.txt
```

## 13. Use python script to concatenate to sequence accession to taxid 
### From the statistic files we have the Refseq accession to the taxid and from fasta files we get Refseq accession to sequence accession, so concatenate using Refseq accession as key

```python
import pandas as pd

path_to_files = "PATH/TO/FOLDER"

def load_file_acc_tax():
    dataframe_RefseqACC_TaxID_GenomeLen = pd.read_csv(path_to_files + 'model_bacteria_file_accession_taxid_length.DNA', header=None, sep='\t', names = ["Refseq_Acc", "Tax_ID","Genome_length"])
    dataframe_RefseqACC_TaxID = dataframe_RefseqACC_TaxID_GenomeLen.drop(columns=["Genome_length"])

    return(dataframe_RefseqACC_TaxID)


def load_file_acc_seqid(dataframe_RefseqACC_TaxID):
    dataframe_RefseqACC_SequenceID = pd.read_csv(path_to_files + 'Refseq_acc_to_sequence_acc_bacteria_model.txt', header=None, sep='\t', names = ["Refseq_Acc", "Sequence_ID"])

    merged_dataframe = pd.merge(dataframe_RefseqACC_SequenceID, dataframe_RefseqACC_TaxID, how ='inner', on ='Refseq_Acc')

    dataframe_SequenceID_TaxID = merged_dataframe.drop(columns=["Refseq_Acc"])

    dataframe_SequenceID_TaxID.to_csv(path_to_files + 'seqid2taxid_model_bacteria.map', header=None, index=None, sep='\t', mode='w')


def main():
    dataframe_RefseqACC_TaxID = load_file_acc_tax()
    load_file_acc_seqid(dataframe_RefseqACC_TaxID)

main()

```

## 14. Copy all virus, archaea and fungi data to the bacteria and models directory
### Use on Viral, Archaea and Fungi fasta file folders

```bash
find . -name \*fna.gz -exec cp {} Fasta_bacteria_model/ \;
```

## 15. Combine all fasta files to one big fasta file off all domains

```bash
#!/bin/bash

fasta_file_list=$(find All_bacteria_models_archaea_virus_fungi_fasta_data/ -type f -name "*.fna.gz")

for fasta_file in ${fasta_file_list}; do
   zcat ${fasta_file} >> Combined_fasta/All_bacteria_models_archaea_virus_fungi_fasta_data_28_okt_2020.fna.gz
done;
```

## 16. Combine mapping files of models,bacteria with virus,archaea,fungi

```bash
cat *.map > seqid2taxid_bacteria_model_virus_archaea_fungi.map
```

## 17. Filter redundancy from mapping file
### The seqied2taxid from the refseq release contains most of the mappings so alot of redundancy is included but their are still new sequences added

```bash
cat seqid2taxid_bacteria_model_virus_archaea_fungi.map |sort -u > Uniq_seqid2taxid_bacteria_model_virus_archaea_fungi.map
```

## 18. Filter accession from complete fasta file

```bash
python filter_fasta.py -i All_bacteria_models_archaea_virus_fungi_fasta_data_28_okt_2020.fna.gz -o filtered_all_bacteria_models_archaea_virus_fungi_fasta_data_28_okt_2020.fna.gz --include-accessions AC,NC,NZ -j Refseq201.DNA.json --dbfile "PATH/TO/sqlite_DB_FOLDER/"
```

## 19. Filter mapping file on accessions to keep AC NC NZ
```bash
cat Uniq_seqid2taxid_bacteria_model_virus_archaea_fungi.map | grep 'AC_\|NC_\|NZ_' > onlyAccessions_AC_NC_NZ_Uniq_seqid2taxid_bacteria_model_virus_archaea_fungi.map
```


