program task_2_54;
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
    outf: text;
    inpf: file of longint;
    i, idx: integer;
    n, maxN, minN: longint;
begin
    {$I-}
    if ParamCount < 2 then
        PrintErrorMsg('Not enough parameters');
    assign(outf, ParamStr(ParamCount));
    rewrite(outf);
    if IOResult <> 0 then
        PrintErrorMsg('Couldn''t write file ', ParamStr(ParamCount));
    for i := 1 to ParamCount - 1 do begin
        idx := 0;
        maxN := Low(longint);
        minN := High(longint);
        assign(inpf, ParamStr(i));
        reset(inpf);
        write(outf, ParamStr(i), ': ');
        while not eof(inpf) do begin
            seek(inpf, idx);
            read(inpf, n);
            if IOResult <> 0 then
                PrintErrorMsg('Couldn''t read file ', ParamStr(i));
            if n > maxN then
                maxN := n;
            if n < minN then
                minN := n;
            idx := idx + 1
        end;
        writeln(outf, 'amount ', idx, ', min ', minN, ', max ', maxN);
        close(inpf)
    end;
    close(outf)
end.