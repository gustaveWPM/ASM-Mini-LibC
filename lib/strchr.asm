bits 64
global strchr
;      strchr takes two parameters
;      The first parameter of a function called in NASM is: RDI
;      The second parameter of a function called in NASM is: RSI

strchr:
    XOR RAX, RAX                      ; RAX = 0

    .loop:
        CMP [RDI], SIL                ; current_char == c: found | https://bit.ly/3JVTepx
        JE .found
        CMP BYTE [RDI], 0             ; current_char == '\0': not found
        JE .exit_point
        INC RDI                       ; increment ptr
        JMP .loop

    .found:
        MOV RAX, RDI                  ; RAX = current_char_ptr

    .exit_point:
        RET
