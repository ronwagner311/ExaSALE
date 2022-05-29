# Backus: A Scalable Framework for Scientific Code in Modern Fortran and MPI-3
This repository contains the code that originates for the idea presented [https://arxiv.org/abs/1910.06415].


## Prerequisits

This code was tested with:
1. intel/2017 or intel/2018
2. OpenMPI 1.10.4 and OpenMPI 4.0.4 - any OpenMPI that supports MPI3+ standard.
3. json-fortran https://github.com/jacobwilliams/json-fortran compiled with the same intel.
4. cmake 3.15 or higher
5. Silo for diagnostic

## Folders Documentation

The src folder contains the source code files of Backus, here is a short documentation of its subfolders.

|Folder                    |Documentation                                                                   |
|:---:                     |:---                                                                            |
|**Boundary_conditions**   |Contains the classes that implement the Boundary Conditions                     |
|**CR**                    |Contains the classes that implement the Checkpoint Restart                      |
|**Datafiles**             |Contains all the input datafiles for Backus                                     |
|**Diagnostics**           |Contains the modules and code files that implement the Diagnostics              |
|**General**               |Contains General modules and code files for Backus                              |
|**Input**                 |Contains the classes that parse the input datafile                              |
|**Main**                  |Contains the main code files of Backus                                          |
|**Material**              |Contains the classes that belong to the materials                               |
|**Mesh**                  |Contains the mesh implementation classes                                        |
|**Parallel**              |Contains the Parallelization implementation classes                             |
|**Quantities**            |Contains all the Physical quantities classes in Backus                          |
|**Rezone_and_Advect**     |Contains the implementation of the rezone and advection classes                 |
|**Scripts**               |Contains the Scripts code files                                                 |
|**Time_step**             |Contains the hydrodynamic time step implementation                              |
|**exec**                  |Contains the executable file, created after compilation                         |


## Compile & Install
This project is built via cmake. In order to create the makefiles and the executable you need to run the following commands from the Backus main directory:
```
mkdir build
cd build
cmake ../src
make
```
Or alternatively, enter the directory `src/Scripts` using `cd` command and execute the following bash script:
```
./clean.sh
```
The script creates a folder named build that contains the .o and .a files. In addition, the execution file is located at the directory:
```
src/exec/main
```
Once the makefiles are created, you can simple compile the project with `./make.sh` bash script, located in `src/Scripts` directory.\
\
**Please load the modules before compiling**


## Execution
To run the code simply execute the bash script ./run.sh located in src/Scripts. The script executes the mpirun command, so beware that if you change number of processes in the datafile, this line should be updated.

To run the code using slurm execute the python script slurm_run.py located in src/Scripts. The script checks the number of processes in the datafile and send the relevant job to slurm. Please note that you need to change the partion for your machine in the script and change the module load relevant for your machine.

The scripts runs the datafile located in src/Datafiles/datafile.json

## Datafile
The datafile is written as a json file (parsed via the json-fortran module explained above -- it is possible to write a new parser as long as it knows how to read a json file). The main objective of the datafile is to be parsed by the src/Input/datafile_object.f90 module which reads and parses the datafile in order to properly define the execution.

The following segment will describe the datafile in pieces.

1. Materials - Each material is defined by a name, its EoS (currently only ideal gas is allowed) and other properties such as density, initial energy etc:
```json
"Your_Material": {
        "A": 4.0, ! atomic number
        "index": 1,  ! Index that will appear in the order of materials
        "Z_2": 4.0,  
        "gamma_gas": 1.667, 
        "rho_0": 1.0, ! initial density
        "Z": 2.0, 
        "sie_0": 0.0, ! if set to 0, the energy will be calculated from the EoS (given a temperature)
        "eos_type": "ideal" ! type of EoS, can see in src/Input/replace_words.f90 for more options
    } 
```

## Sedov-Taylor

To execute sedov-taylor please refer to the datafile Datafiles/datafile_sedov_taylor_3d.json, simply execute the code explained above.
For example this is the initial state of the problem (3D, 15^3 cells)
![Initial Problem](https://github.com/Scientific-Computing-Lab-NRCN/Backus/blob/main/Images/visit0005.png)


Lagrangian mesh:

![Lagrange](https://github.com/Scientific-Computing-Lab-NRCN/Backus/blob/main/Images/visit0007.png)


ALE:
![ALE](https://github.com/Scientific-Computing-Lab-NRCN/Backus/blob/main/Images/visit0006.png)
