#!/bin/bash --login

#SBATCH --job-name=bracken_michigan
#SBATCH --account=lilianasalvador
#SBATCH --partition=standard
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=00:03:00
#SBATCH --out=bracken_michigan.out
#SBATCH --chdir=/xdisk/lilianasalvador/luisalalegria
#SBATCH --mail-user=luisalalegria@arizona.edu
#SBATCH --mail-type=BEGIN,END,FAIL

# set variables for paths to directories and reports
krak_db="./k2_standard_16/"
reports="./k2_reports/"

source ~/.bashrc

module load micromamba
micromamba activate krak2

# run bracken for genus abudance estimation
mkdir bracken_genus

for i in $reports/*_report.txt; do
    filename=$(basename $i)
    sample=${filename%_S*_L001_report.txt}
    bracken -d $krak_db \
    -i $i \
    -o bracken_genus/${sample}_genus.txt \
    -r 50 \
    -t 1 \
    -l G
done

micromamba deactivate
module unload micromamba