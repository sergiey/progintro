%include "../nasm_hello/stud_io.inc"
%include "./macro.inc"
global _start

_start: mov eax, 1
        jumpLabelFromEAX l1, l2, l3, l4
        PRINT "EAX <= 0 or EAX > number of parameters"
        jmp quit
l1:     PRINT "Label 1"
        jmp quit
l2:     PRINT "Label 2"
        jmp quit
l3:     PRINT "Label 3"
        jmp quit
l4:     PRINT "Label 4"
        jmp quit
quit:   PUTCHAR 10
        FINISH
