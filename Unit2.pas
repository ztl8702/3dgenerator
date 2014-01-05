unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, ExtCtrls, ComCtrls, StdCtrls,
  Controls,Graphics,jpeg, Forms,
  Dialogs;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Image1: TImage;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    ProgressBar1: TProgressBar;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure run();
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  PicInfo=record
    fx,fy,ex,ey:integer;
    isok:Boolean;
  end;
var
  Form2: TForm2;
  BitmapCanvas:TBitmap; isok:Boolean;
  Pri:array[1..9]of PicInfo; okCount:integer;
implementation

uses Unit1,UnitT;

{$R *.dfm}


procedure TForm2.Button1Click(Sender: TObject);
begin
  Timer1.Enabled:=False;
  Form2.Close;
end;

procedure TForm2.Button2Click(Sender: TObject);
 var jpg:Tjpegimage;
     filestr:string;
begin
   IF (Form1.saveDialog1.Execute) then
    filestr:=Form1.saveDialog1.FileName;
   if FileExists(filestr) then
     begin
       ShowMessage('文件已存在！');
     end
   else
     begin
       jpg := TJPEGImage.Create;
         try
             jpg.CompressionQuality := 100;
             jpg.Compress;
             jpg.Assign(Image1.Picture.Bitmap);
             if (LowerCase(ExtractFileExt(filestr))<>'.jpg')and(LowerCase(ExtractFileExt(filestr))<>'.jpeg') then filestr:=filestr+'.jpg';
             jpg.SaveToFile(filestr);
         finally
           jpg.Free;
         end;

     end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  Timer1.Enabled:=True;
 //run;
end;

procedure TForm2.run;
  var myt:array[1..9]of TThreadPic;  w,h,i,j:integer;
begin
  w:=Form1.ImageLeft.Picture.Bitmap.Width;
  h:=Form1.ImageLeft.Picture.Bitmap.Height;
  image1.Picture.Bitmap.PixelFormat:=pf24bit;
  image1.Picture.Bitmap.Width:=w;
  image1.Picture.Bitmap.Height:=h;
  //Calc
  for i := 1 to 9 do
  begin
    Pri[i].fx:=(i-1)*(w div 9);
    if (i<9) then
      Pri[i].ex:=i*(w div 9)-1
    else
      Pri[i].ex:=w-1;
    Pri[i].fy:=0;
    Pri[i].ey:=h-1;
    Pri[i].isok:=False;
  end;
  //end calc
  try
    //Run Thread

    for i:=1 to 9 do
    begin
       OutputDebugString(PChar('Create #'+IntToStr(i)));
       myt[i]:=TThreadPic.Create(i);
       myt[i].bmp:=TBitmap.Create;
       myt[i].bmp.PixelFormat:=pf24bit;
       myt[i].bmp.Width:=w;
       myt[i].bmp.Height:=h;
    end;
    for i := 1 to 9 do
    begin
      //while not ((i=1) or Pri[i-1].isok) do begin end;

      myt[i].Resume;
    end;
    //Copy Pic

    while not(Pri[1].isok and Pri[2].isok and Pri[3].isok
              and Pri[4].isok and Pri[5].isok and Pri[6].isok
              and Pri[7].isok and Pri[8].isok and Pri[9].isok) do begin end;
    image1.Refresh;
  finally
  end;

  Label1.hide;
  Image1.Show;

end;

procedure TForm2.Timer1Timer(Sender: TObject);
begin
  Form2.Image1.Hide;
  Form2.Button1.Enabled:=False;
  Form2.Button2.Enabled:=False;
  form2.ProgressBar1.Show;
  form2.Label1.Show;
  form2.run;
  Form2.Image1.show;
  form2.ProgressBar1.hide;
  form2.Label1.hide;
  Form2.Button1.Enabled:=true;
  Form2.Button2.Enabled:=true;
  Timer1.Enabled:=False;
end;

end.
