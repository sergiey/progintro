program task_2_55;
uses errmsg;
type
    itemstr = string[59];
    item = record
        id: itemstr;
        count: longint
    end;
    foi = file of item;
procedure AddItem(var f: foi; id: itemstr);
var
    idx: integer = 0;
    n: item;
begin
    while not eof(f) do begin
        seek(f, idx);
        read(f, n);
        if IOResult <> 0 then
            PrintErrorMsg('Couldn''t read file');
        if n.id = id then begin
            n.count := n.count + 1;
            seek(f, idx);
            write(f, n);
            if IOResult <> 0 then
                PrintErrorMsg('Couldn''t write file');
            close(f);
            exit
        end;
        idx := idx + 1
    end;
    n.count := 1;
    n.id := id;
    seek(f, idx);
    write(f, n);
    if IOResult <> 0 then
            PrintErrorMsg('Couldn''t write file');
    close(f)
end;
procedure QueryResponse(var f: foi; id: itemstr);
var
    idx: integer = 0;
    n: item;
begin
    while not eof(f) do begin
        seek(f, idx);
        read(f, n);
        if IOResult <> 0 then
            PrintErrorMsg('Couldn''t read file');
        if n.id = id then begin
            writeln(n.count);
            close(f);
            exit
        end;
        idx := idx + 1
    end;
    writeln(0)
end;
procedure PrintList(var f: foi);
var
    n: item;
begin
    while not eof(f) do begin
        read(f, n);
        if IOResult <> 0 then
            PrintErrorMsg('Couldn''t read file');
        writeln(n.id, ': ', n.count)
    end;
    close(f)
end;
var
    f: foi;
    cmd: string[5];
    id: itemstr;
begin
    {$I-}
    if ParamCount < 2 then
        PrintErrorMsg('Not enough parameters');
    cmd := ParamStr(2);
    if (cmd <> 'add') and (cmd <> 'query') and (cmd <> 'list') then
        PrintErrorMsg('Unknown command');
    if ((cmd = 'add') or (cmd = 'query')) and (ParamCount < 3) then
        PrintErrorMsg('Identifier not specified')
    else
        id := ParamStr(3);
    assign(f, ParamStr(1));
    reset(f);  
    if IOResult <> 0 then
        PrintErrorMsg('Couldn''t open file ', ParamStr(1));
    case cmd of
        'add': AddItem(f, id);
        'query': QueryResponse(f, id);
        'list': PrintList(f)
    end
end.