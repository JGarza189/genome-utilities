#!/bin/bash

# Check if at least one argument is provided
if [ $# -lt 1 ]; then
    echo "Usage: $0 <input_csv_file> [<input_csv_file> ...]"
    exit 1
fi

# Loop through all specified input files
for input_file in "$@"; do
    # Check if the file exists
    if [ ! -f "$input_file" ]; then
        echo "File not found: $input_file"
        continue
    fi

    # Get the directory and base name of the input file
    dir_name=$(dirname "$input_file")
    base_name=$(basename "$input_file" .csv)

    # Define the output file path with "_wrangled" appended
    output_file="${dir_name}/${base_name}_wrangled.csv"

    # Replace all spaces with periods and save to the output file
    sed 's/ /./g' "$input_file" > "$output_file"

    echo "Processed file: $input_file -> $output_file"
done
