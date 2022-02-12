program diamond;
var
    n, i, j, k, s: integer;
begin
    { Set diamond size }
    n := 7;

    { Print top part }
    for i := 1 to (n - 1) div 2 do
        write(' ');
    writeln('*');
    k := 1;
    s := 0;
    for i := 1 to (n - 1) div 2 do
        begin
        for j := 1 to (n - 1) div 2 - k do
            write(' ');
        write('*');
        for j := 1 to (s + 1) do
            write(' ');
        writeln('*');
        s := s + 2;
        k := k + 1
        end;
        
    { Print bottom part }    
    k := k - 2;
    s := s - 4;
    for i := 1 to (n - 1) div 2 - 1 do
        begin
        for j := (n - 1) div 2 - k downto 1 do
            write(' ');
        write('*');
        for j := (s + 1) downto 1 do
            write(' ');
        writeln('*');
        s := s - 2;
        k := k - 1
        end;
    for i := 1 to (n - 1) div 2 do
        write(' ');
    writeln('*')
end.