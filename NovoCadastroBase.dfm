object frmNovoCadastroBase: TfrmNovoCadastroBase
  Left = 0
  Top = 0
  Caption = 'frmNovoCadastroBase'
  ClientHeight = 152
  ClientWidth = 586
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object panPrincipal: TPanel
    Left = 0
    Top = 0
    Width = 585
    Height = 113
    TabOrder = 0
    object labCodigo: TLabel
      Left = 8
      Top = 8
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object labDescricao: TLabel
      Left = 120
      Top = 8
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object labCampo3: TLabel
      Left = 8
      Top = 43
      Width = 39
      Height = 13
      Caption = 'Campo3'
    end
    object labCampo4: TLabel
      Left = 8
      Top = 78
      Width = 39
      Height = 13
      Caption = 'Campo4'
    end
    object edtCodigo: TDBEdit
      Left = 53
      Top = 5
      Width = 58
      Height = 21
      TabOrder = 0
    end
    object edtDescricao: TDBEdit
      Left = 172
      Top = 5
      Width = 405
      Height = 21
      TabOrder = 1
    end
    object DBEdit1: TDBEdit
      Left = 53
      Top = 40
      Width = 121
      Height = 21
      TabOrder = 2
    end
    object edtCampo4: TDBEdit
      Left = 53
      Top = 75
      Width = 121
      Height = 21
      TabOrder = 3
    end
  end
  object btnOk: TButton
    Left = 422
    Top = 119
    Width = 75
    Height = 25
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancelar: TButton
    Left = 503
    Top = 119
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 2
    OnClick = btnCancelarClick
  end
end
