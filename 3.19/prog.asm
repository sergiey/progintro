; This program calculates the number of characters from stdin
;   and put it in stdout

%include "../nasm_hello/stud_io.inc"
global _start
section .bss
count:  resw 1              ; for counted chars
rank:   resw 1              ; rank of num for print
divdr:  resw 1              ; divider

section .data
endf:   dd -1               ; set end of file condition for GETCHAR macros
base:   dw 10               ; decimal digit base

section .text
_start: xor ecx, ecx
lp:     GETCHAR             ; get char from stdin
        cmp eax, [endf]     ; is end of file?
        jz next             ; if so then jump to next section
        inc ecx             ; if not then increase ecx
        jmp lp              ; get next char
next:   mov [count], cx     ; move counted chars to count
        ; Rank of count calculation
        mov ax, cx          ; move counted chars to ax
lp2:    cmp ax, 0           ; is ax zero?
        jz next2            ; jump to next2 section
        div byte [base]     ; divide ax by 10
        inc byte [rank]     ; increase rank
        cbw
        jmp lp2             ; repeat loop
        ; Divider calculation
next2:  cmp word [rank], 0  ; is rank zero?
        jz quit             ; if so then quit
        dec word [rank]
        mov cx, [rank]      ; else set counter for get divider
        mov ax, 1           ; move 1 to ax
        cmp cx, 0           ; is cx zero?
        jz next3            ; if so then jump to next2
lp3:    mul word [base]     ; power 10 (base) "rank" times
        loop lp3
next3:  mov [divdr], ax     ; set divider
        ; Print count number
lp4:    mov ax, [count]     ; move counted number in ax for calculate
        cwd                 ;   high order digit
        div word [divdr]    ; divide counted number by divider
        add ax, 48          ; convert result to ASCII code
        PUTCHAR al          ; print it
        mov [count], dx     ; move reminder of the division to count
        ; Decrease the divider by 10 times
        mov ax, [divdr]
        cwd
        div word [base]     ; divide divider by base (= 10)
        mov [divdr], ax     ; set new divider
        cmp word [divdr], 0 ; is divider zero?
        jz quit             ; if so then quit
        jmp lp4             ; else repeat loop
quit:   PUTCHAR 10          ; end program section
        FINISH