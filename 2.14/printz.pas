program space_diamond;

procedure PrintChars(character: char; count: integer);
var
    i: integer;
begin
    for i := 1 to count do
        write(character)
end;

procedure PrintPlank(height: integer);
begin
    PrintChars('*', height);
    writeln
end;

procedure PrintMiddle(height, line: integer);
begin
    PrintChars(' ', height - line - 1);
    write('*');
    PrintChars(' ', line);
    writeln
end;

var
    height, i: integer;
begin
    repeat
        writeln('Enter space diamond height (must be odd and more than 5)');
        read(height);
    until (height > 5) and (height mod 2 = 1);
    PrintPlank(height);
    for i := 1 to (height - 3) div 2 do
        PrintMiddle(height, i);
    PrintPlank(height);
    for i := ((height - 3) div 2) + 1  to height - 3 do
        PrintMiddle(height, i);
    PrintPlank(height);
end.