program task_2_17;
var
    i, j, num: integer;
begin
    write('   ');
    for i := 4 to 7 do write('0', i, '. ');
    for i := 10 to 17 do write(i, '. ');
    writeln;
    write('   ');
    for i := 0 to 46 do write('-');
    writeln;

    for i := 0 to 7 do begin
        num := i + 32;
        write('.', i, '|');
        for j := 1 to 12 do begin
            write(' ', chr(num), '  ');
            num := num + 8
        end;
        writeln
    end;
    writeln
end.
