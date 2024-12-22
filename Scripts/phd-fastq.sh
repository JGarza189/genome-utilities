#!/bin/bash

# Check if Python3 and BioPython are available
command -v python3 &>/dev/null || { echo "Python3 not found. Please install it."; exit 1; }
python3 -c "import Bio" &>/dev/null || { echo "BioPython is not installed. Install it using 'pip install biopython'."; exit 1; }

# Ensure user provides correct number of arguments
if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <input.phd> <output.fastq>"
  exit 1
fi

# Assign input arguments to variables
input_phd="$1"
output_fastq="$2"

# Python script to convert .phd to .fastq
python3 - <<EOF
import sys
from Bio import SeqIO

def convert_phd_to_fastq(phd_file, fastq_file):
    """
    Convert a PHRED .phd file to FASTQ format.
    """
    try:
        with open(phd_file, "r") as phd:
            # Parse the PHRED file
            record = SeqIO.read(phd, "phd")
            with open(fastq_file, "w") as fastq:
                # Write the converted record to a FASTQ file
                SeqIO.write(record, fastq, "fastq")
        print(f"Conversion successful: {phd_file} to {fastq_file}")
    except Exception as e:
        print(f"Error: {e}")

# Run conversion
convert_phd_to_fastq("$input_phd", "$output_fastq")
EOF
