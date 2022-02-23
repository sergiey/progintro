program task_2_19;
procedure ReadLongint(var success: boolean; var result: longint; base: integer);
type
    Digits = array [1..36] of char;
var
    c: char;
    inRange: boolean;
    res: longint;
    pos, i, decnum: integer;
    d: Digits = ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c',
                 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p',
                 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z');
begin
    res := 0;
    pos := 0;
    repeat
        read(c);
        pos := pos + 1
    until (c <> ' ') and (c <> #10);
    while (c <> ' ') and (c <> #10) do begin
        if (c >= 'A') and (c <= 'Z') then begin
            c := chr(ord(c) + 32);
        end;
        decnum := 0;
        inRange := false;
        for i := 1 to base do begin
            if c = d[i] then begin
                inRange := true;
                break;
            end;
            decnum := decnum + 1;
        end;
        if not inRange then begin
            writeln('Unexpected symbol in pos: ', pos);
            readln;
            success := false;
            exit
        end;
        res := res * base + decnum;
        read(c);
        pos := pos + 1
    end;
    result := res;
    success := true
end;
var
    ok: boolean;
    x: longint;
    base: integer;
begin
    repeat
        writeln('Enter number''s base from 2 to 16');
        read(base);
    until (2 <= base) and (base <= 16);
    writeln('Enter number a number withe base ', base); 
    ReadLongint(ok, x, base);
    writeln('Translate is success: ', ok);
    writeln('Entered number in decimal: ', x)
end.
