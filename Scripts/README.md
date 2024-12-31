## Scripts

### print.seq.orientations.sh

Prints original FASTA sequence, complementary sequence, reverse sequence, and reverse complementary sequence.

#### Usage:

To run the script with one or more FASTA files, use the following command:

`./print.seq.orientations.sh <fasta_file1> <fasta_file2> ... <fasta_fileN>`
 <br><br>

### concatenate.fasta.sh

Combines any number of FASTA files into a single concatenated FASTA file.

#### Usage:

To run the script with one or more FASTA files, use the following command:

`./concatenate.fasta.sh <fasta_file1> <fasta_file2> ... <fasta_fileN>`
 <br><br>

### generate.fastq.sh

Converts a .phd sequencing file to a .fastq file, provided Python3 and BioPython are installed.

#### Usage:

To run this script with a single .phd file, use the following command:

`./generate.fastq.sh <input.phd> <output.fastq>`
 <br><br>
 
### generate.FastQC.sh

Generates a FastQC report, a quality control tool for high-throughput sequence data on one or more FASTQ files. This script simplifies the process of running FastQC, producing detailed HTML reports and raw data summaries to assess the quality of sequencing reads.

#### Usage:

To run this script with one or more FASTQ files, use the following command:

`./generate.FastQC.sh <fastq_file1> <fastq_file2> ... <fastq_fileN>`
 <br><br>

### generate.reverse.complement.sh 

Script to generate the reverse complement of a FASTA file and outputs the results as a new FASTA file.

#### Usage:

To run this script with a FASTA file, use the following command:

`./generate.reverse.complement.sh <fasta_file1> `
 <br><br>
 
### wrangle.csv.sh

Wrangles one or more .csv files by replacing all spaces with periods throughout the entire document.

#### Usage:

To run this script with one or more .csv files, use the following command:

`./wrangle.csv.sh  <csv_file1> <csv_file2> ... <csv_fileN>`
 <br><br>
 
### plot.BLAST.output.R

Reads a csv. file containing BLAST output (description table), extracts and analyzes the top 10 most frequent genera, and generates dot and bar plots saved in a new directory. 

#### Usage:

To run this script with a .csv file, use the following command:

`./plot.BLAST.output.R <csv_file>`
 <br><br>