program task_2_53;
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
    srcFile, spcFile: text;
    lenFile: file of integer;
    idx: integer = 0;
    line: string;
begin
    {$I-}
    if ParamCount < 3 then 
        PrintErrorMsg('Not enough parameters. Must be three');
    assign(srcFile, ParamStr(1));
    reset(srcFile);
    if IOResult <> 0 then 
        PrintErrorMsg('Couldn''t open file ', ParamStr(1));
    assign(spcFile, ParamStr(2));
    assign(lenFile, ParamStr(3));
    rewrite(spcFile);
    if IOResult <> 0 then
        PrintErrorMsg('Couldn''t write file ', ParamStr(2));
    rewrite(lenFile);
    if IOResult <> 0 then
        PrintErrorMsg('Couldn''t write file ', ParamStr(3));
    while not eof(srcFile) do begin
        readln(srcFile, line);
        if line[1] = ' ' then begin
            writeln(spcFile, line);
            if IOResult <> 0 then
                PrintErrorMsg('Couldn''t write in file ', ParamStr(2));
        end;
        seek(lenFile, idx);
        write(lenFile, length(line));
        if IOResult <> 0 then
            PrintErrorMsg('Couldn''t write in file ', ParamStr(3));
        idx := idx + 1
    end;
    close(spcFile);
    close(lenFile);
    close(srcFile)
end.