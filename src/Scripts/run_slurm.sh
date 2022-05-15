#!/bin/bash
#SBATCH -n 1 -N 1 --exclusive --threads-per-core=1 -p sc --error=slurm-%j.err --output=slurm-%j.out
export OMP_NUM_THREADS=1
module load cmake/X.XX.2 eclipse/2018 gcc/9.1.0 intel/2017 json-fortran/intel-2017 mpi/openmpi-1.10.4-intel-2017 pFUnit/3.2.9-openmpi-1.10.4-intel-2017 hdf5/1.8.9-openmpi-1.10.4-intel-2017 silo/4.8-openmpi-1.10.4-intel-2017 scr/1.2.0-openmpi-1.10.4-intel-2017
source activate backus-openmpi-1.10.4-intel-2017
mpirun -n 1 -mca btl self,sm,openib ../exec/main
