bits 64

global strstr
;      strstr takes two parameters
;      The first parameter of a function called in NASM is: RDI
;      The second parameter of a function called in NASM is: RSI

strstr:
    XOR RAX, RAX                    ; (Return ptr)
    XOR RCX, RCX                    ; (Scratch register, needle len)
    XOR RDX, RDX                    ; (Scratch register, current iterator)
    XOR R8B, R8B                    ; (Scratch register, current char)
    XOR R9, R9                      ; (Scratch register, match counter)

    .get_needle_len:
        CMP BYTE [RSI + RCX], 0
        JE .search_substr           ; Got needle len, store in RCX
        INC RCX
        JMP .get_needle_len

    .search_substr:
        CMP R9, RCX
        JE .rdx_remove_needle_len
        CMP BYTE [RDI + RDX], 0
        JE .not_found
        MOV R8B, [RSI + R9]
        CMP BYTE [RDI + RDX], R8B
        JE .found_match
        XOR R9, R9

    .continue:
        INC RDX
        JMP .search_substr

    .found_match:
        INC R9
        JMP .continue

    .rdx_remove_needle_len:
        CMP RCX, 0
        JE .set_rdi_offset
        DEC RCX
        DEC RDX
        JMP .rdx_remove_needle_len

    .set_rdi_offset:
        CMP RDX, 0
        JE .found
        INC RDI
        DEC RDX
        JMP .set_rdi_offset

    .not_found:
        RET

    .found:
        MOV RAX, RDI
        RET
