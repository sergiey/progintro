function Pow(a, n: integer): longint;
begin
    if n = 0 then begin
        Pow := 1;
        exit
    end;
    Pow := a * Pow(a, n - 1)
end;
function StrToReal(s: string; var isSucceed: boolean): real;
var
    isNegative: boolean;
    i, pos, integerLength, exp: integer;
    dotPos: integer = -1;
    res: real;
begin
    if (Length(s) < 1) or ((Length(s) = 1) and (s[1] = '-')) then begin
        isSucceed := false;
        exit
    end;
    res := 0;
    if s[1] = '-' then begin
        isNegative := true;
        pos := 2
    end
    else begin
        isNegative := false;
        pos := 1
    end;
    for i := 1 to Length(s) do begin
        if s[i] = '.' then begin
            dotPos := i;
            exp := 1;
            break
        end
    end;
    if dotPos = -1 then
        integerLength := Length(s)
    else
        integerLength := dotPos - 1;
    for i := pos to integerLength do begin
        if (s[i] >= '0') and (s[i] <= '9') then
            res := res * 10 + integer(s[i]) - 48
        else begin
            isSucceed := false;
            exit
        end
    end;
    if dotPos <> -1 then begin
        for i := dotPos + 1 to Length(s) do begin
            if (s[i] >= '0') and (s[i] <= '9') then begin
                res := res + (integer(s[i]) - 48) / Pow(10, exp);
                exp := exp + 1
            end
            else begin
                isSucceed := false;
                exit
            end 
        end
    end;
    if isNegative then
        StrToReal := (-1) * res
    else
        StrToReal := res;
    isSucceed := true
end;
function StrToInteger(s: string; var isSucceed: boolean): integer;
var
    isNegative: boolean;
    i, pos, res: integer;
begin
    if (Length(s) < 1) or ((Length(s) = 1) and (s[1] = '-')) then begin
        isSucceed := false;
        exit
    end;
    res := 0;
    if s[1] = '-' then begin
        isNegative := true;
        pos := 2
    end
    else begin
        isNegative := false;
        pos := 1
    end;
    for i := pos to Length(s) do begin
        if (s[i] >= '0') and (s[i] <= '9') then
            res := res * 10 + integer(s[i]) - 48
        else begin
            isSucceed := false;
            exit
        end
    end;
    if isNegative then
        StrToInteger := (-1) * res
    else
        StrToInteger := res;
    isSucceed := true
end;