
module slip_cell_module
    use cell_boundary_condition_module, only : cell_boundary_condition_t
    use data_module    , only : data_t
    use quantity_module, only : quantity_t
    implicit none
    private

    type, extends(cell_boundary_condition_t), public :: slip_cell_t
        private
    contains

        procedure, public :: Calculate => Slip_cell_calculate
    end type Slip_cell_t

contains
    subroutine Slip_cell_calculate (this, c_quantity, edge_num)
        class (slip_cell_t) , intent (in out)     :: this      
        class(quantity_t)   , intent (in out)     :: c_quantity  
        integer             , intent (in)         :: edge_num  

        real(8), dimension(:,:,:), pointer :: values
        integer :: i, j, nxp, nyp

        call c_quantity%Point_to_data(values)

        nxp = c_quantity%d1 + 1
        nyp = c_quantity%d2 + 1

        select case(edge_num)
            case(1) 
                i = 1
                do j = 0, nyp
                    values(i - 1, j, 1) = values(i, j, 1)
                end do

            case(2) 
                i = nxp
                do j = 0, nyp
                    values(i, j, 1) = values(i - 1, j, 1)
                end do

            case(3) 
                j = 1
                do i = 0, nxp
                    values(i, j - 1, 1) = values(i, j, 1)
                end do

            case(4) 
                j = nyp
                do i = 0, nxp
                    values(i, j, 1) = values(i, j - 1, 1)
                end do
        end select

    end subroutine

end module slip_cell_module
