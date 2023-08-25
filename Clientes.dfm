﻿inherited frmClientes: TfrmClientes
  Caption = ''
  ClientHeight = 600
  ClientWidth = 1024
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 1040
  ExplicitHeight = 639
  PixelsPerInch = 96
  TextHeight = 13
  inherited panMenu: TPanel
    Width = 1024
    ExplicitWidth = 1024
    inherited labMsgPadrão: TLabel
      Left = 908
      ExplicitLeft = 908
    end
    inherited DBNavi: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited panPesquisa: TPanel
    Width = 1024
    Height = 30
    ExplicitWidth = 1024
    ExplicitHeight = 30
    inherited labTpPesquisa: TLabel
      Height = 24
    end
    inherited cbxPesquisar: TComboBox
      Top = 5
      ExplicitTop = 5
    end
    inherited edtPesquisar: TEdit
      Top = 5
      Width = 404
      ExplicitTop = 5
      ExplicitWidth = 404
    end
    inherited btnPesquisar: TButton
      Left = 632
      Top = 3
      Width = 98
      ExplicitLeft = 632
      ExplicitTop = 3
      ExplicitWidth = 98
    end
  end
  inherited panBackground: TPanel
    Top = 80
    Width = 1024
    Height = 480
    ExplicitTop = 80
    ExplicitWidth = 1024
    ExplicitHeight = 480
    inherited dbgPrincipal: TDBGrid
      Width = 1024
      Height = 480
      DataSource = DataSourceCli
      Columns = <
        item
          Color = 10671092
          Expanded = False
          FieldName = 'IDCLI'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOME'
          Width = 500
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'LOGRADOURO'
          Width = 350
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NUMERO'
          Width = 50
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
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UF'
          Width = 20
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATA_NASCIMENTO'
          Visible = True
        end>
    end
  end
  inherited panRodape: TPanel
    Top = 560
    Width = 1024
    ExplicitTop = 560
    ExplicitWidth = 1024
    inherited btnSair: TButton
      Left = 917
      ExplicitLeft = 917
    end
  end
  object BDClientes: TIBDatabase
    Connected = True
    DatabaseName = 'C:\GerVendas\BD\GERVENDAS.FDB'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = TransactionCLi
    Left = 352
    Top = 336
  end
  object TransactionCLi: TIBTransaction
    Active = True
    DefaultDatabase = BDClientes
    DefaultAction = TACommitRetaining
    Left = 408
    Top = 336
  end
  object TableClientes: TIBTable
    Database = BDClientes
    Transaction = TransactionCLi
    AfterDelete = TableClientesAfterDelete
    AfterEdit = TableClientesAfterEdit
    AfterInsert = TableClientesAfterInsert
    BeforeDelete = TableClientesBeforeDelete
    BeforePost = TableClientesBeforePost
    OnNewRecord = TableClientesNewRecord
    Active = True
    FieldDefs = <
      item
        Name = 'IDCLI'
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
        Name = 'DATA_NASCIMENTO'
        DataType = ftDate
      end>
    IndexDefs = <
      item
        Name = 'PK_CLIENTE_ID'
        Fields = 'IDCLI'
        Options = [ixUnique]
      end>
    StoreDefs = True
    TableName = 'CLIENTES'
    Left = 480
    Top = 336
    object TableClientesIDCLI: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayLabel = 'C'#243'digo'
      FieldName = 'IDCLI'
      ReadOnly = True
    end
    object TableClientesNOME: TIBStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Size = 200
    end
    object TableClientesLOGRADOURO: TIBStringField
      DisplayLabel = 'Logradouro'
      FieldName = 'LOGRADOURO'
      Size = 150
    end
    object TableClientesNUMERO: TIntegerField
      DisplayLabel = 'N'#250'mero'
      FieldName = 'NUMERO'
    end
    object TableClientesBAIRRO: TIBStringField
      DisplayLabel = 'Bairro'
      FieldName = 'BAIRRO'
      Size = 100
    end
    object TableClientesCIDADE: TIBStringField
      DisplayLabel = 'Cidade'
      FieldName = 'CIDADE'
      Size = 100
    end
    object TableClientesUF: TIBStringField
      FieldName = 'UF'
      Size = 2
    end
    object TableClientesDATA_NASCIMENTO: TDateField
      DisplayLabel = 'Data de Nascimento'
      FieldName = 'DATA_NASCIMENTO'
      EditMask = '##/##/####;1;_'
    end
  end
  object DataSourceCli: TDataSource
    DataSet = TableClientes
    Left = 552
    Top = 336
  end
end
