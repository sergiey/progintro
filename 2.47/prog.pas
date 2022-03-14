program task_2_47;
var
    f: text;
    n: char;
begin
    {$I-}
    if ParamCount < 1 then begin
        writeln('No file path');
        halt(1)
    end;
    assign(f, ParamStr(1));
    reset(f);
    if IOResult <> 0 then begin
        writeln(ErrOutput, 'Couldn''t open file');
        halt(1)
    end;
    while not seekeof(f) do begin
        while not eoln(f) do begin
            read(f, n);
            write(n)
        end;
        writeln
    end;
    close(f)
end.