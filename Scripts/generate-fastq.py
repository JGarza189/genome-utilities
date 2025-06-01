#!/usr/bin/env python3

import sys
from Bio import SeqIO

if len(sys.argv) < 3:
    print("Usage: genearate.fastq.py <input.phd> <output.fastq>")
    sys.exit(1)

input_phd = sys.argv[1]
output_fastq = sys.argv[2]

try:
    with open(input_phd, "r") as phd:
        record = SeqIO.read(phd, "phd")
        with open(output_fastq, "w") as fastq:
            SeqIO.write(record, fastq, "fastq")
    print(f"Conversion successful: {input_phd} to {output_fastq}")
except Exception as e:
    print(f"Error: {e}")

