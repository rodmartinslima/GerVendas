inherited frmNovoCadastroCliente: TfrmNovoCadastroCliente
  Caption = 'Novo Cadastro Cliente'
  ClientHeight = 176
  ClientWidth = 583
  Position = poDesktopCenter
  ExplicitWidth = 599
  ExplicitHeight = 215
  PixelsPerInch = 96
  TextHeight = 13
  inherited panPrincipal: TPanel
    Height = 140
    ExplicitHeight = 140
    inherited labCodigo: TLabel
      Left = 38
      Top = 11
      ExplicitLeft = 38
      ExplicitTop = 11
    end
    inherited labDescricao: TLabel
      Left = 138
      Top = 11
      Width = 27
      Caption = 'Nome'
      ExplicitLeft = 138
      ExplicitTop = 11
      ExplicitWidth = 27
    end
    inherited labCampo3: TLabel
      Left = 18
      Width = 55
      Caption = 'Logradouro'
      ExplicitLeft = 18
      ExplicitWidth = 55
    end
    inherited labCampo4: TLabel
      Left = 45
      Width = 28
      Caption = 'Bairro'
      ExplicitLeft = 45
      ExplicitWidth = 28
    end
    object labNumero: TLabel [4]
      Left = 490
      Top = 43
      Width = 37
      Height = 13
      Caption = 'N'#250'mero'
    end
    object labCidade: TLabel [5]
      Left = 273
      Top = 78
      Width = 33
      Height = 13
      Caption = 'Cidade'
    end
    object labUF: TLabel [6]
      Left = 60
      Top = 110
      Width = 13
      Height = 13
      Caption = 'UF'
    end
    object labDtNascimento: TLabel [7]
      Left = 210
      Top = 110
      Width = 96
      Height = 13
      Caption = 'Data de Nascimento'
    end
    inherited edtCodigo: TDBEdit
      Left = 79
      Top = 8
      Width = 46
      Color = clInactiveCaption
      DataField = 'IDCLI'
      ReadOnly = True
      ExplicitLeft = 79
      ExplicitTop = 8
      ExplicitWidth = 46
    end
    inherited edtDescricao: TDBEdit
      Top = 8
      Width = 401
      DataField = 'NOME'
      ExplicitTop = 8
      ExplicitWidth = 401
    end
    inherited DBEdit1: TDBEdit
      Left = 79
      Width = 400
      DataField = 'LOGRADOURO'
      ExplicitLeft = 79
      ExplicitWidth = 400
    end
    inherited edtCampo4: TDBEdit
      Left = 79
      DataField = 'BAIRRO'
      TabOrder = 4
      ExplicitLeft = 79
    end
    object edtNumero: TDBEdit
      Left = 531
      Top = 40
      Width = 42
      Height = 21
      DataField = 'NUMERO'
      TabOrder = 3
    end
    object edtCidade: TDBEdit
      Left = 315
      Top = 75
      Width = 144
      Height = 21
      DataField = 'CIDADE'
      TabOrder = 5
    end
    object cbxUF: TDBComboBox
      Left = 79
      Top = 107
      Width = 121
      Height = 21
      DataField = 'UF'
      Items.Strings = (
        'AC'
        'AL'
        'AP'
        'AM'
        'BA'
        'CE'
        'DF'
        'ES'
        'GO'
        'MA'
        'MT'
        'MS'
        'MG'
        'PA'
        'PB'
        'PR'
        'PE'
        'PI'
        'RJ'
        'RN'
        'RS'
        'RO'
        'RR'
        'SC'
        'SP'
        'SE'
        'TO')
      TabOrder = 6
    end
    object edtDataNasc: TDateTimePicker
      Left = 315
      Top = 107
      Width = 144
      Height = 21
      Date = 45062.872531724530000000
      Time = 45062.872531724530000000
      TabOrder = 7
    end
  end
  inherited btnOk: TButton
    Top = 146
    ExplicitTop = 146
  end
  inherited btnCancelar: TButton
    Top = 146
    ExplicitTop = 146
  end
end
