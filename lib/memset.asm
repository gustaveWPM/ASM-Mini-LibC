bits 64

global memset
;      memset takes three parameters
;      The first parameter of a function called in NASM is: RDI
;      The second parameter of a function called in NASM is: RSI
;      The third parameter of a function called in NASM is: RDX

memset:
    MOV R8, RDI     ; R8 = base ptr
    MOV RAX, RSI    ; RAX = int c
    MOV RCX, RDX    ; Sets RCX equal to RDX, then REP will iterate over it

    CLD             ; Sets DF to 0 (as default)
    REP STOSB       ; https://bit.ly/3JVDKld | https://bit.ly/3Ke9UJ5
                    ; Copies RCX times the LSB from RAX in RDI,
                    ; then increments RDI.

    MOV RAX, R8     ; Comes back to initial ptr, now with mutated values
    RET
