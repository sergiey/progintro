program prog;
const
    MaxCharNumber = 255;
type
    IsCharPrinted = array [0..MaxCharNumber] of boolean;
var
    i, pos: integer;
    str: string;
    isPrinted: IsCharPrinted;
begin
    writeln('Enter some text');
    readln(str);
    for i := 0 to MaxCharNumber do
        isPrinted[i] := false;

    for pos := 1 to Length(str) do begin
        if (str[pos] = #9) or (str[pos] = #32) then
            continue;
        if isPrinted[ord(str[pos])] then
            continue;
        for i := pos + 1 to Length(str) do begin
            if str[pos] = str[i] then begin
                write(str[pos]);
                isPrinted[ord(str[pos])] := true;
                break
            end
        end
    end;
    writeln
end.