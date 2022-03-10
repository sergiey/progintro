program task_2_41;
type
    lilitemptr = ^lilitem;
    lilitem = record
        data: longint;
        counter: integer;
        next: lilitemptr
    end;
    LongintList = record
        first: lilitemptr;
        last: lilitemptr
    end;
procedure LongintListInit(var list: LongintList);
begin
    list.first := nil;
    list.last := nil
end;
procedure FindMaxCount(var maxCount: integer; list: LongintList);
var
    pp: ^lilitemptr;
begin
    pp := @(list.first);
    maxCount := 0;
    while pp^ <> nil do begin
        if pp^^.counter > maxCount then
            maxCount := pp^^.counter;
        pp := @(pp^^.next)
    end
end;
procedure PrintMaxCountItem(maxCount: integer; list: LongintList);
var
    pp: ^lilitemptr;    
begin
    pp := @(list.first);
    while pp^ <> nil do begin
        if pp^^.counter = maxCount then
            write(pp^^.data, ' ');
        pp := @(pp^^.next)
    end
end;
procedure LongintListPut(n: longint; var list: LongintList);
var
    pp: ^lilitemptr;
begin
    if list.first = nil then begin
        new(list.first);
        list.first^.data := n;
        list.first^.counter := 1;
        list.first^.next := nil;
        list.last := list.first
    end
    else begin
        pp := @(list.first);
        while pp^ <> nil do begin
            if pp^^.data = n then begin
                pp^^.counter := pp^^.counter + 1;
                exit
            end 
            else
                pp := @(pp^^.next)
        end;
        new(pp^);
        pp^^.data := n;
        pp^^.counter := 1;
        pp^^.next := nil;
        list.last := pp^^.next
    end
end;
var
    n: longint;
    list: LongintList;
    maxCount: integer;
begin
    {$I-}
    LongintListInit(list);
    while not seekeof do begin
        read(n);
        if IOResult <> 0 then begin
            writeln(ErrOutput, 'Couldn''t read number');
            halt(1)
        end;
        LongintListPut(n, list)
    end;
    FindMaxCount(maxCount, list);
    PrintMaxCountItem(maxCount, list);
    writeln
end.