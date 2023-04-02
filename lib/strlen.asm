bits 64

global strlen
;      strlen takes one parameter
;      The first parameter of a function called in NASM is: RDI

strlen:
    XOR RAX, RAX                    ; RAX = 0

    .loop:
        CMP BYTE [RDI + RAX], 0     ; s[RAX] == '\0'
        JE .exit_point              ; if they are equal: jump to exit point
        INC RAX                     ; else RAX++
        JMP .loop                   ; loop again (jump .loop)

    .exit_point:
        RET                         ; Returns RAX value
