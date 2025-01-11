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

    # For other headers, extract the organism name and rename the header
    /^>/ {
        # Extract organism name from the header using sub()
        if (match($0, /\[organism=([^\]]+)\]/)) {
            organism_name = substr($0, RSTART+10, RLENGTH-11)  # Extract organism name
            gsub(/ /, ".", organism_name)  # Replace spaces in organism name with periods
            print ">" organism_name  # Print the new header
        } else {
            print $0  # Print the original header if no organism info is found
        }
        next
    }

    # For sequence lines, print them as is
    { print }
' "$input_fasta" > "$output_fasta"

echo "Renamed FASTA file created: $output_fasta"
