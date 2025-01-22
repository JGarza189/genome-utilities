#!/bin/bash

# Check if the input FASTA file is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <input_fasta>"
    exit 1
fi

input_fasta="$1"
output_fasta="${input_fasta%.fasta}_deduplicated.fasta"

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

# Write the filtered sequences directly to the output FASTA file
{
    while IFS= read -r line; do
        echo "$line" # Print each sequence line as is
    done < "$temp_sequences"
} > "$output_fasta"

# Clean up temporary file
rm -f "$temp_sequences"

echo "Deduplicated: $output_fasta"
