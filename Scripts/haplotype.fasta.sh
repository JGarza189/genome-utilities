#!/bin/bash

# Check if the input FASTA file is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <input_fasta>"
    exit 1
fi

input_fasta="$1"
output_fasta="${input_fasta%.fasta}_haplotyped.fasta"

# Temporary file to store unique and filtered sequences
temp_sequences=$(mktemp)

# Extract and deduplicate sequences
awk '/^>/ {if (seq) {print seq; seq=""} print; next} {seq = seq $0} END {if (seq) print seq}' "$input_fasta" | \
    awk '/^>/ {header=$0; next} {
        # Filter sequences with ambiguous or missing nucleotides
        if ($0 !~ /[^GATC]/) {
            if (!seen[$0]++) {
                print header > "'"$temp_sequences"'"
                print $0 > "'"$temp_sequences"'"
            }
        }
    }'

# Format sequences into chunks of 10 nucleotides grouped within single lines
{
    while IFS= read -r line; do
        if [[ "$line" == ">"* ]]; then
            echo "$line" # Print header
        else
            # Group sequences into chunks of 10 nucleotides
            echo "$line" | fold -w 10 | paste -sd' ' -
        fi
    done < "$temp_sequences"
} > "$output_fasta"

# Clean up temporary file
rm -f "$temp_sequences"

echo "Haplotyped & Parsed: $output_fasta"
