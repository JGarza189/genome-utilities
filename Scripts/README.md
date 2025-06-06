# Scripts

### print-sequence-orientations.sh

Prints original FASTA sequence, complementary sequence, reverse sequence, and reverse complementary sequence at the command line.

#### Usage:

To run the script with one or more FASTA files, use the following command:

`./print.seq.orientations.sh <fasta_file1> <fasta_file2> ... <fasta_fileN>`
 <br><br>

### concatenate-fasta.sh

Combines any number of FASTA files into a single concatenated FASTA file.

#### Usage:

To run the script with one or more FASTA files, use the following command:

`./concatenate.fasta.sh <fasta_file1> <fasta_file2> ... <fasta_fileN>`
 <br><br>

### generate-fastq.py

Converts a .phd Sanger file into a .fastq file.

#### Usage:

To run this script with a single .phd file, use the following command:

`./generate.fastq.sh <input.phd> <output.fastq>`
 <br><br>
 
### generate-FastQC.sh

Generates a FastQC report, a quality control tool for high-throughput sequence data on one or more FASTQ files. This script simplifies the process of running FastQC, producing detailed HTML reports and raw data summaries to assess the quality of sequencing reads. ADD DEPENDENCY HERE TO DOWNLOAD FASTQC.

#### Usage:

To run this script with one or more FASTQ files, use the following command:

`./generate.FastQC.sh <fastq_file1> <fastq_file2> ... <fastq_fileN>`
 <br><br>
  
### deduplicate-fasta.sh

Processes a concatenated FASTA file by removing duplicate sequences and filters out those with ambiguous or missing nucleotides.

#### Usage:

To run this script with a FASTA file, use the following command:

`./deduplicate.fasta.sh <fasta_file>`
 <br><br>
