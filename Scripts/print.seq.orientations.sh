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
  echo ""  # Add a blank line after "Processing file"
  echo "Original Sequence:"
  echo "$sequence"
  echo ""  # Add a blank line after original sequence

  # Generate the complementary sequence
  complementary=$(echo "$sequence" | tr 'ACGTacgt' 'TGCAtgca')

  # Print the complementary sequence
  echo "Complementary Sequence:"
  echo "$complementary"
  echo ""  # Add a blank line after complementary sequence

  # Generate the reverse sequence
  reverse=$(echo "$sequence" | rev)

  # Print the reversed sequence
  echo "Reverse Sequence:"
  echo "$reverse"
  echo ""  # Add a blank line after reverse sequence

  # Generate the complementary of the reversed sequence
  reverse_complementary=$(echo "$reverse" | tr 'ACGTacgt' 'TGCAtgca')

  # Print the complementary of the reversed sequence
  echo "Complementary of Reverse Sequence:"
  echo "$reverse_complementary"
  echo "----------------------------------"
  echo ""  # Add a blank line after complementary of reverse sequence
done
