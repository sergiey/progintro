; This program successfully end if recive three command line parameters
%include "../nasm_hello/stud_io.inc"
global _start

_start: cmp byte [esp], 4   ; is three parameters?
        jz q_ok             ; if so then ok quit
        jmp q_nok           ; else not ok quit
q_ok:   mov ebx, 0          ; success code
        jmp quit
q_nok:  mov ebx, 1          ; not success code
quit:   mov eax, 1          ; call exit
        int 80h             ; syscall
