bits 64

global memcpy
;      memcpy takes three parameters
;      The first parameter of a function called in NASM is: RDI
;      The second parameter of a function called in NASM is: RSI
;      The third parameter of a function called in NASM is: RDX

memcpy:
    MOV RAX, RDI    ; RAX = base ptr
    MOV RCX, RDX    ; Sets RCX equal to RDX, then REP will iterate over it

    CLD             ; Sets DF to 0 (as default)
    REP MOVSB       ; https://bit.ly/3M3ltUP | https://bit.ly/3vh20KA
                    ; Copies a BYTE from RSI to RDI,
                    ; then increments RSI and RDI
                    ; then decrements RCX (REP stops when RCX == 0)
    RET
