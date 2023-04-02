bits 64

global strrchr
;      strrchr takes two parameters
;      The first parameter of a function called in NASM is: RDI
;      The second parameter of a function called in NASM is: RSI

strrchr:
    XOR RAX, RAX                    ; RAX = 0
    XOR RCX, RCX                    ; (Scraping register: strlen)

    ;   First of all: we move to the end of the string
    .move_to_str_termination:
        CMP BYTE [RDI + RCX], 0     ; RDI == '\0'
        JE .loop
        INC RCX
        JMP .move_to_str_termination

    ;   Very similar to the strchr's loop (but 'decrementing' on an offset)
    .loop:
        CMP [RDI + RCX], SIL       ; s[RCX] == c
        JE .found
        CMP RCX, 0                 ; RCX == 0 and s[RCX] != c
        JE .exit_point             ; RCX is equal to 0 (NULL)
        DEC RCX
        JMP .loop

    .found:
        ADD RDI, RCX               ; Ptr Offset
        MOV RAX, RDI

    .exit_point:
        RET
