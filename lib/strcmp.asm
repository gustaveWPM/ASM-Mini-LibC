bits 64

global strcmp
;      strcmp takes two parameters
;      The first parameter of a function called in NASM is: RDI
;      The second parameter of a function called in NASM is: RSI

strcmp:
    XOR RAX, RAX                    ; RAX = 0
    XOR R8B, R8B                    ; Scratch register (str one each char)
    XOR R9B, R9B                    ; Scratch register (str two each char)

    .loop:
        MOV R8B, [RDI + RAX]
        MOV R9B, [RSI + RAX]
        CMP R8B, 0
        JE .ended_str_one
        CMP R9B, 0
        JE .ended_str_two
        CMP R8B, R9B
        JNE .diff_char
        INC RAX
        JMP .loop

    .diff_char:
        JG .gt                      ; Greater
        JMP .lt                     ; Less

    .ended_str_one:
        CMP BYTE [RSI + RAX], 0
        JE .eq                      ; no diff_char, same strlen
        JMP .lt                     ; "a", "ab" -> -1

    .ended_str_two:
        CMP BYTE [RDI + RAX], 0
        JE .eq                      ; no diff_char, same strlen
        JMP .gt                     ; "ab", "a" -> 1

    .lt:
        MOV RAX, -1                 ; "a", "b" -> -1
        RET

    .eq:
        XOR RAX, RAX                ; "a", "a" -> O
        RET

    .gt:
        MOV RAX, 1                  ; "b", "a" -> 1
        RET
