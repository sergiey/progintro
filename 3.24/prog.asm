%include "../nasm_hello/stud_io.inc"
global _start
section .bss
str1:   resb 4              ; test string address
section .data
dig:    dd "1", "5"         ; test digit

section .text
; Get integer from standard input procedure
; Parameters: eax = address, edx = length.
; Return: eax = integer, edx = work result (0 - OK, 1 - not OK).
get_stdin_int:
        push esi            ; save esi
        push edi            ; save edi
        push ebx            ; save ebx
        xor ebx, ebx        
        cmp edx, 0          ; if length is zero then quit
        je .nok_q        
        mov edi, edx        ; copy length to edi
        mov esi, eax        ; copy address to esi

section .data
; ASCII decimal digits codes
.decnum: db 48, 49, 50, 51, 52, 53, 54, 55, 56, 57

section .text
; Check is the character a digit     
.chkDig:
        mov ecx, 10         ; set counter for check is entered char a digit
        mov eax, [esi]      ; move char to eax
.lp:    cmp al, [.decnum + ecx - 1]  ; compare char & decimal digits array elem
        jz .toInt           ; if so then transfer to integer
        loop .lp            ; repeat loop
        jmp .nok_q          ; if char is not a digit then not ok quit
; Transform character to integer
.toInt: 
        sub cx, 1           ; adjust entered number
        mov eax, ebx        ; algorithm for get number: num = num * 10 + n
        push ebx            ; save ebx
        mov ebx, 10         ; move 10 to ebx for multiplication
        mul ebx             ; multiply by 10
        pop ebx             ; restore ebx
        add ax, cx          
        mov bx, ax
        dec edi             ; is end of array?
        cmp edi, 0
        jz .ok_q            ; if so then jump to OK quit
        add esi, 4          ; set esi next char
        jmp .chkDig         ; return to start for get next char
.nok_q: mov edx, 1          ; error while read number
        jmp .quit
.ok_q:  mov edx, 0          ; number read succecc
        jmp .quit
.quit:  mov eax, ebx        ; procedure quit
        pop ebx             ; restore ebx
        pop edi             ; restore edi
        pop esi             ; restire esi
        ret


; Get string from integer. Parameters: eax = digit, ecx = address.
get_str_from_int:

section .bss
.divdr:  resw 1             ; divider

section .text
        push edi            ; save edi
        push ebx            ; save ebx
        push esi            ; save esi
        mov edi, ecx        ; set string address to edi
        mov ebx, eax        ; copy integer to ebx       ebx = count
        xor esi, esi        ; zeroing esi               esi = rank
; Rank of count calculation
.lp:    cmp ax, 0           ; is ax zero?
        jz .next            ; jump to next section
        push ebx            ; save ebx
        mov bl, 10          ; move decimal digit base 10 to bl
        div bl              ; divide ax by 10
        pop ebx             ; restore ebx
        inc esi             ; increase rank
        cbw
        jmp .lp             ; repeat loop
; Divider calculation
.next:  cmp esi, 0          ; is rank zero?
        jz .quit            ; if so then quit
        dec esi
        mov ecx, esi        ; else set counter for get divider
        mov ax, 1           ; move 1 to ax
        cmp cx, 0           ; is cx zero?
        jz .next2           ; if so then jump to next2
.lp2:   push ebx            ; save ebx
        mov ebx, 10         ; move decimal digit base 10 to ebx
        mul ebx             ; power 10 (base) "rank" times
        pop ebx             ; restore ebx
        loop .lp2
.next2: mov [.divdr], al    ; set divider
        ; Print count number
.lp3:   mov eax, ebx        ; move counted number in ax for calculate
        cwd                 ;   high order digit
        div word [.divdr]   ; divide counted number by divider
        add al, 48          ; convert result to ASCII code
        mov [edi], al       ; move ASCII char to destination address
        add edi, 1          ; set next address
        mov bx, dx          ; move reminder of the division to count
        ; Decrease the divider by 10 times
        mov al, [.divdr]
        cwd
        push ebx            ; save ebx
        mov ebx, 10         ; move decimal digit base 10 to ebx
        div ebx             ; divide divider by base (= 10)
        pop ebx             ; restore ebx
        mov [.divdr], al    ; set new divider
        cmp byte [.divdr], 0; is divider zero?
        jz .quit            ; if so then quit
        jmp .lp3            ; else repeat loop
.quit:  mov byte [edi + 1], 0   ; add zero byte in the end of the string
        pop esi             ; restore esi
        pop ebx             ; restore ebx
        pop edi             ; restore edi
        ret

; Main program
_start:
; Call get_stdin_int
        ; mov eax, dig        ; set first parameter
        ; mov edx, 2          ; set second parameter
        ; call get_stdin_int  ; call procedure
; Print get_stdin_int result
; lp:     cmp eax, 0          ; print asterisk entered digit times
;         jz next
;         PRINT "*"
;         dec eax
;         jmp lp
; next:   PUTCHAR 10          ; print result of procedure work
;         cmp edx, 0
;         jz ok
;         cmp edx, 1
;         jz nok
;         PRINT "Not ok, not not ok"
;         jmp quit
; ok:     PRINT "Ok"
;         jmp quit
; nok:    PRINT "Not Ok"
;         jmp quit

; Call get_str_from_int
        mov eax, 126
        mov ecx, str1
        call get_str_from_int
        xor ecx, ecx
prnt:   cmp byte [str1 + ecx], 0
        jz quit
        PUTCHAR byte [str1 + ecx]
        inc ecx
        jmp prnt
quit:   PUTCHAR 10          ; end program
        FINISH