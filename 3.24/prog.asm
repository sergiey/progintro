%include "../nasm_hello/stud_io.inc"
global _start

section .data
dig:    dd "1", "5"             ; test digit

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

; Main program
_start: mov eax, dig        ; set first parameter
        mov edx, 2          ; set second parameter
        call get_stdin_int  ; call procedure
; Print get_stdin_int result
lp:     cmp eax, 0          ; print asterisk entered digit times
        jz next
        PRINT "*"
        dec eax
        jmp lp
next:   PUTCHAR 10          ; print result of procedure work
        cmp edx, 0
        jz ok
        cmp edx, 1
        jz nok
        PRINT "Not ok, not not ok"
        jmp quit
ok:     PRINT "Ok"
        jmp quit
nok:    PRINT "Not Ok"
        jmp quit
quit:   PUTCHAR 10          ; end program
        FINISH