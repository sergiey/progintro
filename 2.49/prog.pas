program task_2_49;
var
    f: text;
    c: char;
begin
    {$I-}
    if ParamCount < 1 then begin
        writeln(ErrOutput, 'No file path');
        halt(1)
    end;
    assign(f, ParamStr(1));
    rewrite(f);
    if IOResult <> 0 then begin
        writeln(ErrOutput, 'Couldn''t read file');
        halt(1)
    end;
    while not eof do begin
        read(c);
        write(f, c)
    end;
    close(f)
end.