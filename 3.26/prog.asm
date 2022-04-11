; Main program
%include "../nasm_hello/stud_io.inc"
global _start
extern get_int_from_str
extern get_str_from_int
extern get_str_from_stdin
extern print_str

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