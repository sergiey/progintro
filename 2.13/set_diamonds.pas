program set_diamonds;

procedure PrintChars(character: char; count: integer);
var
    i: integer;
begin
    for i := 1 to count do
        write(character)
end;

procedure PrintDiamondsHalf(line, height, number: integer);
begin
    if line = 0 then begin
        PrintChars(' ', (height - 1) div 2);
        write('*');
        PrintChars(' ', (height - 1) div 2 + 1);
        number := number - 1;
        if number > 0 then
            PrintDiamondsHalf(line, height, number)
        else
            writeln;
        exit
    end;

    PrintChars(' ', (height - 1) div 2 - line);
    write('*');
    PrintChars(' ', 2 * line - 1);
    write('*');
    PrintChars(' ', (height - 1) div 2 - line + 1);
        number := number - 1;
    if number > 0 then
        PrintDiamondsHalf(line, height, number)
    else
        writeln
end;

var
    height, number, i: integer;
begin
    repeat
        writeln('Enter diamonds height (must be odd and more than 3)');
        read(height);
    until (height > 3) and (height mod 2 = 1);
    repeat
        writeln('Enter number of diamonds');
        read(number);
    until number > 0;
    for i := 0 to (height - 1) div 2 do
        PrintDiamondsHalf(i, height, number); 
    for i := (height - 1) div 2 - 1 downto 0 do
        PrintDiamondsHalf(i, height, number)
end.