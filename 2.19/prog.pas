program task_2_19;

function IsLetterOrDigit(n: char): boolean;
begin
    IsLetterOrDigit := ((n > 'a') and (n < 'z')) or ((n > 'A') and (n < 'Z')) or
        ((n > '0') and (n < '9'))
end;

procedure WordsInString(var n: char; var words: integer;
    var wordIsTaken: boolean);

begin
    if IsLetterOrDigit(n) and not wordIsTaken then begin
        words := words + 1;
        wordIsTaken := true
    end;
    if (n = #9) or (n = #32) then
        wordIsTaken := false;
end;

var
    n: char;
    words: integer = 0;
    wordIsTaken: boolean = false;
begin
    {$I-}
    while not eoln do begin
        read(n);
        if IOResult <> 0 then begin
            writeln(ErrOutput, 'Couldn''t read symbol');
            halt(1)
        end;
        WordsInString(n, words, wordIsTaken);     
    end;
    writeln('Words in string: ', words)
end.