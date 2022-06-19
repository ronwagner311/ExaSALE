# Backus: A Scalable Framework for Scientific Code in Modern Fortran and MPI-3
This repository contains the code that originates for the idea presented [https://arxiv.org/abs/1910.06415].


## Prerequisits

This code was tested with:
1. intel/2017 or intel/2018 and OneAPI 2021
2. OpenMPI 1.10.4, 4.0.4, 4.1.3 - any OpenMPI that supports MPI3+ standard.
3. json-fortran https://github.com/jacobwilliams/json-fortran compiled with the same intel.
4. cmake 3.15 or higher
5. Silo for diagnostic (optional)

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
### Execute Locally
To run the code simply execute the bash script `./run.sh` located in `src/Scripts` directory.\
The script executes the following mpirun command:
```
mpirun -n np ../exec/main
```
Where `np` is the number of mpi processes that are being used.\
In order to run Backus the number of processes in the executation command needs to be similar to the number of processes in the datafile.\
So if you change the number of processes in the datafile **you need to update the number of processes in `run.sh` accordingly**.

#### Execute on a Cluster
To run the code using slurm execute the python script `slurm_run.py` located in `src/Scripts` directory.\
The script checks the number of processes in the datafile and send the relevant job to slurm. The scripts runs the datafile located in `src/Datafiles/datafile.json`\
Please note that you need to change the partition in the job request script:
```
-p mixedp
```
In our case the partition is mixedp, you need to change it to the partition you are using on your cluster.\
In addition, you need to change the module load on the job request to the modules you are loading on your claster (if needed). The relevant part in the job request script is:
```
module load intel/18.0.1.163 openmpi/4.0.4_intel mpi/impi-intel2018 cmake anaconda2 ScientificLibraries/silo/4.11
```

## Datafile
The datafile is written as a json file (parsed via the json-fortran module explained above -- it is possible to write a new parser as long as it knows how to read a json file). The main objective of the datafile is to be parsed by the src/Input/datafile_object.f90 module which reads and parses the datafile in order to properly define the execution. 

For the general case, expanding new options, or exploring existing ones can be found in the files datafile_object.f90, replace_words.f90 and defaults.f90 in the folder src/Input. Expanding the datafile can be simply done by following the same coding pattern - adding a default value if needed and allowing words instead of integers and finally parsing them and adding them to the datafile_object.f90 object (that will be passed to src/Main/problem.f90 which builds the classes and physical modules). 

The following segment will describe the datafile in pieces.

1. Materials - Each material is defined by a name, its EoS (currently only ideal gas is allowed) and other properties such as density, initial energy etc:
```json
"Your_Material": {
        "A": 4.0, # atomic number
        "index": 1,  # Index that will appear in the order of materials
        "Z_2": 4.0,  
        "gamma_gas": 1.667, 
        "rho_0": 1.0, # initial density
        "Z": 2.0, 
        "sie_0": 0.0, # if set to 0, the energy will be calculated from the EoS (given a temperature)
        "eos_type": "ideal" # type of EoS, can see in src/Input/replace_words.f90 for more options
    } 
```
2. The layers of the materials - to define the mesh, you first need to define the layers and materials that fill that mesh. It also defines number of cells in each layer. Of course, for the 3d case you should add "number_layers_k"! The following json creates 4 layers, 20x20 cells in each layer - (in case it is an xy mesh, imagine it is a box split into four right in the middle and from left to right then bottom to up it goes material1, material2, material2 and material1.
```json
 "layers_materials": {
    	"number_layers_j": 2,
        "number_cells_j": [
            20,
            20
        ], 
        "number_layers_i": 2, 
        "number_cells_i": [
            20, 
            20
        ], 
        "materials": [
            "Your_material1", 
            "Your_material2",
            "Your_material2", 
            "Your_material1"
        ]
    }, 
```

3. Boundary condition & Mesh type - Every phyiscal problems requires boundary conditions and defenition of which mesh_type. Currently, it supports 3 different meshes: 2d xy, 3d xyz and 3d pyramid. To add a new mesh, simply expand the src/Mesh/mesh_2d or src/Mesh/mesh_3d to build a new way for the X,Y,Z coordinates. the values are integers, which are explained in src/Main/problem. 
```json
"cell_set": {
        "mesh_type": "x_y", 
        "boundary_conditions": [
            2, 
            2, 
            2, 
            2
        ]
    }, 
```

4. General switches - define different symetries, vertex mass calculation (diamond, etc.) and schemes in general, is defined in the following json segment. 
```json
"switches": {
        "sw_symmetry": 0, 
	"cyl": 0,
        "sw_vert_mass": 1, 
        "sw_nraz": 1
    }, 
```

5. Contours - Between each two layers (and the different axis) a contour must be defined for the maximal value, and minimal value of the coordinates. We allow multiple ways to define the contours for example an elipse or a simple straight line. Usually, the j and the k contours are defined as the angles. For a more general case of building a mesh, please edit the code such that the contours_j and contours_k can support such a case. Please note that the symmetry axis is I, therefore usually you will want to define a simple box by giving I the boundaries of the box and the J as a "dummy angle argument" such as follows: this will create a box, specifically 4 boxes with 4 different layers: the first layer is bounded from (0,0) to (0.5,0) , the second layer (0.5,0) to (1,0), the third layer from (0.5,0) to (0.5,0.5) and the last layer from (0.5,0.5) to (1,1). 

```json
"contours": {
        "contours_j": [
            {
                "units": "regular", 
                "theta0": 0.0
            }, 
            {
                "units": "regular", 
                "theta0": 0.5
            }, 
            {
                "units": "regular", 
                "theta0": 1.0
            }
        ], 
        "contours_i": [
            {
                "y1": -1, 
                "x2": 0, 
                "x1": 0, 
                "y2": 2, 
                "contour_type": "line"
            }, 
            {
                "y1": -1, 
                "x2": 0.5, 
                "x1": 0.5, 
                "y2": 2, 
                "contour_type": "line"
            }, 
            {
                "y1": -1, 
                "x2": 1, 
                "x1": 1, 
                "y2": 2, 
                "contour_type": "line"
            }
        ]
    }, 
```

6. Zones - After defining the contour, sometimes the user will want to give each cell a different size, thie is defined in the zone segement. Whereas, constant defines each cell to be in the same size (dr and d_theta are for other types of zones, such a geometry series etc...)
```json
 "zone": {
        "zone_i": [
            {
                "type": "constant", 
                "dr": 0.0
            }, 
            {
                "type": "constant", 
                "dr": 0.0
            }
        ], 
        "zone_j": [
            {
                "d_theta": 0.0, 
                "type": "constant"
            },
            {
                "d_theta": 0.0, 
                "type": "constant"
            }
        ]
    }, 
```

7. Diagnostics - please refer to src/Main/problem.f90 and src/Diagnostics/* to find the different types of diagnostics that will be generated along the execution. Type currently supports silo and text only.
```json
"diagnostics": {
        "number_diagnostics": 1,
        "group": [
            {
                "condition": 1,
                "diagnostic": [  
                    {
                        "type": "text",
                        "variables": ["velocity_x", "velocity_y","position_x", "position_y", "position_z", "pressure", "density", "SIE", "time", "index"]
                    }
                ]
            }
        ]
    },
```
8. Simulation parameters - to change the parameters of the simulation such as final time, and other predefined constants, alter this segment:
```json
   "simulation_parameters": {
        "time_final": 0.3, 
	"cyl": 0,
        "init_temperature": 3.22e-08, 
        "dt": 1e-14, 
        "dt_max": 0.1
    },
```

9. Rezone type - currently only Lagrange and Euler rezoneing are allowed. 0 for lagrange 1 for euler 
```json
"rezone_advect": {
        "rezone_type": 0
    }
```

For more examples please refer to the different datafiles in src/Datafiles. 

## Sedov-Taylor
#### Datafile exmaple
The Sedov-Taylor datafile is as shown below:
```json
{
    "Hel": {
        "A": 1.0, 
        "Z_2": 1.0, 
        "gamma_gas": 1.667, 
        "rho_0": 1.0, 
	"sie_0": 1E-3,
        "Z": 1.0, 
        "eos_type": "ideal"
    },
    "Air": {
        "A": 1.0, 
        "Z_2": 1.0, 
        "gamma_gas": 1.667, 
        "rho_0": 1.0, 
	"sie_0": 5.0277E3,
        "Z": 1.0, 
        "eos_type": "ideal"
    }, 
    "switches": {
        "sw_symmetry": 0, 
        "sw_vert_mass": 1, 
        "sw_nraz": 1,
        "sw_wilkins": 0
    },
    "cell_set": {
        "mesh_type": "x_y", 
        "boundary_conditions": [
            2, 
            2, 
            2, 
            2,
            2,
            2
        ]
    }, 
    "contours": {
        "contours_j": [
            {
                "units": "regular", 
                "theta0": 0.0
            },
            {
                "units": "regular", 
                "theta0": 0.025
            }, 
            {
                "units": "regular", 
                "theta0": 1.125
            }
        ],
        "contours_k": [
            {
                "units": "regular",
                "phi0": 0.0
            },
            {
                "units": "regular",
                "phi0": 0.025
            },
            {
                "units": "regular",
                "phi0": 1.125
            }
        ],
        "contours_i": [
            {
                "y1": -10, 
                "x1": 0, 
                "y2": 10.0,
                "x2": 0, 
                "contour_type": "line"
            }, 
            {
                "y1": -10, 
                "x1": 0.025, 
                "y2": 10.0, 
                "x2": 0.025, 
                "contour_type": "line"
            },
            {
                "y1": -10, 
                "x1": 1.125, 
                "y2": 10.0, 
                "x2": 1.125, 
                "contour_type": "line"
            }
        ]
    }, 
    "zone": {
        "zone_i": [
            {
                "type": "constant", 
                "dr": 1.0
            }, 
            {
                "type": "constant", 
                "dr": 1.0
            }
        ], 
        "zone_j": [
            {
                "d_theta": 1.0, 
                "type": "constant"
            },
            {
                "d_theta": 1.0, 
                "type": "constant"
            }
        ],
        "zone_k": [
            {
                "d_phi": 1.0,
                "type": "constant"
            },
            {
                "d_phi": 1.0,
                "type": "constant"
            }
        ]
    }, 
    "diagnostics": {
        "number_diagnostics": 1,
        "group": [
            {
                "condition": 1,
                "diagnostic": [  
                    {
                        "type": "silo",
                        "variables": ["velocity_x", "velocity_y","position_x", "position_y", "position_z", "pressure", "density", "SIE", "time", "index"]
                    }
                ]
            }
        ]
    },
    "layers_materials": {
    	"number_layers_j": 2,
        "number_cells_j": [
            1,
            70
        ], 
        "number_layers_i": 2, 
        "number_cells_i": [
            1,
            70
        ],
        "number_layers_k":2,
        "number_cells_k": [
            1,
            70
        ],
        "materials": [
            "Air", 
            "Hel", 
            "Hel",
            "Hel",
            "Hel",
            "Hel"
        ]
    }, 
    "data": {
        "nyb": 3, 
        "name": "sod_3d", 
        "nxb": 102,
	    "nzb": 102
    }, 
    "simulation_parameters": {
        "time_final": 2e-3, 
        "init_temperature": 300, 
        "dt0": 1e-14, 
        "dt_factor": 0.1, 
        "cyl": 1, 
        "dt_max": 0.1,
        "linear_visc_fac": 0.2,
        "quad_visc_fac": 1,
        "dt_cour_fac": 3
    },
    "rezone_advect":{
        "rezone_type": "lagrange"
    }
    "parallel": {
	"np": 1,
	"npx": 1,
	"npy": 1,
	"npz": 1
    }
}
```
To execute sedov-taylor please copy to `Datafiles/datafile.json` the Sedov-Taylor 3D datafile, which is `Datafiles/datafile_sedov_taylor_3d.json`, And simply execute the code as explained above.\
In order to change the mesh size you need change the number_cells section in the datafile.\
Here is an example of the number_cells section in the datafile for 11^3 mesh cells:
```json
"number_layers_j": 2,
        "number_cells_j": [
            1,
            10
        ], 
        "number_layers_i": 2, 
        "number_cells_i": [
            1,
            10
        ],
        "number_layers_k":2,
        "number_cells_k": [
            1,
            10
        ],
```
In order to use parallelization, you need to add the following section to the datafile:
```json
"parallel": {
	"np": p,
	"npx": nx,
	"npy": ny,
	"npz": nz
    }
```
You need to set `p` in `"np"` to the total number of mpi processes you want, and set the number of mpi processes you want in each axis by changing `nx, ny, nz` to the desire mpi processes number. Here is an example for the parallel section for 8 mpi processes 2 in each of the axies:
```json
"parallel": {
	"np": 8,
	"npx":2,
	"npy":2,
	"npz":2
    }
```
#### Sedov-Taylor run example
For example this is the initial state of the problem (3D, 15^3 cells)
![Initial Problem](https://github.com/Scientific-Computing-Lab-NRCN/Backus/blob/main/Images/visit0005.png)


Lagrangian mesh:

![Lagrange](https://github.com/Scientific-Computing-Lab-NRCN/Backus/blob/main/Images/visit0007.png)


ALE:
![ALE](https://github.com/Scientific-Computing-Lab-NRCN/Backus/blob/main/Images/visit0006.png)
