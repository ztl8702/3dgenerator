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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Unit1;

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
end;

procedure TForm2.Timer1Timer(Sender: TObject);
begin
  Form2.Image1.Hide;
  Form2.Button1.Enabled:=False;
  Form2.Button2.Enabled:=False;
  form2.ProgressBar1.Show;
  form2.Label1.Show;
  Form2.Image1.Picture.Bitmap.Create;
  Form2.Image1.Picture.Bitmap.Height:=Form1.ImageLeft.Picture.Bitmap.Height;
  Form2.Image1.Picture.Bitmap.width:=Form1.ImageLeft.Picture.Bitmap.width;
  if Form1.RadioButton1.Checked then
    Form1.pulsBitmap(Form1.ImageLeft.Picture.Bitmap,Form1.ImageRight.Picture.Bitmap)
  else
    Form1.pulsBitmapg(Form1.ImageLeft.Picture.Bitmap,Form1.ImageRight.Picture.Bitmap);
  Form2.Image1.show;
  form2.ProgressBar1.hide;
  form2.Label1.hide;
  Form2.Button1.Enabled:=true;
  Form2.Button2.Enabled:=true;
  Timer1.Enabled:=False;
end;

end.
