object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 548
  ClientWidth = 865
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnResize = FormResize
  DesignSize = (
    865
    548)
  PixelsPerInch = 96
  TextHeight = 13
  object imgSource: TImage
    Left = 8
    Top = 47
    Width = 401
    Height = 494
    Anchors = [akLeft, akTop, akBottom]
    Proportional = True
    Stretch = True
    ExplicitHeight = 444
  end
  object imgDest: TImage
    Left = 418
    Top = 46
    Width = 439
    Height = 494
    Anchors = [akLeft, akTop, akRight, akBottom]
    Proportional = True
    Stretch = True
    ExplicitWidth = 403
    ExplicitHeight = 444
  end
  object Button1: TButton
    Left = 8
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
end
