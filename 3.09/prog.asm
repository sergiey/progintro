%include "../nasm_hello/stud_io.inc"
global _start
section .data
endf:   dd -1
section .text
_start: GETCHAR
        cmp eax, [endf]
        jz quit
        PUTCHAR al
        jmp _start
quit:   PUTCHAR 10
        FINISH
