; This macros takes any number of parameters as a label
; and jump to the one of whose number stored in eax

%macro jumpLabelFromEAX 1-*
        cmp eax, 0          ; is eax <= 0?
        jle %%quit          ; if so then quit
        cmp eax, %0         ; is eax > number of parameters?
        jg %%quit           ; if so then quit
    %assign n 1
    %rep %0                 ; repeat number of parameters times
        cmp eax, n          ; is n equal number from eax?
        je %1               ; if so then jump label
        %assign n n+1       ; increase n
        %rotate 1           ; rotate parameters
    %endrep
%%quit:
%endmacro
