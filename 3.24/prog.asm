%include "../nasm_hello/stud_io.inc"
global _start

section .bss
str1:   resb 4              ; test string address

section .data
dig:    db "2", "9", "6"    ; test digit

section .text
; Get integer from string
; Parameters: eax = address, edx = length.
; Return: eax = integer, edx = work result (0 - OK, 1 - not OK).
get_int_from_str:
        push esi            ; save esi
        push edi            ; save edi
        push ebx            ; save ebx
        xor ebx, ebx        
        cmp edx, 0          ; if length is zero then quit
        je .nok_q        
        mov edi, edx        ; copy length to edi
        mov esi, eax        ; copy address to esi
        ; Put next char to cl
.next:  mov cl,  byte [esi]
        sub cl, 48
        ; Transform character to integer
.toInt: 
        mov eax, ebx        ; algorithm for get number: num = num * 10 + n
        push ebx            ; save ebx
        mov ebx, 10         ; move 10 to ebx for multiplication
        mul ebx             ; multiply by 10
        pop ebx             ; restore ebx
        add ax, cx          
        mov bx, ax
        dec edi             ; is end of string?
        cmp edi, 0
        jz .ok_q            ; if so then jump to OK quit
        add esi, 1          ; set esi next char
        jmp .next           ; return to start for get next char
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


; Print string from address (eax = address)
print_str:   
        xor ecx, ecx        ; clear ecx
.lp:    cmp byte [eax + ecx], 0 ; zere byte = end of string
        jz .quit
        PUTCHAR byte [eax + ecx]; print character
        inc ecx             ; increase ecx for next byte
        jmp .lp
.quit:  ret


; Get string of digits from stdin 
; Parameter: eax = destination address.
; Return: ecx = number of successfully written bytes, eax = work result
; (0 = end of file or end of line, -1 = not enough space for write,
; other data = code of not digit character)
get_str_from_stdin:

section .data
; ASCII decimal digits codes
.decnum: db 48, 49, 50, 51, 52, 53, 54, 55, 56, 57

section .text
        push edi            ; save edi
        push ebx            ; save ebx
        mov edi, eax        ; copy to edi destination address
        xor ebx, ebx        ; clear ebx
.getch: GETCHAR             ; get char from stdin
        cmp al, -1          ; is end of file?
        jz .eof_q           ; if so then quit
        cmp al, 10          ; is end of line?
        jz .eof_q           ; if so then quit
; Check is the character a digit     
        mov ecx, 10         ; set counter for check is entered char a digit
.lp:    cmp al, [.decnum + ecx - 1]; compare char & decimal dig. array elem
        je .wrt             ; if char is a digit then write it
        loop .lp            ; repeat loop
        jmp .ndig_q         ; if char is not a digit then quit
.wrt:   mov [edi], al       ; write digit to dedicated memory
        add edi, 1          ;
        ; how to check is memory end?
        ; jz .nesp_q
        inc ebx             ; ebx is a counter of successfully written bytes
        jmp .getch          ; get another char
.eof_q: mov eax, 0          ; reached end of file or end of line
        jmp .quit
.ndig_q:cbw                 ; got not a digit character
        cwd
        jmp .quit
.nesp_q:mov eax, -1         ; not enough space for write input data
        jmp .quit
.quit:  mov ecx, ebx        ; move successfully written bytes to ecx
        pop ebx
        pop edi
        ret


; Main program
_start:
; Call get_str_from_stdin
        mov eax, str1
        call get_str_from_stdin
        ; eax = result, ecx = count succ. wr. bytes
; show ecx
        PRINT "Successfully written bytes to ecx: "
lp:     cmp ecx, 0
        jz next
        PRINT "*"
        loop lp
        PUTCHAR 10
; show eax
        PRINT "Work result from eax: "
        cmp eax, 0          ; is end of file
        jz q_eof            
        cmp eax, -1         ; is enough space
        jz q_nesp
        PRINT "'"
        PUTCHAR al
        PRINT "' is not a digit"
        jmp next
q_eof:  PRINT "reached end of file or end of line"
        jmp next 
q_nesp: PRINT "not enough space"
        jmp next 
; Print string
next:   PUTCHAR 10
        PRINT "Input result: "   
        mov eax, str1
        call print_str       

; Call get_stdin_int
;         mov eax, dig        ; set first parameter
;         mov edx, 3          ; set second parameter
;         call get_stdin_int  ; call procedure
; ; Print get_stdin_int result
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
        ; mov eax, 124
        ; mov ecx, str1
        ; call get_str_from_int
        ; mov eax, str1
        ; call print_str
quit:   PUTCHAR 10          ; end program
        FINISH