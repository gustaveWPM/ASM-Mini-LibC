bits 64
global strpbrk
;      strpbrk takes two parameters
;      The first parameter of a function called in NASM is: RDI
;      The second parameter of a function called in NASM is: RSI

strpbrk:
    XOR RAX, RAX                    ; RAX = 0
    MOV RDX, RDI                    ; Memo RDI
    MOV R8, RSI                     ; Memo RSI
    XOR R9B, R9B                    ; Current RSI Char
    JMP .traverse_rdi

    .traverse_rdi:
        CMP BYTE [RDI], 0
        JE .exit_point
        MOV RSI, R8                 ; Resets RSI

    ; Sort of iterative calls to strchr
    .exit_success_if_rsi_includes_current_rdi_byte:
        CMP BYTE [RSI], 0
        JE .try_next_rdi_byte
        MOV R9B, [RDI]
        CMP R9B, [RSI]
        JE .found_rdi_matching_byte
        INC RSI
        JMP .exit_success_if_rsi_includes_current_rdi_byte

    .try_next_rdi_byte:
        INC RDI
        JMP .traverse_rdi

    .found_rdi_matching_byte:
	    MOV RAX, RDI

    .exit_point:
        MOV RDI, RDX                ; Resets RDI
        MOV RSI, R8                 ; Resets RSI
        RET
