%include "../nasm_hello/stud_io.inc"
%include "./macro.inc"
global _start

section .data
nums   fill_4bint 1, 2, 10

section .text
_start:
        mov esi, nums
        mov edi, 10          ; set edi same as third parameter
lp1:    mov ecx, [esi]
lp2:    cmp ecx, 0
        jz next
        PRINT "*"
        loop lp2
next:   cmp edi, 0
        jz quit
        PUTCHAR 10
        dec edi
        add esi, 4
        jmp lp1
quit:   FINISH


