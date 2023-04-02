bits 64

extern memcpy

global memmove
;      memmove takes three parameters
;      The first parameter of a function called in NASM is: RDI
;      The second parameter of a function called in NASM is: RSI
;      The third parameter of a function called in NASM is: RDX

memmove:
    MOV RAX, RDI    ; RAX = base ptr

    CMP RDI, RSI
    JL memcpy wrt ..plt

    STD             ; Sets DF to 1 -> MOVSB will copy by 'decrementing'
    MOV RCX, RDX    ; Sets RCX equal to RDX, then REP will iterate over it
    DEC RDX         ; Decrements RDX in order to respect zero-based numbering

    ; Adjust pointers for a 'decrementing' copy
    ADD RSI, RDX
    ADD RDI, RDX

    REP MOVSB       ; Copies a BYTE from RSI to RDI,
                    ; then DECREMENTS (since here DF == 1) RSI and RDI
                    ; then decrements RCX (REP stops when RCX == 0)

    CLD             ; Sets DF to 0 (as default)
    RET
