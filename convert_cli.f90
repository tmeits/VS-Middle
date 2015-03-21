module VSConvert
! Конвертирование формата климатики А.Шашкина в упрощенный формат
    use, intrinsic :: iso_fortran_env
    implicit none
contains
    subroutine convertClimFile(oldClimFile, newClimFile)
        implicit none

        character(len=*), intent(in) :: oldClimFile, newClimFile
        integer :: i, ioW, io
        integer    :: cl(13) ! Вектор с климатическими данными

        open(96, status='old', file=oldClimFile, iostat=io)
        open(69, file=newClimFile, iostat=io)

        if ((io == 0)) then
            ! Read format:
            ! ------------------------------------------------------------------------
            ! Stationsname        Lati.Long.Alti.
            ! D  Mo Year  Min.  Max. Mean   Sunshine      Daily          Mean
            ! *          Temp. Temp. Cloud  Abs.  Rel. Prec. Trans Press Temp. Humid
            ! *                      Cover
            ! *          /10 C /10 C /10   /10 h   %   /10mm /10mm/10hPa /10 C   %
            ! 1969
            !   7062 14788 -9999
            ! coku
            ! ------------------------------------------------------------------------
            do i = 1, 8
                read(96,*)
            end do
            do
                read(96,*,IOSTAT=io)cl
                if (io < 0) then ! == iostat_end
                    exit
                end if
                if (io > 0) stop '*** ERROR: Problem reading'
                ! Wite format: D M Y DailyPrec. MeanTemp
                write (69, '(I3,I3,I5,I6,I6)', iostat=ioW) &
                    cl(1), cl(2), cl(3),cl(9),cl(12)
                if (ioW == 0) then
                    print '(I3,I3,I5,I6,I6)', cl(1), cl(2), cl(3),cl(9),cl(12)
                else
                    print *, '*** ERROR: Write file ', newClimFile
                    stop
                end if
            end do
            close(96)
            close(69)
        else
            print *, '*** ERROR: Open files ', oldClimFile, ' or ', newClimFile
            stop
        end if

        print *, 'End convert.' ! Have fun!
    end subroutine convertClimFile
end module VSConvert

program convert_cli
! V.Ilyin 21.3.2105
    use VSConvert
    implicit none

    character(len=255) :: arg1, arg2

    if (command_argument_count() /= 2) then
        stop 'Usage: convert_cli oldClimFile newClimFile'
    end if

    call get_command_argument(1, arg1)
    call get_command_argument(2, arg2)
    call convertClimFile(arg1, arg2)

    print *, 'Convert ', trim(arg1), ' file to ', trim(arg2)
    print *, 'END.'
end program convert_cli





























