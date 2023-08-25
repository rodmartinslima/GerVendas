inherited frmFornecedores: TfrmFornecedores
  Caption = ''
  ClientHeight = 460
  ClientWidth = 850
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 866
  ExplicitHeight = 499
  PixelsPerInch = 96
  TextHeight = 13
  inherited panMenu: TPanel
    Width = 850
    ExplicitWidth = 850
    inherited labMsgPadrão: TLabel
      Left = 734
      ExplicitLeft = 734
    end
    inherited DBNavi: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited panPesquisa: TPanel
    Width = 850
    ExplicitWidth = 850
  end
  inherited panBackground: TPanel
    Width = 850
    Height = 335
    ExplicitWidth = 850
    ExplicitHeight = 335
    inherited dbgPrincipal: TDBGrid
      Width = 850
      Height = 335
      DataSource = DataSourceFornec
      Columns = <
        item
          Color = 10671092
          Expanded = False
          FieldName = 'IDFORNEC'
          ReadOnly = True
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOME'
          Width = 320
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'LOGRADOURO'
          Width = 250
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NUMERO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BAIRRO'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CIDADE'
          Width = 250
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UF'
          PickList.Strings = (
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
          Width = 25
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TELEFONE'
          Width = 120
          Visible = True
        end>
    end
  end
  inherited panRodape: TPanel
    Top = 420
    Width = 850
    ExplicitTop = 420
    ExplicitWidth = 850
    inherited btnSair: TButton
      Left = 743
      ExplicitLeft = 743
    end
  end
  object DataBaseFornec: TIBDatabase
    Connected = True
    DatabaseName = 'C:\GerVendas\BD\GERVENDAS.FDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey')
    LoginPrompt = False
    Left = 312
    Top = 368
  end
  object IBTransactionFornec: TIBTransaction
    DefaultDatabase = DataBaseFornec
    DefaultAction = TACommitRetaining
    Left = 392
    Top = 368
  end
  object TabFornecedores: TIBTable
    Database = DataBaseFornec
    Transaction = IBTransactionFornec
    AfterDelete = TabFornecedoresAfterDelete
    AfterEdit = TabFornecedoresAfterEdit
    AfterInsert = TabFornecedoresAfterInsert
    BeforeDelete = TabFornecedoresBeforeDelete
    BeforePost = TabFornecedoresBeforePost
    OnNewRecord = TabFornecedoresNewRecord
    FieldDefs = <
      item
        Name = 'IDFORNEC'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NOME'
        DataType = ftWideString
        Size = 200
      end
      item
        Name = 'LOGRADOURO'
        DataType = ftWideString
        Size = 150
      end
      item
        Name = 'NUMERO'
        DataType = ftInteger
      end
      item
        Name = 'BAIRRO'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'CIDADE'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'UF'
        DataType = ftWideString
        Size = 2
      end
      item
        Name = 'TELEFONE'
        DataType = ftWideString
        Size = 15
      end>
    IndexDefs = <
      item
        Name = 'PK_FORNECEDORES'
        Fields = 'IDFORNEC'
        Options = [ixUnique]
      end>
    StoreDefs = True
    TableName = 'FORNECEDORES'
    Left = 480
    Top = 368
    object TabFornecedoresIDFORNEC: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'IDFORNEC'
      Required = True
    end
    object TabFornecedoresNOME: TIBStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Size = 200
    end
    object TabFornecedoresLOGRADOURO: TIBStringField
      DisplayLabel = 'Logradouro'
      FieldName = 'LOGRADOURO'
      Size = 150
    end
    object TabFornecedoresNUMERO: TIntegerField
      DisplayLabel = 'N'#250'mero'
      FieldName = 'NUMERO'
    end
    object TabFornecedoresBAIRRO: TIBStringField
      DisplayLabel = 'Bairro'
      FieldName = 'BAIRRO'
      Size = 100
    end
    object TabFornecedoresCIDADE: TIBStringField
      DisplayLabel = 'Cidade'
      FieldName = 'CIDADE'
      Size = 100
    end
    object TabFornecedoresUF: TIBStringField
      FieldName = 'UF'
      Size = 2
    end
    object TabFornecedoresTELEFONE: TIBStringField
      DisplayLabel = 'Telefone'
      FieldName = 'TELEFONE'
      EditMask = '!\(99\)00000-0000;1;_'
      Size = 15
    end
  end
  object DataSourceFornec: TDataSource
    DataSet = TabFornecedores
    Left = 560
    Top = 368
  end
end
