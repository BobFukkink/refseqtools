import pandas as pd

#Specify folder with files
path_to_files = "PATH/TO/FOLDER"

def load_model_files_into_dataframe():
	#load accessions, taxids, lengths files model organisms
    dataframe_accessions = pd.read_csv(path_to_files + '/models_refseq_accessions_list.txt', header=None, sep='\t')
    dataframe_taxids = pd.read_csv(path_to_files + '/models_taxids_list.txt', header=None, sep='\t')
    dataframe_sequence_lengths = pd.read_csv(path_to_files + '/models_lengths_list.txt', header=None, sep='\t')
    
    #Concatenate the three files together to format accession	taxid	length
    concatenated_dataframes_representatives = pd.concat([dataframe_accessions, dataframe_taxids, dataframe_sequence_lengths], axis=1)
    
    #Write as tab delimited file
    concatenated_dataframes_representatives.to_csv(path_to_files + '/model_bacteria_file_accession_taxid_length.DNA', header=None, index=None, sep='\t', mode='w')

def load_bacteria_files_into_dataframe():
	#load accessions, taxids, lengths files bacteria
    dataframe_accessions = pd.read_csv(path_to_files + '/bacteria_refseq_accessions_list.txt', header=None, sep='\t')
    dataframe_taxids = pd.read_csv(path_to_files + '/bacteria_taxids_list.txt', header=None, sep='\t')
    dataframe_sequence_lengths = pd.read_csv(path_to_files + '/bacteria_lengths_list.txt', header=None, sep='\t')

	#Concatenate the three files together to format accession	taxid	length
    concatenated_dataframes_representatives = pd.concat([dataframe_accessions, dataframe_taxids, dataframe_sequence_lengths], axis=1)
	
	#Add to tab delimited file
    concatenated_dataframes_representatives.to_csv(path_to_files + '/model_bacteria_file_accession_taxid_length.DNA', header=None, index=None, sep='\t', mode='a')

def main():
    load_model_files_into_dataframe()
    load_bacteria_files_into_dataframe()

main()
