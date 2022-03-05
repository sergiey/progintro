program task_2_21;
function IsCharSpace(str: string; pos: integer): boolean;
begin
    IsCharSpace := ((str[pos] = ' ') or (str[pos] = #9))
end;
procedure PrintTwoCharWord(str: string; pos: integer);
begin
    write(str[pos], str[pos + 1])
end;
var
    sIn: string;
    i: integer;
begin
    while not seekeof do begin
        while not eoln do begin
            i := 1;
            read(sIn);
            while i <= Length(sIn) do begin
                if i = Length(sIn) - 1 then begin
                    if not IsCharSpace(sIn, i) and not IsCharSpace(sIn, i + 1) then 
                        PrintTwoCharWord(sIn, i)
                    else
                        break;
                end;
                if not IsCharSpace(sIn, i) and not IsCharSpace(sIn, i + 1) and
                    IsCharSpace(sIn, i + 2) then begin
                    PrintTwoCharWord(sIn, i);
                    write(' ');
                    i := i + 3
                    end
                else if IsCharSpace(sIn, i) and not IsCharSpace(sIn, i + 1) and
                    not IsCharSpace(sIn, i + 2) then
                    i := i + 1
                else if (IsCharSpace(sIn, i) and IsCharSpace(sIn, i + 1) and
                    not IsCharSpace(sIn, i + 2)) or (not IsCharSpace(sIn, i) and 
                    IsCharSpace(sIn, i + 1) and not IsCharSpace(sIn, i + 2)) then
                    i := i + 2
                else
                    i := i + 3
            end
        end;
        writeln
    end
end.