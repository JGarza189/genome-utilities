#!/bin/bash

# This script runs FastQC on one or more FASTQ files

# Check if at least one FASTQ file is provided
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <fastq_file1> <fastq_file2> ... <fastq_fileN>"
    exit 1
fi

# Loop through all input files
for file in "$@"; do
    if [[ -f "$file" ]]; then
        echo "Running FastQC on $file..."
        fastqc "$file"
    else
        echo "Error: $file does not exist."
    fi
done

echo "FastQC analysis completed."
