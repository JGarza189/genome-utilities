#!/bin/bash

# Check if exactly two input files are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <file1> <file2>"
  exit 1
fi

# Create or overwrite the output file
output_file="concatenated.seqs.fasta"
> "$output_file"

# Process each input file to add a blank line after each sequence
for file in "$1" "$2"; do
  awk 'NR==1 {print; next} /^>/ {print "\n"$0; next} {print}' "$file" >> "$output_file"
done

# Print a message indicating the task is complete
echo "FASTA files '$1' and '$2' have been concatenated into $output_file"
