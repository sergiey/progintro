; This program resive first command line parameter as file name, 
; other as a string. Create text file and write string to it 10 times

global _start

section .bss
parstr  resb 256
strlen  resd 1
fd      resd 1

section .text
_start: cmp dword [esp], 3      ; at least 2 parameters required
        jl q_nok                ; if less then not ok quit
        ; Get string from parameters
        xor ecx, ecx            ; count string lenght
        mov eax, 2              ; set number of first string parameter
        mov edi, parstr         ; set destination address for copy params.
lp:     cmp eax, [esp]          ; is out of parameters?
        jz fincop               ; if so then go finish copy
        mov esi, [esp + 4 + 4 * eax]    ; set address of parameter
        ; Copy parameter to parstr
copy:   cmp byte [esi], 0
        jz skip
        mov bl, [esi]
        mov byte [edi], bl      ; copy char from parameter to parstr
        add esi, 1              ; increas source address
        add edi, 1              ; increas destination address
        inc ecx                 ; increase length counter
        jmp copy
skip:   inc eax                 ; minus parameter
        jmp lp                  ; copy next parameter
fincop: mov byte [edi], 0       ; put zero byte in the end of the string
        mov [strlen], ecx       ; move final string length to strlen
        ; Open file
        mov eax, 5              ; open
        mov ebx, [esp + 8]      ; file name
        mov ecx, 241h           ; open if exist or create new file
        mov edx, 0666q          ; access rights
        int 80h                 ; syscall
        ; Is file opened successfully?
        mov ecx, eax
        and ecx, 0fffff000h
        cmp ecx, 0fffff000h
        jne open_ok             ; if open success then go next
        jmp q_nok               ; if not then quit not ok
open_ok:mov [fd], eax           ; save file descriptor
        ; Write string in the file 10 times
        mov ecx, 10
lp2:    push ecx
        mov eax, 4
        mov ebx, [fd]
        mov ecx, parstr
        mov edx, [strlen]
        int 80h
        ; Add line break
        mov eax, 4
        mov ebx, [fd]
        mov byte [edi], 10
        mov ecx, edi
        mov edx, 1
        int 80h
        pop ecx
        loop lp2
        ; Close file
        mov eax, 6
        mov ebx, [fd]
        int 80h
q_ok:   mov ebx, 0              ; quit ok
        jmp quit
q_nok:  mov ebx, 1              ; quit not ok
quit:   mov eax, 1              ; exit
        int 80h