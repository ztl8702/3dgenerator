unit UnitS;

interface

uses
    Classes,Windows,Graphics,SysUtils;

type
  TThreadS = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
    procedure Run;
  end;
  var isok:Boolean;
implementation
  uses unitT,Unit1,Unit2;

{ TThreadS }

procedure TThreadS.Run;
   var myt:TThreadPic;  w,h:integer;
begin
    isok:=False;
     myt:=TThreadPic.Create(1,1,w,h);
    //Copy Pic
    while not(isok) do  begin end;

end;
procedure TThreadS.Execute;
begin
  { Place thread code here }
  Run;
end;

end.
