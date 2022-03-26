; This program takes data from stdin and sends to stdout in reverse

%include "../nasm_hello/stud_io.inc"
global _start
section .data
endf:   dd -1           ; set end of file condition
section .text
_start: mov ebx, esp    ; save stack pointer start address
lp:     GETCHAR         ; get char from stdin
        cmp eax, [endf] ; is end of file?
        jz next         ; if so then jump to next section
        push eax        ; push char onto the stack
        jmp lp          ; return for get another char
next:   cmp ebx, esp    ; is start address reached?
        jz quit         ; if so then jump to quit section
        pop eax         ; take char from the stack
        PUTCHAR al      ; print char
        jmp next        ; reptat cycle
quit:   PUTCHAR 10      ; end program section
        FINISH