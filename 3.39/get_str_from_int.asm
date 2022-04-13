; Get string from integer (digit, address)
global get_str_from_int

section .text
get_str_from_int:
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