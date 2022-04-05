; This program print each line entered backwards

%include "../nasm_hello/stud_io.inc"
global _start

section .text
_start: mov ecx, 0      ; set final line flag to zero
        mov esi, esp    ; set esi first character's address
lp:     GETCHAR         ; get char from stdin
        cmp eax, -1     ; is char end of file?
        jz next         ; if so then go to next section
        push eax        ; push char in to the stack
        jmp lp          ; get next char
next:   mov edi, esp    ; set edi last character's address
        mov ebp, esi    ; set temp pointer ebp first character's address
        mov eax, [ebp]  ; move first character to eax
        ; Find end of the line
lp2:    cmp ebp, edi    ; is end of file?
        je lstprnt      ; if so then go to last print label
        cmp eax, 10     ; is char end of line?
        je preprnt      ; if so then go to print section
        sub ebp, 4      ; move pointer back
        mov eax, [ebp]  ; extract char to eax
        jmp lp2
        ; Print line from backwards
lstprnt:mov ecx, 1      ; set last print flag
preprnt:push ebp        ; save ebp
prnt:   mov eax, [ebp]  ; move char to eax
        PUTCHAR al      ; print char
        cmp esi, ebp    ; is begin of the line?
        jz endprnt      ; if so then end printing
        add ebp, 4      ; move pointer next
        jmp prnt        ; repeat print loop
endprnt:cmp ecx, 1      ; if last print flag then exit
        jz exit
        pop ebp         ; restore ebp
        sub ebp, 4      ; set esi and ebp to the first char of new line
        mov esi, ebp
        jmp lp2         ; find next end of the line
exit:   PUTCHAR 10
        FINISH
