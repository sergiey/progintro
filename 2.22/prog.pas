program task_2_22;
procedure GetLongestParam(param: string; paramNumber: integer;
    var longestParamNumber: integer; var longestParamLength: integer);
begin
    if Length(param) > longestParamLength then begin
        longestParamNumber := paramNumber;
        longestParamLength := Length(param)
    end
end;
var
    i, longestParamNumber, longestParamLength: integer;
begin
    {$I-}
    if ParamCount < 1 then begin
        writeln(ErrOutput, 'No parameters entered. Pleas enter at least one');
        halt(1)
    end;
    longestParamNumber := 1;
    longestParamLength := 0;
    for i := 1 to ParamCount do begin
        GetLongestParam(ParamStr(i), i, longestParamNumber, longestParamLength)
    end;
    writeln('a) Longest parameter: ', ParamStr(longestParamNumber),
        ' - ', longestParamLength, ' character(s)')
end.