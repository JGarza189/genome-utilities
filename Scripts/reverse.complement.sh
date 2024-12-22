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

  # Modify the header to append "_reverse_complement" at the end
  new_header="${header}_reverse_complement"

  # Generate the mirrored (reversed) sequence
  mirrored=$(echo "$sequence" | rev)

  # Generate the complementary of the mirrored sequence
  mirrored_complementary=$(echo "$mirrored" | tr 'ACGTacgt' 'TGCAtgca')

  # Output the new header and reverse complement sequence to a new FASTA file
  output_file="${fasta_file%.fasta}_reverse_complement.fasta"
  echo "$new_header" > "$output_file"
  echo "$mirrored_complementary" >> "$output_file"
  
  echo "Reverse complement sequence saved to: $output_file"
done
