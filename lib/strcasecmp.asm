bits 64

global strcasecmp
;      strcasecmp takes two parameters
;      The first parameter of a function called in NASM is: RDI
;      The second parameter of a function called in NASM is: RSI

strcasecmp:
    XOR RAX, RAX                    ; RAX = 0
    XOR R8B, R8B                    ; Scratch register (str one each char) 
    XOR R9B, R9B                    ; Scratch register (str two each char)

    ; function loop (as in strcmp.asm)
    .loop:
        MOV R8B, [RDI + RAX]
        MOV R9B, [RSI + RAX]
        CMP R8B, 0
        JE .ended_str_one
        CMP R9B, 0
        JE .ended_str_two

    ; if char a >= 'a' -> double check char a ( >= 'a' && <= 'z' )
    .sanitize_char_a:
        CMP R8B, 97
        JGE .check_char_a_and_upper_it_if_it_is_downcase

    ; if char b >= 'a' -> double check char b ( >= 'a' && <= 'z' )
    .sanitize_char_b:
        CMP R9B, 97
        JGE .check_char_b_and_upper_it_if_it_is_downcase
        JMP .check_diff

    ; if char a >= 'a' && char a <= 'z': upper it
    ; otherwise: continue -> check char b
    .check_char_a_and_upper_it_if_it_is_downcase:
        CMP R8B, 122
        JLE .char_a_toupper
        JMP .sanitize_char_b

    ; upper char a, then -> check char b
    .char_a_toupper:
        SUB R8B, 32
        JMP .sanitize_char_b

    ; if char b >= 'a' && char b <= 'z': upper it
    ; otherwise: continue -> check char a and char b diff
    .check_char_b_and_upper_it_if_it_is_downcase:
        CMP R9B, 122
        JLE .char_b_toupper
        JMP .check_diff

    ; upper char b, then -> check char a and char b diff
    .char_b_toupper:
        SUB R9B, 32

    ; as in strcmp.asm (from here till EOF)
    .check_diff:
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
