program diamond_proc;
procedure PrintSpaces(sp: integer);
var
    i: integer;
begin
    for i := 0 to sp - 1 do
        write(' ')
end;

procedure PrintLines(k, n: integer);
begin
    begin
        if k = 0 then begin
            PrintSpaces((n - 1) div 2);
            writeln('*')
        end
        else begin
            PrintSpaces((n - 1) div 2 - k);
            write('*');
            PrintSpaces(2 * k - 1);
            writeln('*')
        end
    end
end;

var
    n, i: integer;
begin
    { Set diamond size }
    repeat
        writeln('Enter diamond size (must be odd)');
        read(n);
    until (n > 0) and (n mod 2 = 1);

    { Print top part }
    for i := 0 to (n - 1) div 2 do
        PrintLines(i, n);    
    { Print bottom part }
    for i := ((n - 1) div 2 - 1) downto 0 do
        PrintLines(i, n)
end.