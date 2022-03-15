program task_2_54_numgen;
procedure PrintErrorMsg(errorMsg, errorLoc: string);
begin
    writeln(ErrOutput, errorMsg, errorLoc);
    halt(1)
end;
procedure PrintErrorMsg(errorMsg: string);
begin
    writeln(ErrOutput, errorMsg);
    halt(1)
end;
var
    f: file of longint;
    n: longint;
    idx: integer = 0;
begin
    {$I-}
    if ParamCount < 1 then
        PrintErrorMsg('Output file path not specified');
    assign(f, ParamStr(1));
    rewrite(f);
    if IOResult <> 0 then
        PrintErrorMsg('Couldn''t write file ', ParamStr(1));
    while not seekeof do begin
        read(n);
        if IOResult <> 0 then
            PrintErrorMsg('Couldn''t read number');
        seek(f, idx);
        write(f, n);
        idx := idx + 1
    end;
    close(f)
end.