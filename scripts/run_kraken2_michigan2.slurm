#!/bin/bash --login

#SBATCH --job-name=kraken2_michigan_2
#SBATCH --account=lilianasalvador
#SBATCH --partition=standard
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --time=00:30:00
#SBATCH --out=kraken2_michigan_2.out
#SBATCH --chdir=/xdisk/lilianasalvador/luisalalegria
#SBATCH --mail-user=luisalalegria@arizona.edu
#SBATCH --mail-type=BEGIN,END,FAIL

# set variables for paths to directories and files
krak_db="./k2_standard_16/"
files="./g2f_indigo/mi_samples_krak/"

source ~/.bashrc

module load micromamba
micromamba activate krak2

# run kraken2 on paired files
mkdir k2_{outputs,reports}

for i in $files/*_R1_001.trim.fastq.gz; do
    filename=$(basename $i)
    base=${filename%_R1_001.trim.fastq.gz}
    kraken2 --db $krak_db \
    --threads 6 \
    --output k2_outputs/${base}_output.txt \
    --report k2_reports/${base}_report.txt \
    --paired $files/${base}_R1_001.trim.fastq.gz \
    $files/${base}_R2_001.trim.fastq.gz
    
done

micromamba deactivate
module unload micromamba