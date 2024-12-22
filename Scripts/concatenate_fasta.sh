#!/bin/bash

# Check if exactly two input files are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <file1> <file2>"
  exit 1
fi

# Concatenate the two input FASTA files into a new file called two_seqs.fasta
# Ensure each file is on a new line, and add a newline after the header and before the sequence.
cat "$1" | sed 's/$/\n/' > temp_file1.fasta
cat "$2" | sed 's/$/\n/' > temp_file2.fasta

# Concatenate the files
cat temp_file1.fasta temp_file2.fasta > two_seqs.fasta

# Clean up temporary files
rm temp_file1.fasta temp_file2.fasta

# Print a message indicating the task is complete
echo "FASTA files '$1' and '$2' have been concatenated into two_seqs.fasta"
