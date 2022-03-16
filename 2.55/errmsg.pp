unit errmsg;
interface
procedure PrintErrorMsg(errorMsg, errorLoc: string);
procedure PrintErrorMsg(errorMsg: string);
implementation
procedure PrintErrorMsg(errorMsg, errorLoc: string);
begin
    writeln(ErrOutput, errorMsg, errorLoc);
    halt(1)
end;
procedure PrintErrorMsg(errorMsg: string);
begin
    writeln(ErrOutput, errorMsg);
    halt(1)
end;
end.