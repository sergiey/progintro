%include "../nasm_hello/stud_io.inc"
global _start

section .bss
str1    resb 11             ; first string of digits
len1    resb 11             ; first string length
str2    resb 11             ; second string of digits
len2    resb 11             ; second string length
sumint  resd 1              ; sum integer result
sumstr  resd 1              ; sum string result
mulint  resd 1              ; mul integer result
mulstr  resd 1              ; mul string result
subint  resd 1              ; sub integer result
substr  resd 1              ; sub string result

section .text
; Get integer from string (address, length).
; Return: eax = integer, edx = work result (0 - OK, 1 - not OK).
get_int_from_str:
        push ebp            ; save ebp
        mov ebp, esp        ; set base pointer
        push esi            ; save esi
        push edi            ; save edi
        push ebx            ; save ebx
        xor ebx, ebx        
        cmp dword [ebp + 12], 0     ; if length is zero then quit
        je .nok_q        
        mov edi, dword [ebp + 12]   ; copy length to edi
        mov esi, dword [ebp + 8]        ; copy address to esi
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
        mov esp, ebp        ; set stack pointer
        pop ebp             ; restore ebp
        ret


; Get string from integer (digit, address).
get_str_from_int:

section .text
        push ebp            ; save ebp
        mov ebp, esp        ; set base pointer
        sub esp, 4          ; allocate memory for a divider
        push edi            ; save edi
        push ebx            ; save ebx
        push esi            ; save esi
        mov edi, dword [ebp + 12]   ; set string address to edi
        mov eax, dword [ebp + 8]    ; set intereg to eax
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
.next2: mov [ebp - 4], al    ; set divider
        ; Print count number
.lp3:   mov eax, ebx        ; move counted number in ax for calculate
        cwd                 ;   high order digit
        div word [ebp - 4]   ; divide counted number by divider
        add al, 48          ; convert result to ASCII code
        mov [edi], al       ; move ASCII char to destination address
        add edi, 1          ; set next address
        mov bx, dx          ; move reminder of the division to count
        ; Decrease the divider by 10 times
        mov al, [ebp - 4]
        cwd
        push ebx            ; save ebx
        mov ebx, 10         ; move decimal digit base 10 to ebx
        div ebx             ; divide divider by base (= 10)
        pop ebx             ; restore ebx
        mov [ebp - 4], al    ; set new divider
        cmp byte [ebp - 4], 0; is divider zero?
        jz .quit            ; if so then quit
        jmp .lp3            ; else repeat loop
.quit:  mov byte [edi + 1], 0   ; add zero byte in the end of the string
        pop esi             ; restore esi
        pop ebx             ; restore ebx
        pop edi             ; restore edi
        mov esp, ebp        ; set stack pointer
        pop ebp             ; restore ebp
        ret


; Print string from address (address)
print_str:
        push ebp
        mov ebp, esp
        mov eax, [ebp + 8]
        xor ecx, ecx        ; clear ecx
.lp:    cmp byte [eax + ecx], 0 ; zero byte = end of string
        jz .quit
        PUTCHAR byte [eax + ecx]; print character
        inc ecx             ; increase ecx for next byte
        jmp .lp
.quit:  mov esp, ebp
        pop ebp
        ret


; Get string of digits from stdin (destination address).
; Return: ecx = number of successfully written bytes, eax = work result
; (0 = end of file or end of line, -1 = not enough space for write,
; other data = code of not digit character)
get_str_from_stdin:
section .data
; ASCII decimal digits codes
.decnum: db 48, 49, 50, 51, 52, 53, 54, 55, 56, 57

section .text
        push ebp            ; save ebp
        mov ebp, esp        ; set base pointer
        push edi            ; save edi
        push ebx            ; save ebx
        mov edi, [ebp + 8]  ; copy to edi destination address
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
        pop ebx             ; restore used registers
        pop edi
        mov esp, ebp        ; set stack pointer
        pop ebp
        ret


        ; Main program
