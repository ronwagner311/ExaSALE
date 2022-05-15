
module slip_cell_3d_module
    use cell_boundary_condition_module, only : cell_boundary_condition_t
    use data_module    , only : data_t
    use quantity_module, only : quantity_t

    implicit none
    private

    type, extends(cell_boundary_condition_t), public :: slip_cell_3d_t
        private
    contains

        procedure, public :: Calculate => Slip_cell_3d_calculate
    end type slip_cell_3d_t

contains
    subroutine Slip_cell_3d_calculate (this, c_quantity, edge_num)
        class (slip_cell_3d_t) , intent (in out)     :: this      
        class(quantity_t)   , intent (in out)     :: c_quantity  
        integer             , intent (in)         :: edge_num  

        real(8), dimension(:,:,:), pointer :: values
        integer :: i, j, k, nxp, nyp, nzp

        call c_quantity%Point_to_data(values)
        nxp = c_quantity%d1 + 1
        nyp = c_quantity%d2 + 1
        nzp = c_quantity%d3 + 1

        select case(edge_num)
            case(1) 
                i = 1
                do k = 0, nzp
                    do j = 0, nyp
                        values(i-1, j, k) = values(i, j, k)
                    end do
                end do


            case(2) 
                i = nxp
                do k = 0, nzp
                    do j = 0, nyp
                        values(i, j, k) = values(i-1, j, k)
                    end do
                end do

            case(3) 
                j = 1
                do k = 0, nzp
                    do i = 0, nxp
                        values(i, j-1, k) = values(i, j, k)
                    end do
                end do

            case(4) 
                j = nyp
                do k = 0, nzp
                    do i = 0, nxp
                        values(i, j, k) = values(i, j-1, k)
                    end do
                end do

            case(5) 
                k = 1
                do j = 0, nyp
                    do i = 0, nxp
                        values(i, j, k-1) = values(i, j, k)
                    end do
                end do

            case(6) 
                k = nzp
                do j = 0, nyp
                    do i = 0, nxp
                        values(i, j, k) = values(i, j, k-1)
                    end do
                end do
        end select
        return
    end subroutine

end module slip_cell_3d_module
