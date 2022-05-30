#!/bin/bash
#SBATCH -n 27 -N 1 --exclusive --threads-per-core=1 -p mixedp --error=slurm-%j.err --output=slurm-%j.out
export OMP_NUM_THREADS=1
module load intel/18.0.1.163 openmpi/4.1.3-intel #mpi/impi-intel2018 cmake ScientificLibraries/silo/4.11 anaconda2
echo $LD_LIBRARY_PATH, $CC
mpirun -n 27 ../exec/main
