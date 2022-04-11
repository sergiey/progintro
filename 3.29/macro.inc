; This macros ...
%macro jumpLabelFromEAX 1-*
        cmp eax, 0          ; is eax <= 0?
        jle %%quit          ; if so then quit
        cmp eax, %0         ; is eax > number of parameters?
        jg %%quit           ; if so then quit
    %assign n 1
    %rep %0
        cmp eax, n
        je %1

    %assign n n+1
    %rotate 1
    %endrep
%%quit:
%endmacro
