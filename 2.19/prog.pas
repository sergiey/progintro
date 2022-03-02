program task_2_19;

function IsLetterOrDigit(n: char): boolean;
begin
    IsLetterOrDigit := ((n > 'a') and (n < 'z')) or ((n > 'A') and (n < 'Z')) or
        ((n > '0') and (n < '9'))
end;

function IsWordBegan(n: char; wordGoesOn: boolean): boolean;
begin
    IsWordBegan := IsLetterOrDigit(n) and not wordGoesOn
end;

function IsWordEnded(n: char; wordGoesOn: boolean): boolean;
begin
    IsWordEnded := ((n = ' ') or (n = #9)) and wordGoesOn
end;

procedure CountSymbolsInWord(wordGoesOn: boolean; var symbols: byte);
begin
    if wordGoesOn then
        symbols := symbols + 1
end;

procedure SwitchWordGoesOn(n: char; var wordGoesOn: boolean);
begin
    if IsWordBegan(n, wordGoesOn) then
        wordGoesOn := true
    else if IsWordEnded(n, wordGoesOn) then begin
        wordGoesOn := false
    end
end;

procedure CountWordsInStringInString(n: char; var wordsInString: integer;
    wordGoesOn: boolean);
begin
    if IsWordBegan(n, wordGoesOn) then
        wordsInString := wordsInString + 1
end;

procedure CountCharactersInWord(n: char; wordGoesOn: boolean;
    var chars: integer);
begin
    if wordGoesOn then
        chars := chars + 1
    else
        chars := 0
end;

procedure CountEvenAndOddWords(wordGoesOn: boolean; var charsCounter: integer;
    var wordsWithEvenChars: integer; var wordsWithOddChars: integer);
begin
    if wordGoesOn then begin
        if charsCounter = 1 then begin
            wordsWithOddChars := wordsWithOddChars + 1;
            charsCounter := charsCounter + 1
        end
        else if (charsCounter mod 2) = 0 then begin
            wordsWithEvenChars := wordsWithEvenChars + 1;
            wordsWithOddChars := wordsWithOddChars - 1;
            charsCounter := charsCounter + 1
        end
        else if (charsCounter mod 2) <> 0 then begin
            wordsWithEvenChars := wordsWithEvenChars - 1;
            wordsWithOddChars := wordsWithOddChars + 1;
            charsCounter := charsCounter + 1
        end
    end;
    if not wordGoesOn then begin
        charsCounter := 1;
    end
end;

var
    n: char;
    wordGoesOn: boolean = false;
    wordsInString: integer = 0;
    charsInWord: integer = 0;
    charsCounter: integer = 1;
    wordsWithEvenChars: integer = 0;
    wordsWithOddChars: integer = 0;
begin
    {$I-}
    while not eoln do begin
        read(n);
        if IOResult <> 0 then begin
            writeln(ErrOutput, 'Couldn''t read symbol');
            halt(1)
        end;
        CountWordsInStringInString(n, wordsInString, wordGoesOn);
        SwitchWordGoesOn(n, wordGoesOn);
        CountCharactersInWord(n, wordGoesOn, charsInWord);
        CountEvenAndOddWords(wordGoesOn, charsCounter, wordsWithEvenChars,
            wordsWithOddChars);
    end;
    writeln('a) Words in string: ', wordsInString);
    writeln('b) Words with even amount of charcters: ',wordsWithEvenChars);
    writeln('   Words with odd amount of charcters: ',wordsWithOddChars)
end.