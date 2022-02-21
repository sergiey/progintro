program makeNumbersBin;
const
    MinNumber = 1000;
    Step = 1001;
    Numbers = 100;
var
    f: file of longint;
    number: longint;
    i: integer;
begin
    {$I-}
    assign(f, 'dig.bin');
    rewrite(f);
    if IOResult <> 0 then begin
        writeln(ErrOutput, 'Couldn''t write file');
        halt(1);
    end;
    number := MinNumber;
    for i := 1 to Numbers do begin
        write(f, number);
        number := number + Step;
    end;
    close(f)
end.