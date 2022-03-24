%include "../nasm_hello/stud_io.inc"
global _start
section .data
endln:  db  10          ; set new line ASCII char
endf:   dd  -1          ; set end of file condition for GETCHAR macros
section .text
_start: GETCHAR         ; get char from stdin
        cmp al, [endln] ; is char end of line?
        jz prntOK       ; if so then jump to print OK section
        cmp eax, [endf] ; is char end of file?
        jz quit         ; if so then jump to quit section
        jmp _start      ; repeat get char loop
prntOK: PRINT "OK"      ; print OK macros
        PUTCHAR 10      ; put new line char
        jmp _start      ; repeat get char loop
quit:   PUTCHAR 10      ; put new line char
        FINISH          ; end program macros