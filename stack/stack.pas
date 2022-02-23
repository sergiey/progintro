program mystack_prog;
type
    stackptr = ^mystack;
    mystack = record
        data: integer;
        next: stackptr;
    end;
var
    bufptr, initptr: stackptr;
begin
    {$I-}
    bufptr := nil;
    initptr := nil;
    while not seekeof do
    begin
        new(initptr);
        read(initptr^.data);
        if IOResult <> 0 then
        begin
            writeln(ErrOutput, 'Couldn''t read a number');
            halt(1)
        end;
        initptr^.next := bufptr;
        bufptr := initptr
    end;
    repeat
        writeln(initptr^.data);
        if IOResult <> 0 then
        begin
            writeln(ErrOutput, 'Couldn''t write a number');
            halt(1)
        end;
        initptr := initptr^.next;
    until initptr = nil
end.