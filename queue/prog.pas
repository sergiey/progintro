program queue_implementation;
procedure CheckIO(message: string);
begin
    if IOResult <> 0 then 
    begin
        writeln(message);
        halt(1)
    end
end;
type
    queueptr = ^queue;
    queue = record
        data: integer;
        next: queueptr
    end;
var
    first, rec: queueptr;
begin
    {$I-}
    first := nil;
    while not seekeof do 
    begin
        if first = nil then 
        begin
            new(rec);
            first := rec;
            read(rec^.data);
            CheckIO('Couldn''t read number');
            rec^.next := nil
        end
        else 
        begin
            new(rec^.next);
            rec :=rec^.next;
            read(rec^.data);
            CheckIO('Couldn''t read number');
            rec^.next := nil
        end
    end;
    rec := first;
    while not (rec = nil) do
    begin
        writeln(rec^.data);
        CheckIO('Couldn''t write number');
        writeln(rec^.data);
        CheckIO('Couldn''t write number');
        rec := rec^.next
    end
end.