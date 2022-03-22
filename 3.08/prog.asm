%include "../nasm_hello/stud_io.inc"
global _start
section .data
nums    db 49, 50, 51, 52, 53, 54, 55, 56, 57   ; ascii code digits array
section .text
_start: GETCHAR         ; get char from stdin
        mov ecx, 9      ; put in counter array lenght 
        mov esi, nums
lp:     cmp al, [esi + ecx - 1] ; compare array element and stdin char
        jz prepr        ; if ZF then jump to print prepare
        loop lp
        jmp quit        ; if zero matches then jump to quit
prepr:  sub eax, 48     ; ascii code to digit
        mov ecx, eax    ; number of cycles
prnt:   PRINT "*"       ; print '*' cycle
        loop prnt
        PUTCHAR 10      ; new line
quit:   FINISH          ; finish macros
