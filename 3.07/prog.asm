%include "../nasm_hello/stud_io.inc"
global _start
section .text
_start: GETCHAR
        cmp al, 65
        jnz pr_no
        PRINT "YES"
        PUTCHAR 10
        jmp quit
pr_no:  PRINT "NO"
        PUTCHAR 10
quit:   FINISH