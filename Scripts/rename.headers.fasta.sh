#!/bin/bash

# Check if the input FASTA file is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <input_fasta>"
    exit 1
fi

input_fasta="$1"
output_fasta="${input_fasta%.fasta}_renamed.fasta"

# Process the FASTA file
awk '
    BEGIN { OFS = "\n" } 
    # For headers starting with >lcl|Query_, leave them unchanged
    /^>lcl\|Query_/ { print; next }

    # For other headers, extract the accession number and organism name, then rename the header
    /^>/ {
        # Extract accession number from the header (e.g., >gb|AY258488.1|)
        if (match($0, /gb\|([^\|]+)\|/)) {
            accession_number = substr($0, RSTART+3, RLENGTH-3)  # Extract accession number
        }

        # Extract organism name from the header using sub()
        if (match($0, /\[organism=([^\]]+)\]/)) {
            organism_name = substr($0, RSTART+10, RLENGTH-11)  # Extract organism name
            gsub(/ /, ".", organism_name)  # Replace spaces in organism name with periods
            print ">" accession_number "_" organism_name  # Print the new header with accession number and organism name
        } else {
            print $0  # Print the original header if no organism info is found
        }
        next
    }

    # For sequence lines, print them as is
    { print }
' "$input_fasta" > "$output_fasta"

echo "Renamed FASTA file created: $output_fasta"
