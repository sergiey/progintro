program make_numbers;
var
    counter: integer = 1;
    number: longint = 1000;
begin
    while counter < 101 do
    begin 
        writeln(number);
        counter := counter + 1;
        number := number + 1001
    end
end.