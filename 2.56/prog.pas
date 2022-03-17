program task_2_56;
uses errmsg in '../2.55/errmsg.pp';
type
    itemstr = string[59];
    item = record
        id: itemstr;
        count: longint
    end;
    foi = file of item;
procedure AddItem(var f: foi; idx: integer; id: itemstr; count: longint);
var
    n: item;
begin        
    n.count := count;
    n.id := id;
    seek(f, idx);
    write(f, n);
    if IOResult <> 0 then
            PrintErrorMsg('Couldn''t write file')
end;
var
    inf, out: foi;
    n, m: item;
    idxin, idxout: integer;
    isNewItem: boolean;
begin
    {$I-}
    if ParamCount < 3 then
        PrintErrorMsg('Not enough parameters. Should be three file paths');
    assign(inf, ParamStr(1));
    reset(inf);
    if IOResult <> 0 then
        PrintErrorMsg('Couldn''t read file ', ParamStr(1));
    assign(out, ParamStr(3));
    rewrite(out);
    if IOResult <> 0 then
        PrintErrorMsg('Couldn''t write file ', ParamStr(3));
    idxin := 0;
    while not eof(inf) do begin
        seek(inf, idxin);
        read(inf, n);
        seek(out, idxin);
        write(out, n);
        idxin := idxin + 1
    end;
    close(inf);
    assign(inf, ParamStr(2));
    reset(inf);
    if IOResult <> 0 then
        PrintErrorMsg('Couldn''t read file ', ParamStr(2));
    idxin := 0;
    while not eof(inf) do begin
        seek(inf, idxin);
        read(inf, n);
        isNewItem := true;
        idxout := 0;
        seek(out, idxout);
        while not eof(out) do begin
            seek(out, idxout);
            read(out, m);
            if n.id = m.id then begin
                isNewItem := false;
                m.count := m.count + n.count;
                seek(out, idxout);
                write(out, m);
                break
            end;
            idxout := idxout + 1
        end;
        if isNewItem then
            AddItem(out, idxout, n.id, n.count);
        idxin := idxin + 1
    end;
    close(inf);
    close(out)
end.