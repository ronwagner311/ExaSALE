# Backus: A Scalabale Framework for Scientific Code in Modern Fortran and MPI-3
This repository contains the code that originates for the idea presented [https://arxiv.org/abs/1910.06415].


## Prerequisits

This code was tested with:
1. intel/2017 or intel/2018
2. OpenMPI 1.10.4 and OpenMPI 4.0.4 - any OpenMPI that supports MPI3+ standard.
3. json-fortran https://github.com/jacobwilliams/json-fortran compiled with the same intel.
4. cmake 3.15 or higher
5. Silo for diagnostic

## Compile & Install
This project is built via cmake. In order to create the makefiles, simply enter the src/Scripts directory and execute the clean.sh bash script. The script creates a folder named build that contains the .o and .a files. In addition, the execution file is located at src/exec/main. Once the makefiles are created, you can simple compile the project with the script make.sh that is located in the same folder as clean.sh (clean.sh automatically compiles after creating the make files). Please load the modules before compiling.

## Execution
To run the code simply execute the bash script ./run.sh located in src/Scripts. The script executes the mpirun command, so beware that if you change number of processes in the datafile, this line should be updated.

To run the code using slurm execute the python script slurm_run.py located in src/Scripts. The script checks the number of processes in the datafile and send the relevant job to slurm. Please note that you need to change the partion for your machine in the script and change the module load relevant for your machine.

The scripts runs the datafile located in src/Datafiles/datafile.json


