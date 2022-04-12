; This program ends successfully if:
; a) transmit only two parameters
; b) lengths of parameters are equal
; c) last char of parameters are equal too
global _start

section .text
_start: cmp byte [esp], 3       ; is two parameters?
        jnz q_nok               ; if not then quit not ok
        ; Calculate length of parameters
        xor ecx, ecx
        mov esi, [esp + 8]      ; set first parameter address to esi
lp:     cmp byte [esi], 0       ; is end of parameter?
        jz next                 ; if so then go next
        inc ecx
        add esi, 1              ; set next character
        jmp lp
next:   mov ebx, ecx            ; save first parameter length
        xor ecx, ecx
        mov edi, [esp + 12]     ; set second parameter address to edi
lp2:    cmp byte [edi], 0       ; is end of parameter?
        jz next2                ; if so then go next
        inc ecx
        add edi, 1              ; set next character
        jmp lp2
        ; If lengths of parameters are not equal then quit
next2:  cmp ecx, ebx            ; is len1 & len2 are equal?
        jnz q_nok               ; if not then quit not ok
        ; Compare last characters of parameters
        mov al, byte [esi - 1]  ; move last char of first parameter to al
        mov ah, byte [edi - 1]  ; move last char of second parameter to ah
        cmp al, ah              ; is last chars are equal?
        jz q_ok                 ; if not then unsuccessfully quit
        jmp q_nok               ; else successfully quit
q_nok:  mov ebx, 1              ; end unsuccessfully
        jmp quit
q_ok:   mov ebx, 0              ; end successfully
quit:   mov eax, 1              ; exit code
        int 80h                 ; syscall