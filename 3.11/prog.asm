%include "../nasm_hello/stud_io.inc"
global _start
section .data
endln:  db 10               ; set end of line code
endf:   dd -1               ; set end of file code
nums:   db  49, 50, 51, 52, 53, 54, 55, 56, 57  ; ACSII codes for 1..9 digits

section .bss
digCtr: resb 9              ; array for count digits
sum:    resb 1              ; all digits sum

section .text
_start: GETCHAR             ; get char from stdin
        cmp al, [endln]     ; is end of line?
        jz digSum           ; if so then jump to digSum label
        cmp al, [endf]      ; is end of file?
        jz digSum           ; if so then jump to digSum label
        mov ecx, 0          ; set counter
lp:     cmp al, [nums + ecx]; is stdin char are digit?
        jz addDig           ; if so then jump to addDig label
        inc ecx
        cmp ecx, 9
        jz _start           ; if char is not digit then get another char
        jmp lp
addDig: sub al, 48          ; turn ASCII code to digit         
        inc byte [digCtr + eax - 1] ; increase array element
        jmp _start          ; repeat reading char from stdin
digSum: mov cx, 9           ; set counter
lp2:    mov al, [digCtr + ecx - 1]  ; get all digits sum
        mul cx              ; mul digit amount and digit count
        add [sum], ax       ; add result to sum
        loop lp2            ; repeat loop
        mov cx, [sum]       ; set counter with result sum of digits
        jecxz quit          ; if sum = 0 then jump to quit label
print:  PRINT "*"           ; print "*" until sum <> 0
        loop print
quit:   PUTCHAR 10          ; finish section
        FINISH