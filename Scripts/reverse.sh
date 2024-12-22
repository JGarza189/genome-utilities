#!/bin/bash

# Check if at least one file is provided
if [ $# -eq 0 ]; then
  echo "Usage: $0 <fasta_file1> <fasta_file2> ... <fasta_fileN>"
  exit 1
fi

# Loop through all provided FASTA files
for fasta_file in "$@"; do
  # Ensure the file exists
  if [ ! -f "$fasta_file" ]; then
    echo "Error: File '$fasta_file' not found."
    continue
  fi

  # Read the header and sequence from the FASTA file
  header=$(head -n 1 "$fasta_file")
  sequence=$(grep -v '^>' "$fasta_file" | tr -d '\n')

  # Modify the header to append "_reverse" at the end
  new_header="${header}_reverse"

  # Generate the reversed sequence
  reversed=$(echo "$sequence" | rev)

  # Output the new header and reversed sequence to a new FASTA file
  output_file="${fasta_file%.fasta}_reverse.fasta"
  echo "$new_header" > "$output_file"
  echo "$reversed" >> "$output_file"
  
  echo "Reversed sequence saved to: $output_file"
done
