module VSType ! Derived Data Types

    type Uchastky
    
        character (len=255) :: File, North, East
        character (len=255) :: Alt
        integer :: Start, End
        character (len=255) :: idStation,Country
    
    end type Uchastky

    type Proba

        character (len=255) :: File, siteName, Alt, North, East
        integer :: Start, End
        character (len=255) :: Species
        
    end type Proba

contains

end module VSType
! -
! - http://research.physics.illinois.edu/ElectronicStructure/498-s97/comp_info/derived.html
! -
