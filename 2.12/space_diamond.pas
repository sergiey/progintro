program space_diamond;

procedure PrintChars(character: char; count: integer);
var
    i: integer;
begin
    for i := 1 to count do
        write(character)
end;

procedure PrintDiamondsHalf(line, height: integer; character: char);
begin
    if line = 0 then begin
        PrintChars('*', 2 * height - 3);
        writeln;
        exit
    end;
    PrintChars('*', height - 1 - line);
    PrintChars(character, 2 * line - 1);
    PrintChars('*', height - 1 - line);
    writeln
end;

var
    height, i: integer;
    character: char;
begin
    repeat
        writeln('Enter space diamond height (must be odd and more than 3)');
        read(height);
    until (height > 3) and (height mod 2 = 1);
    character := ' ';
    for i := 0 to (height - 1) div 2 + 1 do
        PrintDiamondsHalf(i, height, character);
    for i := (height - 1) div 2 downto 0 do
        PrintDiamondsHalf(i, height, character)
end.