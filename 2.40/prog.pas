program task_2_40;
type
    dllistptr = ^dllist;
    dllist = record
        data: longint;
        prev, next: dllistptr
    end;
    DLListOfLongints = record
        first, last: dllistptr
    end;
procedure DLLOfLongintInin(var dllist: DLListOfLongints);
begin
    dllist.first := nil;
    dllist.last := nil
end;
procedure DLLOfLongintInsertFront(n: longint; var dllist: DLListOfLongints);
begin
    if dllist.last = nil then begin
        new(dllist.first);
        dllist.first^.data := n;
        dllist.first^.next := nil;
        dllist.first^.prev := nil;
        dllist.last := dllist.first
    end
    else begin
        new(dllist.last^.next);
        dllist.last^.next^.data := n;
        dllist.last^.next^.next := nil;
        dllist.last^.next^.prev := dllist.last;
        dllist.last := dllist.last^.next
    end
end;
procedure DLOfLongintDelNode(node: dllistptr; var dllist: DLListOfLongints);
begin
    if (dllist.first <> nil) and (dllist.first = dllist.last) then begin
        dllist.first := nil;
        dllist.last := nil
    end
    else if node = dllist.first then begin
        node^.next^.prev := nil;
        dllist.first := node^.next
    end
    else if node = dllist.last then begin
        node^.prev^.next := nil;
        dllist.last := node^.prev
    end
    else begin
        node^.next^.prev := node^.prev;
        node^.prev^.next := node^.next
    end;
    dispose(node)
end;
var
    list: DLListOfLongints;
    tmp: dllistptr;
    pp: ^dllistptr;
    n: longint;
    counter: integer;
begin
    {$I-}
    DLLOfLongintInin(list);
    while not seekeof do begin
        read(n);
        if IOResult <> 0 then begin
            writeln(ErrOutput, 'Couldn''t read a number');
            halt(1)
        end;
        DLLOfLongintInsertFront(n, list)
    end;
    writeln; 
    pp := @(list.first);
    while (list.first <> list.last) do begin
        pp := @(list.first);
        n := pp^^.data;
        counter := 0;
        while pp^ <> nil do begin
            if pp^^.data = n then begin
                counter := counter + 1;
                tmp := pp^;
                pp := @(pp^^.next);
                DLOfLongintDelNode(tmp, list)
            end
            else
                pp := @(pp^^.next)
        end;
        if counter = 3 then
            write(n, ' ')
    end;
    writeln
end.