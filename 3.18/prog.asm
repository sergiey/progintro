%include "../nasm_hello/stud_io.inc"
global _start
section .bss
num:    resw 1              ; result number
n:      resw 1              ; temporary number

section .data
endf:   dd  -1              ; set end of file condition for GETCHAR macros
endln:  db 10               ; ASCII code for new line
decnum: db 48, 49, 50, 51, 52, 53, 54, 55, 56, 57   ; ASCII decimal digits codes
mlp:    db 10               ; multiplier

section .text
_start: GETCHAR             ; get char from stdin
        cmp eax, [endln]    ; is end of line?
        jz prnt             ; if so then jump to print section
        cmp eax, [endf]     ; is end of file?
        jz prnt             ; if so then jump to print section
        mov ecx, 10         ; set counter for check is entered char digit
lp:     cmp al, [decnum + ecx - 1]  ; compare char & decimal digits array elem.
        jz getNum           ; if so then jump to get num section
        loop lp             ; repeat loop
        jmp prnt            ; if char is not a digit then jump to print section
getNum: mov [n], cx         ; get from counter entered number 
        sub word [n], 1
        mov eax, [num]      ; algorithm for get number: num = num * 10 + n
        mul byte [mlp]      ; multiply by 10 
        add ax, word [n]
        mov [num], ax
        jmp _start          ; return to start for get next char
prnt:   mov cx, [num]       ; set counter with result number
        jcxz quit           ; if counter is zero then jump to quit
lp2:    PRINT "*"           ; print "*" until counter is zero
        loop lp2
quit:   PUTCHAR 10          ; end program section
        FINISH