_start:
        ; Save first string number
        push str1           ; set parameter for get_str_from_stdin
        call get_str_from_stdin
        add esp, 4
        cmp ecx, 0          ; is zero successfully bytes written?
        jz q_zb1            ; if so then quit
        mov [len1], ecx     ; set first string length
        cmp eax, 0          ; is end of file or end of line?
        jz q_eof            ; if so then quit
        cmp eax, 32         ; is space entered
        jz next             ; then read next string
        jmp q_ndig1         ; else not a digit entered
        ; Save second string number
next:   push str2           ; set parameter for get_str_from_stdin
        call get_str_from_stdin
        add esp, 4
        cmp ecx, 0          ; is zero successfully bytes written?
        jz q_zb2            ; if so then quit
        mov [len2], ecx     ; set first string length
        cmp eax, 0          ; is end of file or end of line?
        jz toint            ; if so then go to transer to int section
        jmp q_ndig2         ; else not a digit entered
        ; Transfer entered strings to integer
toint:
        ; First string to integer
        push dword [len1]   ; set second parameter get_int_from_str
        push str1           ; set first parameter get_int_from_str
        call get_int_from_str
        add esp, 8
        cmp edx, 1          ; if work result is not ok then quit
        jz q_sif1
        mov ebx, eax        ; first integer stored in ebx
        ; Second string to integer
        push dword [len2]   ; set second parameter get_int_from_str
        push str2           ; set first parameter get_int_from_str
        call get_int_from_str   ; now in eax stored second integer
        add esp, 8
        cmp edx, 1          ; if work result is not ok then quit
        jz q_sif2
        ; Calculation section
        ; Get sum
        add ebx, eax
        mov [sumint], ebx   ; save sum result
        sub ebx, eax        ; reverse action
        ; Get sub
        sub ebx, eax
        mov [subint], ebx   ; save sub result
        add ebx, eax        ; reverse action
        ; Get mul
        mul ebx
        mov [mulint], eax   ; save mul result
        ; Transfer integer results to strings section
        ; Transfer integer sum result to string
        push sumstr          ; set second param. (address for string)
        push dword [sumint]  ; set first param. (sum integer result)
        call get_str_from_int
        add esp, 8
        ; Transfer integer sub result to string
        push substr         ; move destination address for string
        push dword [subint] ; move sub integer result to eax
        call get_str_from_int
        add esp, 8
        ; Transfer integer mul result to string
        push mulstr         ; move destination address for string
        push dword [mulint] ; move mul integer result to eax
        call get_str_from_int
        add esp, 8
        ; Print results section
        ; Print sum result
        PRINT "Sum result: "  
        push sumstr         ; set parameter: sum string result 
        call print_str
        add esp, 4
        PUTCHAR 10
        ; Print sub result
        PRINT "Sub result: "  
        push substr         ; set parameter: sub string result
        call print_str
        add esp, 4
        PUTCHAR 10
        ; Print mul result
        PRINT "Mul result: "  
        push mulstr         ; set parameter: mul string result
        call print_str
        add esp, 4
        jmp quit      
        ; Quit section
q_ndig1:PRINT "'"
        PUTCHAR al
        PRINT "' from first string is not a digit"
        jmp quit
q_ndig2:PRINT "'"
        PUTCHAR al
        PRINT "' from second string is not a digit"
        jmp quit
q_zb1:  PRINT "Successfully wrinten bytes from first number is zero"
        jmp quit
q_zb2:  PRINT "Successfully wrinten bytes from second number is zero"
        jmp quit
q_eof:  PRINT "No second number entered"
        jmp quit
q_sif1: PRINT "Can't transfer first string to integer"
        jmp quit
q_sif2: PRINT "Can't transfer second string to integer"
        jmp quit
quit:   PUTCHAR 10          ; end program
        FINISH