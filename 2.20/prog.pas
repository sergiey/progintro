program task_2_20;
function IsPrevCharSpace(str: string; currentPos: integer): boolean;
begin
    IsPrevCharSpace := ((str[currentPos - 1] = ' ') or
            (str[currentPos - 1] = #9))
end;
function IsCurrentCharSpace(str: string; currentPos: integer): boolean;
begin
    IsCurrentCharSpace := ((str[currentPos] = ' ') or (str[currentPos] = #9))
end;
function IsNextCharSpace(str: string; currentPos: integer): boolean;
begin
    IsNextCharSpace := ((str[currentPos + 1] = ' ') or
            (str[currentPos + 1] = #9))
end;
procedure InsertChar(symbol: char; var sOut: string; var pos: integer);
begin
    insert(symbol, sOut, pos);
    pos := pos + 1
end;
procedure InsertOpenedParAndChar(symbol: char; var sOut: string; 
    var pos: integer);
begin
    insert('(', sOut, pos);
    pos := pos + 1;
    insert(symbol, sOut, pos);
    pos := pos + 1
end;
procedure InsertCharAndClosedPar(symbol: char; var sOut: string; 
    var pos: integer);
begin
    insert(symbol, sOut, pos);
    pos := pos + 1;
    insert(')', sOut, pos);
    pos := pos + 1
end;
procedure InsertOpenedParCharClosedPar(symbol: char; var sOut: string; 
    var pos: integer);
begin
    insert('(', sOut, pos);
    pos := pos + 1;
    insert(symbol, sOut, pos);
    pos := pos + 1;
    insert(')', sOut, pos);
    pos := pos + 1
end;
var
    sIn, sOut: string;
    i, pos: integer;
begin
    while not eoln do begin
        sOut := '';
        pos := 1;
        {$I-}
        read(sIn);
        if IOResult <> 0 then begin
            writeln(ErrOutput, 'Couldn''t read line');
            halt(1)
        end;
        write('"');
        for i := 1 to Length(sIn) do begin
            if i = 1 then begin
                if not IsCurrentCharSpace(sIn, i) and 
                    IsNextCharSpace(sIn, i) then
                    InsertOpenedParCharClosedPar(sIn[i], sOut, pos)
                else if not IsCurrentCharSpace(sIn, i) and 
                    not IsNextCharSpace(sIn, i) then
                    InsertOpenedParAndChar(sIn[i], sOut, pos)
                else
                    InsertChar(sIn[i], sOut, pos);
                continue
            end;
            if i = Length(sIn) then begin
                if IsPrevCharSpace(sIn, i) and 
                    not IsCurrentCharSpace(sIn, i) then
                    InsertOpenedParCharClosedPar(sIn[i], sOut, pos)
                else if not IsPrevCharSpace(sIn, i) and 
                    not IsCurrentCharSpace(sIn, i) then
                    InsertCharAndClosedPar(sIn[i], sOut, pos)
                else
                    InsertChar(sIn[i], sOut, pos);
                continue
            end;
            if IsPrevCharSpace(sIn, i) and not IsCurrentCharSpace(sIn, i)
                and IsNextCharSpace(sIn, i) then
                InsertOpenedParCharClosedPar(sIn[i], sOut, pos)
            else if IsPrevCharSpace(sIn, i) and not IsCurrentCharSpace(sIn, i)
                and not IsNextCharSpace(sIn, i) then
                InsertOpenedParAndChar(sIn[i], sOut, pos)
            else if not IsPrevCharSpace(sIn, i) and 
                not IsCurrentCharSpace(sIn, i) and IsNextCharSpace(sIn, i) then
                InsertCharAndClosedPar(sIn[i], sOut, pos)
            else
                InsertChar(sIn[i], sOut, pos)
        end;
        write(sOut);
        writeln('"')
    end
end.