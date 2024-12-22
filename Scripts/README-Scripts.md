# Scripts

Contents:

BLAST.unique.hit.sh: Script to that makes a copy of an exported NCBI BLAST file located in the /Hard-Data directory, and places it in the /Processed-Data directory .. then the script wrangles the data to be piped into R.
	Run the script above in the Scripts Directory: 
		
		Example: ./BLAST.unique.hit.sh ../Hard-Data/file_name.csv


BLAST.unique.hit.R: Script to visualize unique hits in a BLAST search 
	Run the script in the Scripts Directory:
		
		Example: ./BLAST.unique.hit.R ../Processed-Data/CO1.BLAST.Shinzato-21_processed.csv ../Processed-Data
		or
		Example: ./BLAST.unique.hit.R $PROCESSED_DATA/CO1.BLAST.Shinzato-21_processed.csv $PROCESSED_DATA

process.fasta.primer.sh: Script to print the original primer sequence, complementary sequence, mirrored sequence, and
complementary of mirrored sequence. 
	Run the script in the Hard-Data directory:

		Example: ../Scripts/process.fasta.primer.sh ITS2-FWD-PRIMER.fasta ITS2-REV-PRIMER.fasta

concatenate_fasta.sh: This script concatenates two FASTA files into a single file named two_seqs.fasta. It takes two input FASTA files as arguments and combines them in the specified output file.
	Run this script in the Output directory

		Example: ../Scripts/concatenate_fasta.sh ITS-ITS2F_2024-12-09_E01_copy_inspected_trimmed.fasta ITS-ITS2R_2024-12-09_F01_inspected_trimmed.fasta

reverse.complement.sh: Script to create a reverse complement of a fasta file and outputs a new fasta file
	Run this script in the Output directory 
	
		Example: ../Scripts/reverse.complement.sh ITS-ITS2R_2024-12-09_F01_inspected_trimmed.fasta

reverse.sh: Script to create reverse script of an inputted fasta file and outputs a new fasta file
	Run this script in the Output Directory
	
		Example: ../Scripts/reverse.sh ITS-ITS2R_2024-12-09_F01_inspected_trimmed.fasta

complement.sh: Script to create a complement of a fasta file and outputs a new fasta file
	Run this script in the Output directory
	
		Example: ../Scripts/complement.sh ITS-ITS2R_2024-12-09_F01_inspected_trimmed.fasta

phd-fastq.sh: Scripts that converts a phd1 file into a fastq file
	Run this script in the Output Directory and activate conda

		Example: ../Scripts/phd-fastq.sh ITS-ITS2F_2024-12-09_E01-copy.phd.1 output.fastq



FastQC Report: Creates a report of sequence in a fastq form
	Run this script in the Output Directory
	
		Example: fastqc ITS-ITS2F_2024-12-09_E01-copy.fastq ITS-ITS2R_2024-12-09_F01-copy.fastq



