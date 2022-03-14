program task_2_43;
type
    LOCptr = ^LOCItem;
    LOCItem = record
        data: char;
        lineNum: integer;
        next: LOCptr
    end;
    ListOfChars = record
        first, last: LOCptr
    end;
procedure InitLOC(var loc: ListOfChars);
begin
    loc.first := nil;
    loc.last := nil
end;
procedure LOCNewItem(c: char; lineNum: integer; var ptr: LOCptr);
begin
    new(ptr);
    ptr^.data := c;
    ptr^.lineNum := lineNum;
    ptr^.next := nil
end;
procedure LOCAddItem(c: char; lineNum: integer; var loc: ListOfChars);
var
    tmp: LOCptr;
begin
    if loc.first = nil then begin
        LOCNewItem(c, lineNum, loc.first);
        loc.last := loc.first
    end
    else begin
        LOCNewItem(c, lineNum, tmp);
        loc.last^.next := tmp;
        loc.last := tmp
    end
end;
procedure LOCInsert(c: char; lineNum: integer; var ptr: LOCptr);
var
    tmp: LOCptr;
begin
    new(tmp);
    tmp^.data := c;
    tmp^.lineNum := lineNum;
    tmp^.next := ptr^.next;
    ptr^.next := tmp
end;
procedure LOCClear(var loc: ListOfChars);
var
    tmp: LOCptr;
begin
    while loc.first <> nil do begin
        tmp := loc.first;
        loc.first := loc.first^.next;
        dispose(tmp)
    end
end;
function GetMaxLineNum(loc: ListOfChars): integer;
var
    pp: ^LOCptr;
    maxLineNum: integer = 0;
begin
    pp := @loc.first;
    while pp^ <> nil do begin
        if pp^^.lineNum > maxLineNum then
            maxLineNum := pp^^.lineNum;
        pp := @(pp^^.next)
    end;
    GetMaxLineNum := maxLineNum
end;
var
    c: char;
    loc: ListOfChars;
    maxLineNum, lineNum: integer;
    pp: ^LOCptr;
begin
    {$I-}
    while not seekeof do begin
        lineNum := 1;
        InitLOC(loc);
        while not eoln do begin
            read(c);
            if IOResult <> 0 then begin
                writeln(ErrOutput, 'Couldn''t read character');
                halt(1)
            end;
            if (c = ' ') or (c = #9) then
                lineNum := 1
            else begin
                LOCAddItem(c, lineNum, loc);
                lineNum := lineNum + 1
            end
        end;
        maxLineNum := GetMaxLineNum(loc);
        LOCAddItem(' ', 0, loc);
        pp := @loc.first;
        while pp^^.next <> nil do begin
            if (pp^^.lineNum <> maxLineNum) and 
                (pp^^.next^.lineNum <= pp^^.lineNum) then begin
                LOCInsert(' ', pp^^.lineNum + 1, pp^);
                continue
            end;
            pp := @(pp^^.next);
        end;
        for lineNum := 1 to maxLineNum do begin
            pp := @loc.first;
            while pp^ <> nil do begin
                if pp^^.lineNum = lineNum then
                    write(pp^^.data);
                pp := @(pp^^.next)
            end;
            writeln
        end;
        LOCClear(loc)
    end
end.