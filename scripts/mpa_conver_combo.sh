#!/bin/bash

# convert Bracken output to MPA format and combine into a single file
mkdir mpa_conv_species

for  file in brack_krak_species/*_report_bracken_species.txt; do
    filename=$(basename "$file")
    sample_name="${filename%_S*_report_bracken_species.txt}"
    python ~/conda/envs/bioinfo/bin/kreport2mpa.py \
    -r "$file" \
    -o "mpa_conv_species/${sample_name}_mpa.txt" \
    --display-header
done

python ~/conda/envs/bioinfo/bin/combine_mpa.py \
    -i mpa_conv_species/*_mpa.txt \
    -o combined_mpa_species.txt

# Extract species level data and clean up column names and taxonomy
grep -E "(s__)|(#Classification)" combined_mpa_species.txt | \
sed '1s/_S[0-9]*_L[0-9]*_report_bracken_species\.txt//g' | \
sed '2,$s/.*s__\([^[:space:]]*\)/\1/' > combined_species_mpa.txt