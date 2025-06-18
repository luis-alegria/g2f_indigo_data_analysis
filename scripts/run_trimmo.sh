#!/bin/bash

# run trimmomatic on paired-end reads
adapters="$CONDA_PREFIX/share/trimmomatic-0.39-2/adapters/TruSeq3-PE.fa"
cd mi_samples/2017_pairs/


for i in *_R1_001.fastq.gz; do
    base=$(basename "$i" _R1_001.fastq.gz)
    trimmomatic PE -threads 4 \
        ${i} ${base}_R2_001.fastq.gz \
        ${base}_R1_001.trim.fastq.gz ${base}_R1un.trim.fastq.gz \
        ${base}_R2_001.trim.fastq.gz ${base}_R2un.trim.fastq.gz \
        ILLUMINACLIP:"$adapters":2:30:10 \
        LEADING:3 \
        TRAILING:3 \
        SLIDINGWINDOW:4:20 \
        MINLEN:50
    echo "Processed $i"
    echo "Processed ${base}_R2_001.fastq.gz"
done

cd ../2018_pairs/

for i in *_R1_001.fastq.gz; do
    base=$(basename "$i" _R1_001.fastq.gz)
    trimmomatic PE -threads 4 \
        ${i} ${base}_R2_001.fastq.gz \
        ${base}_R1_001.trim.fastq.gz ${base}_R1un.trim.fastq.gz \
        ${base}_R2_001.trim.fastq.gz ${base}_R2un.trim.fastq.gz \
        ILLUMINACLIP:"$adapters":2:30:10 \
        LEADING:3 \
        TRAILING:3 \
        SLIDINGWINDOW:4:20 \
        MINLEN:50
    echo "Processed $i"
    echo "Processed ${base}_R2_001.fastq.gz"
done

echo "Trimmomatic processing complete for all paired-end reads."