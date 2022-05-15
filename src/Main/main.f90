program main
    use problem_module, only : problem_t
    use datafile_module, only : datafile_t
    use mpi
    use omp_lib
    implicit none

    type(problem_t) ,allocatable    :: prob
    type(datafile_t) :: df_obj
    character(len=*), parameter  :: default_path="../Datafiles/datafile.json"       
    character(len=100), dimension(:), allocatable :: args
    character(len=100), dimension(:), pointer :: path
    integer :: num_args, ix
    integer :: ierr, rank


    call MPI_init(ierr)
    call mpi_comm_rank(MPI_COMM_WORLD, rank, ierr)
    df_obj = datafile_t(default_path)

    prob = problem_t(df_obj)
    call prob%Start_calculation()
    call MPI_FINALIZE(ierr)

end program main
