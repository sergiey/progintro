program task_2_42;
type
    dequeptr = ^deque;
    deque = record
        data: char;
        next: dequeptr
    end;
    DequeOfChar = record
        first: dequeptr;
        last: dequeptr;
        pos: dequeptr
    end;
    PutSides = (left, right, front);
procedure DOCInit(var deq: DequeOfChar);
begin
    deq.first := nil;
    deq.last := nil;
    deq.pos := nil
end;
procedure DOCNewItem(c: char;  var ptr: dequeptr);
begin
    new(ptr);
    ptr^.data := c;
    ptr^.next := nil
end;
procedure DOCClear(var deq: DequeOfChar);
var
    tmp: dequeptr;
begin
    while deq.first <> nil do begin
        tmp := deq.first;
        deq.first := deq.first^.next;
        dispose(tmp)
    end
end;
procedure DOCPut(c: char; var deq: DequeOfChar; side: PutSides);    
var
    tmp: dequeptr = nil;
begin
    if deq.first = nil then begin
        DOCNewItem(c, deq.first);
        deq.last := deq.first;
        deq.pos := deq.first        
    end
    else begin
        tmp := nil;
        DOCNewItem(c, tmp);
        case side of
            front: begin
                deq.last^.next := tmp;
                deq.last := tmp
            end;
            left: begin
                tmp^.next := deq.first;
                deq.first := tmp
            end;
            right: begin
                tmp^.next := deq.pos^.next;
                deq.pos^.next := tmp;
                deq.pos := tmp
            end
        end
    end
end;
var
    n: char;
    deq: DequeOfChar;
    isNewWord: boolean = false;
    isFirstWord: boolean = true;
    pp: ^dequeptr;
begin
    while not seekeof do begin
        DOCInit(deq);
        {$I-}
        while not eoln do begin
            read(n);
            if IOResult <> 0 then begin
                writeln(ErrOutput, 'Couldn''t read character');
                halt(1)
            end;
            if isFirstWord and ((n <> ' ') and (n <> #9)) then
                DOCPut(n, deq, front)
            else if (n = ' ') or (n = #9) then begin
                isFirstWord := false;
                isNewWord := true;
                deq.pos := deq.first;
                DOCPut(n, deq, left)
            end
            else if isNewWord then begin
                isNewWord := false;
                DOCPut(n, deq, left);
                deq.pos := deq.first
            end
            else
                DOCPut(n, deq, right)
        end;
        pp := @deq.first;
        while pp^ <> nil do begin
            write(pp^^.data);
            pp := @(pp^^.next)
        end;
        writeln;
        DOCClear(deq)
    end
end.