bits 64

global strcspn
;      strcmp takes two parameters
;      The first parameter of a function called in NASM is: RDI
;      The second parameter of a function called in NASM is: RSI

strcspn:
    XOR RAX, RAX                                ; RAX = 0
    MOV RDX, RDI                                ; 's' str memo
    XOR R8, R8                                  ; 'reject' str memo
    XOR R9B, R9B                                ; Byte buffer

    .skip_if_traversed_whole_s_string:
        CMP BYTE [RDX], 0                       ; Traversed the whole 's' str?
        JE .exit_point                          ; Quit

    MOV R8, RSI                                 ; ini 'reject' memo str
    .check_each_reject_char:
        CMP BYTE [R8], 0                        ; Traversed whole 'reject' str?
        JE .next_s_char                         ; Inc score, resumes w/ inc 's'

        MOV R9B, [RDX]
        CMP [R8], R9B                           ; 's' char in 'reject' str?
        JE .exit_point                          ; Quit

        INC R8                                  ; R8 = next 'reject' char
        JMP .check_each_reject_char             ; Retry with next 'reject' char

    .next_s_char:
        INC RAX                                 ; +1 point!
        INC RDX                                 ; RDX = next 's' char
        JMP .skip_if_traversed_whole_s_string   ; Retry ALL with next 's' char

    .exit_point:
        RET
