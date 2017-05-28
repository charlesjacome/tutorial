object Form1: TForm1
  Left = 271
  Top = 114
  Caption = 'Form1'
  ClientHeight = 377
  ClientWidth = 456
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 48
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object ButtonStart: TButton
    Left = 24
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = ButtonStartClick
  end
  object ButtonStop: TButton
    Left = 105
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 1
    OnClick = ButtonStopClick
  end
  object EditPort: TEdit
    Left = 24
    Top = 67
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '8080'
  end
  object ButtonOpenBrowser: TButton
    Left = 24
    Top = 112
    Width = 107
    Height = 25
    Caption = 'Open Browser'
    TabOrder = 3
    OnClick = ButtonOpenBrowserClick
  end
  object edt_token_id: TEdit
    Left = 24
    Top = 192
    Width = 193
    Height = 21
    TabOrder = 4
    Text = 'edt_token_id'
  end
  object btn_enviar_mensagem: TButton
    Left = 24
    Top = 280
    Width = 177
    Height = 25
    Caption = 'btn_enviar_mensagem'
    TabOrder = 5
    OnClick = btn_enviar_mensagemClick
  end
  object Edit_latidude: TEdit
    Left = 24
    Top = 216
    Width = 121
    Height = 21
    TabOrder = 6
    Text = 'Edit_latidude'
  end
  object Edit_longitude: TEdit
    Left = 24
    Top = 243
    Width = 121
    Height = 21
    TabOrder = 7
    Text = 'Edit_longitude'
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 288
    Top = 24
  end
end
