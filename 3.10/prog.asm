%include "../nasm_hello/stud_io.inc"
global _start
section .data
endln:  db 10               ; set end of line code
endf:   dd -1               ; set end of file code
plus:   db "+"              ; set plus char byte
hyph:   db "-"              ; set hyphen char byte
pCount: db 0                ; set plus char counter to zero
hCount: db 0                ; set hyphen char counter to zero

section .text
_start: GETCHAR             ; get char from stdin macros
        cmp al, [endln]     ; is end of line?
        jz next             ; if so then quit
        cmp eax, [endf]     ; is end of file?
        jz next             ; if so then quit
        cmp al, [plus]      ; is char plus?
        jnz isHyph          ; if so then jump to next condition
        inc byte [pCount]   ; increase plus counter
isHyph: cmp al, [hyph]      ; is char hyphen?
        jnz again           ; if not then repeat cycle
        inc byte [hCount]   ; increase hyphen counter
again:  jmp _start          ; jump to start cycle
next:   mov al, [pCount]    ; multiplication pCount
        mul byte [hCount]   ; and hCount
        jz quit             ; chek is mul result zero
        mov ecx, eax        ; set counter
lp:     PUTCHAR "*"         ; print "*" in stdout loop
        loop lp
quit:   PUTCHAR 10          ; prepare for finish program
        FINISH