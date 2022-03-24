%include "../nasm_hello/stud_io.inc"
global _start
section .data
endln:  db  10          ; set new line ASCII char
endf:   dd  -1          ; set end of file condition for GETCHAR macros

section .bss
lnLen:  resb 1          ; byte for line length

section .text
_start: GETCHAR         ; get char from stdin
        cmp al, [endln] ; is char end of line?
        jz prtAst       ; if so then jump to print asterisk section
        cmp eax, [endf] ; is char end of file?
        jz quit         ; if so then jump to quit section
        inc byte [lnLen]; increasl line length by one
        jmp _start      ; repeat get char loop
prtAst: cmp byte [lnLen], 0     ; is lnLen zero?
        jz endLn        ; if so then go to end line section 
        PRINT "*"       ; print asterisk
        dec byte [lnLen]; use lnLen as a counter. Decrease line length by one
        jmp prtAst      ; if so then go to print asterisk section
endLn:  PUTCHAR 10      ; put new line char
        jmp _start      ; repeat get char loop
quit:   PUTCHAR 10      ; put new line char
        FINISH          ; end program macros