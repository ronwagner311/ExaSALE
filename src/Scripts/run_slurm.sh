#!/bin/bash
#SBATCH -n 1 -N 1 --exclusive --threads-per-core=1 -p mixedp --error=slurm-%j.err --output=slurm-%j.out
export OMP_NUM_THREADS=1
module load intel/18.0.1.163 openmpi/4.0.4_intel mpi/impi-intel2018 cmake anaconda2
mpirun -n 1 /home/reemh/eclipse-workspace_ronw/Backus/src/exec/main
