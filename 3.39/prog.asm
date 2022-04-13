; This program recive text file name as the command line parameter,
; count lines and print it

global _start
extern get_str_from_int         ; transfer integer to string module

section .data
errmsg  db "Error: couldn't open file", 0
msglen  equ $ - errmsg

section .bss
fd      resd 1                  ; opened file descriptor
buffer  resb 4096
bufsize equ $ - buffer
lbc     resd 1                  ; line break counter
res     resb 11                 ; result

section .text
_start: cmp dword [esp], 2      ; is no command line parameter?
        jl quit                 ; if so then quit
        ; Open text file
        mov eax, 5              ; open file
        mov ecx, 0              ; read only
        mov ebx, [esp + 8]      ; file name
        int 80h
        ; Is file opened successfully?
        mov ecx, eax
        and ecx, 0fffff000h
        cmp ecx, 0fffff000h
        jne open_ok             ; if open success then go next
        jmp q_cof               ; if not then quit
        ; Read file
open_ok:mov [fd], eax           ; save opened file descriptor
lp:     mov eax, 3              ; read file
        mov ebx, [fd]           ; opened file discriptor
        mov ecx, buffer         ; where put a data
        mov edx, bufsize        ; read data size
        int 80h                 ; syscall
        ; Handle syscall read
        cmp eax, 0              ; is read success?
        jle print               ; if not then print result
        ; Handle data in buffer
        mov ecx, eax            ; set counter
        mov esi, buffer        
count:  cmp byte [buffer + ecx - 1], 10  ; is char are line break?
        jnz skip                ; if not then skip
        inc dword [lbc]         ; if so then increas line break counter
skip:   loop count
        jmp lp                  ; repat read data
        ; Print result section
print:  push res                ; set second param. (address for string)
        push dword [lbc]        ; set first param. (sum integer result)
        call get_str_from_int
        add esp, 8
        ; Count string length
        xor ecx, ecx
        mov esi, res
clen:   cmp byte [esi], 0
        jz wrtout
        inc ecx
        add esi, 1
        jmp clen
        ; Write result in stdout
wrtout: mov eax, 4
        mov ebx, 1
        mov edx, ecx
        mov ecx, res
        int 80h
        ; Close file
        mov eax, 6
        mov ebx, [fd]
        int 80h
        jmp quit
        ; Print error message
q_cof:  mov eax, 4
        mov ebx, 1
        mov edx, msglen
        mov ecx, errmsg
        int 80h
        jmp quit
quit:   mov eax, 4              ; put break line
        mov ebx, 1
        mov ecx, 10
        push ecx
        mov ecx, esp
        mov edx, 1
        int 80h
        mov eax, 1              ; exit
        mov ebx, 0
        int 80h