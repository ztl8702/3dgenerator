unit UnitT;

interface

uses
  Classes,Windows,Graphics,SysUtils,Dialogs;

type
  TThreadPic = class(TThread)
  private
    { Private declarations }
    var x1,y1,x2,y2,id,i,j:integer;  tt:TColor;  per:integer;
  protected
    procedure plusBitmap(lb,rb:Tbitmap);
    procedure plusBitmapg(lb,rb:Tbitmap);
  public
    procedure Execute; override;
    constructor Create(infoid:integer);
    procedure ont(sender:tobject);
    procedure incok;
    procedure drawbar;
    var bmp:TBitmap;
  end;

implementation
  uses Unit1,Unit2;

{ TThreadPic }

procedure TThreadPic.ont(sender:tobject);
begin

end;
procedure TThreadPic.incok;
begin
  Inc(okcount);
  BitBlt(Form2.Image1.Canvas.Handle, x1,y1, x2-x1+1,y2-y1+1, bmp.Canvas.Handle, x1, y1, SRCcopy);
end;

constructor TThreadPic.Create(infoid:integer);
begin
  FreeOnTerminate:=True;
  //OnTerminate:=ont;
  id:=infoid;
  x1:=PRI[id].fx;
  y1:=PRI[id].fy;
  x2:=PRI[id].ex;
  y2:=PRI[id].ey;
  inherited Create(True);
end;

procedure TThreadPic.drawbar();
begin
  form2.ProgressBar1.Position:=per;
end;


procedure TThreadPic.plusBitmap(lb,rb:Tbitmap);
 var i,j:integer;
 r2,g1,b1:byte;
 Row1:PByteArray;
 Row2:PByteArray;
begin
    for i := y1 to y2 do
      begin
        Row1:=lb.ScanLine[i];
        Row2:=rb.ScanLine[i];
        for j := x1 to x2 do
        begin
          r2 := Row2[j*3+2];
          g1 := Row1[j*3+1];//GetGValue(lb.Canvas.Pixels[i,j]);
          b1 := Row1[j*3+0];//GetBValue(lb.Canvas.Pixels[i,j]);  //  OutputDebugString(PChar('s'));
          bmp.Canvas.Pixels[j,i]:=rgb(r2,g1,b1);
        end;
        per:=integer(trunc(((i-y1+1)/(y1-y2+1))*100));
      end;
end;
procedure TThreadPic.plusBitmapg(lb,rb:Tbitmap);
 var i,j:integer;
 r2,g1,b2:byte;
 Row1:PByteArray;
 Row2:PByteArray;
begin
    for i := y1 to y2 do
      begin
        Row1:=lb.ScanLine[i];
        Row2:=rb.ScanLine[i];
        for j := x1 to x2 do
        begin
          r2 := Row2[j*3+2];
          g1 := Row1[j*3+1];//GetGValue(lb.Canvas.Pixels[i,j]);
          b2 := Row2[j*3+0];//GetBValue(lb.Canvas.Pixels[i,j]);  //  OutputDebugString(PChar('s'));
          bmp.Canvas.Pixels[j,i]:=rgb(r2,g1,b2);
        end;
        per:=integer(trunc(((i-y1+1)/(y1-y2+1))*100));
      end;
end;

procedure TThreadPic.Execute;
begin
  { Place thread code here }
  //OutputDebugString(PChar('START!!!'+IntToStr(id)+'('+IntToStr(x1)+','+IntToStr(x2)+')'));
  if Form1.RadioButton1.Checked then
    plusBitmap(Form1.ImageLeft.Picture.Bitmap,Form1.ImageRight.Picture.Bitmap)
  else
    plusBitmapg(Form1.ImageLeft.Picture.Bitmap,Form1.ImageRight.Picture.Bitmap);
  //plusBitmap(Form1.ImageLeft.Picture.Bitmap,Form1.ImageRight.Picture.Bitmap);
  PRI[id].isok:=True;
  OutputDebugString(PChar('FINISH!!!'+IntToStr(id)));
  Synchronize(incok);
end;

end.
