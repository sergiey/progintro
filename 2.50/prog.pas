program task_2_50;
uses math;
{$I ../StringToNumber/StringToNumber.pas}
procedure ReadAngle(strNum: string; var realNum: real);
var
    isSucceed: boolean;
begin
    realNum := StrToReal(strNum, isSucceed);
    if not isSucceed then begin
        writeln(ErrOutput, 'Couldn''t convert parameter ', strNum, ' to real');
        halt(1)
    end;
    if (realNum < 0) or (realNum > 360) then begin
        writeln(ErrOutput, 'Angle must be between 0 and 360 degrees');
        halt(1)
    end
end;
var
    f: text;
    startAngle, endAngle, step: real;
begin
    {$I-}
    if ParamCount < 4 then begin
        writeln(ErrOutput, 'Not enough parameters. Must be four');
        halt(1)
    end;
    ReadAngle(ParamStr(2), startAngle);
    ReadAngle(ParamStr(3), endAngle);
    ReadAngle(ParamStr(4), step);
    assign(f, ParamStr(1));
    rewrite(f);
    writeln(f, 'sin | cos | tan | ctan | angle');
    writeln(f, '------------------------------');
    while startAngle <= endAngle do begin
        write(f, sin(startAngle * pi / 180):1:1);
        write(f, '   ');
        write(f, cos(startAngle * pi / 180):1:1);
        write(f, '   ');
        if (startAngle = 90) or (startAngle = 270) then
            write(f, ' -- ')
        else
            write(f, tan(startAngle * pi / 180):1:1);
        write(f, '   ');
        if (startAngle = 0) or (startAngle = 180) or (startAngle = 360) then
            write(f, ' -- ')
        else
            write(f, (1 / tan(startAngle * pi / 180)):1:1);
        write(f, '   ');
        writeln(f, startAngle:3:0);
        startAngle := startAngle + step
    end;
    close(f)
end.