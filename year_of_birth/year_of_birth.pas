program year_of_birth;
var
    year: integer;
begin
    writeln('Write your year of birth, please ');
    readln(year);
    while (year < 1900) or (year > 2020) do
    begin
        writeln('Incorrect. Write year of your birth again');
        readln(year);
    end;
    writeln('Your age is ', 2022 - year)
end.