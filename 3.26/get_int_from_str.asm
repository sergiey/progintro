; Get integer from string (address, length)
; Return: eax = integer, edx = work result (0 - OK, 1 - not OK)
global get_int_from_str

section .text
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