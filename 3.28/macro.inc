; This macro fill memory with 4-bytes integers
; %1 = start, %2 = step, %3 = count
%macro fill_4bint 3
%assign n 0
%rep %3
        dd %1 + n * %2 
        %assign n n + 1
%endrep
%endmacro