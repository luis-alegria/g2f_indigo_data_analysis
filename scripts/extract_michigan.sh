#!/bin/bash

mkdir -p {2017,2018}_{R1,R2}

for year in 2017 2018; do
    echo "Processing year: $year"
    
    # Create extraction list and extract
    : > "extract_${year}.txt"
    while read -r sample; do
        grep "$sample" "mi_extraction_files/${year}_paths.txt" >> "extract_${year}.txt"
    done < "mi_extraction_files/mi_${year}.txt"
    
    echo "Extracting $(wc -l < "extract_${year}.txt") files..."
    
    # Extract with strip-components
    if [[ "$year" == "2017" ]]; then
        tar -xzf "g2f_indigo-${year}.tar.gz" -T "extract_${year}.txt" --strip-components=3
    else
        tar -xzf "g2f_indigo-${year}.tar.gz" -T "extract_${year}.txt" --strip-components=2
    fi
    
    mv *_R1_*fastq* "${year}_R1/"
    mv *_R2_*fastq* "${year}_R2/"
    
    echo "$year: R1=$(ls ${year}_R1 | wc -l), R2=$(ls ${year}_R2 | wc -l)"
    
done