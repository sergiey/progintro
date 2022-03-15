program task_2_52;
type
    listptr = ^listItem;
    listItem = record
        fileOrder, longestLine: integer;
        isLongest: boolean;
        next: listptr;
    end;
    list = record
        first, last: listptr
    end;
procedure InitList(var l: list);
begin
    l.first := nil;
    l.last := nil
end;
procedure ListNewItem(fileOrder, longestLine: integer; var ptr: listptr);
begin
    new(ptr);
    ptr^.fileOrder := fileOrder;
    ptr^.longestLine := longestLine;
    ptr^.isLongest := false;
    ptr^.next := nil
end;
procedure ListAddItem(fileOrder, longestLine: integer; var l: list);
var
    tmp: listptr;
begin
    if l.first = nil then begin
        ListNewItem(fileOrder, longestLine, l.first);
        l.last := l.first
    end
    else begin
        ListNewItem(fileOrder, longestLine, tmp);
        l.last^.next := tmp;
        l.last := tmp
    end
end;
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
    f: text;
    s: string;
    i, longestLine: integer;
    l: list;
    pp: ^listptr;
begin
    {$I-}
    if ParamCount < 1 then
        PrintErrorMsg('No file specified');
    InitList(l);
    for i := 1 to ParamCount do begin
        longestLine := 0;
        assign(f, ParamStr(i));
        reset(f);
        if IOResult <> 0 then
            PrintErrorMsg('Couldn''t open file ', ParamStr(i));
        while not eof(f) do begin
            readln(f, s);
            if length(s) > longestLine then
                longestLine := length(s)
        end;
        close(f);
        ListAddItem(i, longestLine, l)
    end;
    pp := @l.first;
    while pp^ <> nil do begin
        if pp^^.longestLine > longestLine then
            longestLine := pp^^.longestLine;
        pp := @(pp^^.next)
    end;
    pp := @l.first;
    while pp^ <> nil do begin
        if pp^^.longestLine = longestLine then
            pp^^.isLongest := true;
        pp := @(pp^^.next)
    end;
    pp := @l.first;
    for i := 1 to ParamCount do begin
        assign(f, ParamStr(i));
        reset(f);
        if IOResult <> 0 then
            PrintErrorMsg('Couldn''t open file ', ParamStr(i));
        if pp^^.isLongest then
            write('*');
        write(ParamStr(i), ': ');
        while not eof(f) do begin
            readln(f, s);
            if length(s) = pp^^.longestLine then begin
                writeln(s);
                break
            end
        end;
        close(f);
        pp := @(pp^^.next)
    end
end.