unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes,Graphics, JPEG, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, GIFImg, Menus;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    F1: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    GroupBoxLeft: TGroupBox;
    ImageLeft: TImage;
    GroupBoxRight: TGroupBox;
    ImageRight: TImage;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    N1: TMenuItem;
    O1: TMenuItem;
    N3: TMenuItem;
    N2: TMenuItem;
    A1: TMenuItem;
    Button1: TButton;
    RadioGroup1: TRadioGroup;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    img1: TImage;
    img2: TImage;
    procedure pulsBitmap(lb,rb:Tbitmap);
    procedure pulsBitmapg(lb,rb:Tbitmap);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure loadJpg();
    procedure O1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure A1Click(Sender: TObject);
  private

  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  pic1,pic2:string;
implementation

uses Unit2;

{$R *.dfm}
procedure TForm1.A1Click(Sender: TObject);
begin
  ShowMessage('  三维立体图像快速合成软件'+#13+#13+'福州第十八中学 八年七班 郑天镭');
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if ImageLeft.Picture.Bitmap.Height=0 then
   begin
    showmessage('您还没有导入图片。');
    Exit;
   end;
  Form2:=TForm2.Create(form1);
  Form2.ShowModal;
  {ChangeBitmapColor(ImageLeft.Picture.Bitmap,1);
  ChangeBitmapColor(ImageRight.Picture.Bitmap,2);
  image3.Picture.Create;       }
 // image3.Picture.bitmap.Height:= Image2.Picture.Bitmap.Height;
  //image3.Picture.bitmap.width:= Image2.Picture.Bitmap.width;
  //pulsBitmap(Image1.Picture.Bitmap,Image2.Picture.Bitmap);
end;
procedure TForm1.LoadJpg();
var jpg1,jpg2: TJpegImage;
 //  Bmp: TBitmap;
begin
  OpenDialog1.Title:='打开左图';
   IF (openDialog1.Execute) then
    pic1:=OpenDialog1.FileName;
  OpenDialog1.Title:='打开右图';
   IF openDialog1.Execute then
    pic2:=OpenDialog1.FileName;
  if (not(FileExists(pic1)))or(not(FileExists(pic2))) then
    begin
      ShowMessage('文件不存在');
      exit;
    end;
   
 jpg1 := TJPEGImage.Create;
 jpg2 := TJPEGImage.Create;
 //Bmp := TBitmap.Create;
 try
  jpg1.LoadFromFile(pic1);
  jpg2.LoadFromFile(pic2);
  if (jpg1.Height<>jpg2.Height)or(jpg1.width<>jpg2.width) then
    begin
      ShowMessage('照片的尺寸必须一致！');       Exit;
    end;
  imageleft.Picture.bitmap.Create;
  imageright.Picture.bitmap.Create;
  imageleft.picture.bitmap.Assign(jpg1);
  imageright.picture.bitmap.Assign(jpg2);
 finally
 jpg1.Free;
 jpg2.Free;
 end;
end;

procedure TForm1.N1Click(Sender: TObject);
begin
  pic1:='';
  pic2:='';
  ImageLeft.Picture.bitmap:=nil;
  Imageright.Picture.bitmap:=nil;
  ImageLeft.Refresh;
  ImageRight.Refresh;
end;

procedure TForm1.N3Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.O1Click(Sender: TObject);
begin
  loadJpg;
end;

procedure Tform1.pulsBitmap(lb,rb:Tbitmap);
 var i, j, r2,g1,b1, w, h:integer;
  BitmapCanvas:TBitmap;
begin
  //ss
  BitmapCanvas := TBitmap.Create;
  try
    BitmapCanvas.PixelFormat := pf24Bit;
    w := lb.Width;
    h := lb.Height;
    BitmapCanvas.width := w;
    BitmapCanvas.Height := h;
    for i:=1 to w do
      begin //合并图像
        for j:=1 to h do
        begin
          r2 := GetRValue(rb.Canvas.Pixels[i,j]);
          g1 := GetGValue(lb.Canvas.Pixels[i,j]);
          b1 := GetBValue(lb.Canvas.Pixels[i,j]);
          BitmapCanvas.Canvas.Pixels[i,j]:=rgb(r2,g1,b1);
        end;
        form2.ProgressBar1.Position:=trunc((i/w)*100);
      end;
   // abitmap:=bitmapcanvas;
    BitBlt(Form2.Image1.Canvas.Handle, 0, 0, w, h, BitmapCanvas.Canvas.Handle, 0, 0, SRCcopy);
    Form2.Image1.Refresh;
   //image1.Canvas.Draw(0,0,bitmapcanvas);
  finally
    BitmapCanvas.Free;
  end;
end;

procedure Tform1.pulsBitmapg(lb,rb:Tbitmap);
 var i, j, r2,g1,b2, w, h:integer;
  BitmapCanvas:TBitmap;
begin
  //ss
  BitmapCanvas := TBitmap.Create;
  try
    BitmapCanvas.PixelFormat := pf24Bit;
    w := lb.Width;
    h := lb.Height;
    BitmapCanvas.width := w;
    BitmapCanvas.Height := h;
    for i:=1 to w do
      begin //合并图像
        for j:=1 to h do
        begin
          r2 := GetRValue(rb.Canvas.Pixels[i,j]);
          g1 := GetGValue(lb.Canvas.Pixels[i,j]);
          b2 := GetBValue(rb.Canvas.Pixels[i,j]);
          BitmapCanvas.Canvas.Pixels[i,j]:=rgb(r2,g1,b2);
        end;
        form2.ProgressBar1.Position:=trunc((i/w)*100);
      end;
   // abitmap:=bitmapcanvas;
    BitBlt(Form2.Image1.Canvas.Handle, 0, 0, w, h, BitmapCanvas.Canvas.Handle, 0, 0, SRCcopy);
    Form2.Image1.Refresh;
   //image1.Canvas.Draw(0,0,bitmapcanvas);
  finally
    BitmapCanvas.Free;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 //   SaveBmpBack := TBitmap.Create;
//  SaveBmpBack.Assign(Image1.Picture.Bitmap);
  

end;

end.
