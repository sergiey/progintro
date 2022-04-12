; This program print longest command line parameter
global _start

_start: cmp dword [esp], 1      ; is no command line parameters?
        jz quit                 ; if so then quit
        xor edi, edi            ; number of longest parameter stored in edi
        xor ebx, ebx            ; temp. longest parameter length in ebx
        xor ecx, ecx            ; count characters stored in ecx
        mov eax, [esp]          ; move in eax number of parameters
        dec eax                 ; exclude program name
        ; Calculate longest parameter
lp:     cmp eax, 0              ; is any parameter left
        jz prnt                 ; if not then go print
        mov esi, [esp + 4 * eax + 4]    ; set address of parameter
lp2:    cmp byte [esi], 0       ; is end of parameter?
        jz next                 ; if so then go next
        inc ecx                 ; count char
        add esi, 1              ; next char
        jmp lp2
next:   cmp ecx, ebx            ; is parameter lenght more than previous?
        jle next2               ; if so then do nothing
        mov ebx, ecx            ; set new longest lenght
        mov edi, eax            ; set new longest parameter number
next2:  xor ecx, ecx            ; reset counter
        dec eax                 ; minus one parameter
        jmp lp
        ; Print longest parameter
prnt:   mov edx, ebx            ; set length
        mov ecx, [esp + 4 * edi + 4]    ; set longest parameter address
        mov eax, 4              ; set "write" code
        mov ebx, 1              ; set standard output
        int 80h
        ; Quit section
quit:   mov edx, 1              ; print line break
        mov byte [ecx], 10
        mov eax, 4
        mov ebx, 1
        int 80h
        mov eax, 1              ; exit
        mov ebx, 0
        int 80h