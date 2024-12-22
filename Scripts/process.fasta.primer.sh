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

  # Read the sequence from the FASTA file, ignoring the header line
  sequence=$(grep -v '^>' "$fasta_file" | tr -d '\n')

  # Print the file name and original sequence
  echo "----------------------------------"
  echo "Processing file: $fasta_file"
  echo "Original Sequence:"
  echo "$sequence"

  # Generate the complementary sequence
  complementary=$(echo "$sequence" | tr 'ACGTacgt' 'TGCAtgca')

  # Print the complementary sequence
  echo "Complementary Sequence:"
  echo "$complementary"

  # Generate the mirrored (reversed) sequence
  mirrored=$(echo "$sequence" | rev)

  # Print the mirrored sequence
  echo "Mirrored Sequence:"
  echo "$mirrored"

  # Generate the complementary of the mirrored sequence
  mirrored_complementary=$(echo "$mirrored" | tr 'ACGTacgt' 'TGCAtgca')

  # Print the complementary of the mirrored sequence
  echo "Complementary of Mirrored Sequence:"
  echo "$mirrored_complementary"
  echo "----------------------------------"
done
