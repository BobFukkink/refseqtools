import pandas as pd

#Specify folder with files
path_to_files = "PATH/TO/FOLDER"

def load_file_acc_tax():
	#Load accession_taxid_length file as dataframe with three columns: Refseq_Acc, Tax_ID, Genome_length 
    dataframe_RefseqACC_TaxID_GenomeLen = pd.read_csv(path_to_files + 'model_bacteria_file_accession_taxid_length.DNA', header=None, sep='\t', names = ["Refseq_Acc", "Tax_ID","Genome_length"])
    
    #Remove genome length column since this is not needed for the mapping file
    dataframe_RefseqACC_TaxID = dataframe_RefseqACC_TaxID_GenomeLen.drop(columns=["Genome_length"])

    return(dataframe_RefseqACC_TaxID)


def load_file_acc_seqid(dataframe_RefseqACC_TaxID):
	#Load Refseq accession to sequence accession file as dataframe with two columns: Refseq_Acc, Sequence_ID
    dataframe_RefseqACC_SequenceID = pd.read_csv(path_to_files + 'Refseq_acc_to_sequence_acc_bacteria_model.txt', header=None, sep='\t', names = ["Refseq_Acc", "Sequence_ID"])
	
	#Merge dataframes togheter on Refseq_Acc since this is in both dataframes
    merged_dataframe = pd.merge(dataframe_RefseqACC_SequenceID, dataframe_RefseqACC_TaxID, how ='inner', on ='Refseq_Acc')
	
	#Refseq_Acc is not needed for the mapping file so can be removed
    dataframe_SequenceID_TaxID = merged_dataframe.drop(columns=["Refseq_Acc"])
	
	#Write file with SequenceID to TaxID as tab delimited file
    dataframe_SequenceID_TaxID.to_csv(path_to_files + 'seqid2taxid_model_bacteria.map', header=None, index=None, sep='\t', mode='w')


def main():
    dataframe_RefseqACC_TaxID = load_file_acc_tax()
    load_file_acc_seqid(dataframe_RefseqACC_TaxID)

main()
