#!/bin/bash

# create a directory for output
 cd mi_samples
 mkdir {2017,2018}_qc_trimmed

 # run fastqc on files
 echo "Running FastQC ..."
for dir in 2017_trimmed 2018_trimmed; do
    year=$(echo $dir | cut -d'_' -f1)
    fastqc $dir/*_R[12]_001.trim.fastq.gz -o ${year}_qc_trimmed
done
echo "FastQC completed."

echo "Running MultiQC ..."
# run multiqc
for year in 2017 2018; do
    multiqc ${year}_qc_trimmed -n ${year}_trimmed_multiqc_report.html
done
echo "MultiQC completed."