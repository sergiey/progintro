; Get string of digits from stdin (destination address).
; Return: ecx = number of successfully written bytes, eax = work result
; (0 = end of file or end of line, -1 = not enough space for write,
; other data = code of not digit character)
%include "../nasm_hello/stud_io.inc"
global get_str_from_stdin

get_str_from_stdin:
section .data
; ASCII decimal digits codes
.decnum: db 48, 49, 50, 51, 52, 53, 54, 55, 56, 57
section .text
        push ebp            ; save ebp
        mov ebp, esp        ; set base pointer
        push edi            ; save edi
        push ebx            ; save ebx
        mov edi, [ebp + 8]  ; copy to edi destination address
        xor ebx, ebx        ; clear ebx
.getch: GETCHAR             ; get char from stdin
        cmp al, -1          ; is end of file?
        jz .eof_q           ; if so then quit
        cmp al, 10          ; is end of line?
        jz .eof_q           ; if so then quit
        ; Check is the character a digit     
        mov ecx, 10         ; set counter for check is entered char a digit
.lp:    cmp al, [.decnum + ecx - 1]; compare char & decimal dig. array elem
        je .wrt             ; if char is a digit then write it
        loop .lp            ; repeat loop
        jmp .ndig_q         ; if char is not a digit then quit
.wrt:   mov [edi], al       ; write digit to dedicated memory
        add edi, 1          ;
        ; how to check is memory end?
        ; jz .nesp_q
        inc ebx             ; ebx is a counter of successfully written bytes
        jmp .getch          ; get another char
.eof_q: mov eax, 0          ; reached end of file or end of line
        jmp .quit
.ndig_q:cbw                 ; got not a digit character
        cwd
        jmp .quit
.nesp_q:mov eax, -1         ; not enough space for write input data
        jmp .quit
.quit:  mov ecx, ebx        ; move successfully written bytes to ecx
        pop ebx             ; restore used registers
        pop edi
        mov esp, ebp        ; set stack pointer
        pop ebp
        ret