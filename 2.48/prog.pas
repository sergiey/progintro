program task_2_48;
var
    f: text;
    c: char;
    counter: integer = 0;
begin
    {$I-}
    if ParamCount < 1 then begin
        writeln(ErrOutput, 'No file path');
        halt(1)
    end;
    assign(f, ParamStr(1));
    reset(f);
    if IOResult <> 0 then begin
        writeln(ErrOutput, 'Couldn''t read file');
        halt(1)
    end;
    while not seekeof(f) do begin
        while not eoln(f) do
            read(f, c);
        counter := counter + 1
    end;
    close(f);
    writeln(counter)
end.