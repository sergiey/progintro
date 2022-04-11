; Print string from address (address)
%include "../nasm_hello/stud_io.inc"
global print_str

section .text
print_str:
        push ebp
        mov ebp, esp
        mov eax, [ebp + 8]
        xor ecx, ecx        ; clear ecx
.lp:    cmp byte [eax + ecx], 0 ; zero byte = end of string
        jz .quit
        PUTCHAR byte [eax + ecx]; print character
        inc ecx             ; increase ecx for next byte
        jmp .lp
.quit:  mov esp, ebp
        pop ebp
        ret