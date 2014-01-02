object Form2: TForm2
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = #29983#25104'3D'#22270#20687
  ClientHeight = 402
  ClientWidth = 489
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 144
    Top = 136
    Width = 132
    Height = 13
    Caption = #27491#22312#29983#25104#22270#20687#65292#35831#31245#20505'...'
  end
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 489
    Height = 376
    Align = alClient
    Center = True
    Proportional = True
    Visible = False
    ExplicitLeft = 103
    ExplicitWidth = 376
    ExplicitHeight = 384
  end
  object Panel1: TPanel
    Left = 0
    Top = 376
    Width = 489
    Height = 26
    Align = alBottom
    TabOrder = 0
    object Button1: TButton
      Left = 412
      Top = 0
      Width = 75
      Height = 25
      Caption = #20851#38381
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 331
      Top = 0
      Width = 75
      Height = 25
      Caption = #20445#23384
      TabOrder = 1
      OnClick = Button2Click
    end
    object ProgressBar1: TProgressBar
      Left = 1
      Top = 1
      Width = 324
      Height = 24
      Align = alLeft
      TabOrder = 2
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 448
    Top = 344
  end
end
