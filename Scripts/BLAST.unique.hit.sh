# BLAST Unique Hit Script

#!/bin/bash

# Check if at least one argument is provided
if [ $# -lt 1 ]; then
    echo "Usage: $0 <input_csv_file> [<input_csv_file> ...]"
    exit 1
fi

# Define the processed data directory
processed_dir="../Processed-Data"

# Make sure the output directory exists
mkdir -p "$processed_dir"

# Loop through all specified input files
for input_file in "$@"; do
    # Check if the file exists
    if [ ! -f "$input_file" ]; then
        echo "File not found: $input_file"
        continue
    fi

    # Get the base name of the file (without the path and extension)
    base_name=$(basename "$input_file" .csv)
    
    # Define the output file path
    output_file="$processed_dir/${base_name}_processed.csv"
    
    # Copy the input file to the Processed-Data directory
    cp "$input_file" "$output_file"

    # Replace all spaces with periods in the entire file
    sed -i '' 's/ /./g' "$output_file"

    echo "Processed file: $input_file -> $output_file"
done