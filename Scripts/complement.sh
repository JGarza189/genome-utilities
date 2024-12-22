<<<<<<< HEAD
#!/bin/bash 
=======
#!/bin/bash
>>>>>>> a81c9d80f7bf89aa7a7e2c89ba98a0c3aa5b6e23

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

  # Read the header and sequence from the FASTA file
  header=$(head -n 1 "$fasta_file")
  sequence=$(grep -v '^>' "$fasta_file" | tr -d '\n')

  # Modify the header to append "_complement" at the end
  new_header="${header}_complement"

  # Generate the complementary sequence
  complement=$(echo "$sequence" | tr 'ACGTacgt' 'TGCAtgca')

  # Output the new header and complement sequence to a new FASTA file
  output_file="${fasta_file%.fasta}_complement.fasta"
  echo "$new_header" > "$output_file"
  echo "$complement" >> "$output_file"

  echo "Complement sequence saved to: $output_file"
done
