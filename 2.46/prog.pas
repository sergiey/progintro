program task_2_46;
var
    line1: string = 'Humpty Dumpty sat on a wall';
    line2: string = 'Humpty Dumpty had a great fall';
    line3: string = 'All the king''s horses and all the king''s men';
    line4: string = 'Couldn''t put Humpty together again';
    lyric: text;
begin
    if  ParamCount < 1 then begin
        writeln('No file path');
        halt(1)
    end;
    assign(lyric, ParamStr(1));
    rewrite(lyric);
    writeln(lyric, line1);
    writeln(lyric, line2);
    writeln(lyric, line3);
    writeln(lyric, line4);
    close(lyric)
end.