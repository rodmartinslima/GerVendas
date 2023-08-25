unit Fornecedores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, StdCtrls, Grids, DBGrids, DBCtrls, ExtCtrls, DB,
  IBCustomDataSet, IBTable, IBDatabase, DM_Principal, ActnList;

type
  TfrmFornecedores = class(TForm1)
    DataBaseFornec: TIBDatabase;
    IBTransactionFornec: TIBTransaction;
    TabFornecedores: TIBTable;
    DataSourceFornec: TDataSource;
    TabFornecedoresIDFORNEC: TIntegerField;
    TabFornecedoresNOME: TIBStringField;
    TabFornecedoresLOGRADOURO: TIBStringField;
    TabFornecedoresNUMERO: TIntegerField;
    TabFornecedoresBAIRRO: TIBStringField;
    TabFornecedoresCIDADE: TIBStringField;
    TabFornecedoresUF: TIBStringField;
    TabFornecedoresTELEFONE: TIBStringField;
    procedure TabFornecedoresBeforeDelete(DataSet: TDataSet);
    procedure TabFornecedoresAfterDelete(DataSet: TDataSet);
    procedure TabFornecedoresAfterEdit(DataSet: TDataSet);
    procedure TabFornecedoresAfterInsert(DataSet: TDataSet);
    procedure TabFornecedoresNewRecord(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TabFornecedoresBeforePost(DataSet: TDataSet);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFornecedores: TfrmFornecedores;

implementation

{$R *.dfm}

procedure TfrmFornecedores.btnSairClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfrmFornecedores.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  TabFornecedores.Close;
end;

procedure TfrmFornecedores.FormDestroy(Sender: TObject);
begin
  inherited;
  TabFornecedores.Close;
end;

procedure TfrmFornecedores.FormShow(Sender: TObject);
begin
  inherited;
  DBNavi.DataSource := DataSourceFornec;
  labMsgPadr�o.Caption := 'Cadastro de Fornecedores';
  TabFornecedores.Open;
end;

procedure TfrmFornecedores.TabFornecedoresAfterDelete(DataSet: TDataSet);
begin
  inherited;
  IBTransactionFornec.CommitRetaining;
end;

procedure TfrmFornecedores.TabFornecedoresAfterEdit(DataSet: TDataSet);
begin
  inherited;
  IBTransactionFornec.CommitRetaining;
end;

procedure TfrmFornecedores.TabFornecedoresAfterInsert(DataSet: TDataSet);
begin
  inherited;
  IBTransactionFornec.CommitRetaining;
end;

procedure TfrmFornecedores.TabFornecedoresBeforeDelete(DataSet: TDataSet);
begin
  inherited;

  if MessageDlg('Deseja excluir o cadastro do fornecedor: ' + TabFornecedoresNOME.AsString+ '?',
     mtWarning,[mbYes, mbNo],0) = mrNo then
    Abort;
end;

procedure TfrmFornecedores.TabFornecedoresBeforePost(DataSet: TDataSet);
begin
  inherited;
  TabFornecedoresNOME.AsString := UpperCase(TabFornecedoresNOME.AsString);
  TabFornecedoresLOGRADOURO.AsString := UpperCase(TabFornecedoresLOGRADOURO.AsString);
  TabFornecedoresBAIRRO.AsString := UpperCase(TabFornecedoresBAIRRO.AsString);
  TabFornecedoresCIDADE.AsString := UpperCase(TabFornecedoresCIDADE.AsString);
  TabFornecedoresUF.AsString := UpperCase(TabFornecedoresUF.AsString);
end;

procedure TfrmFornecedores.TabFornecedoresNewRecord(DataSet: TDataSet);
begin
  IBTransactionFornec.CommitRetaining;
  inherited;

  TabFornecedoresIDFORNEC.AsInteger := DataModule1.Gerador('IDFORNEC', 'FORNECEDORES');
  TabFornecedoresCIDADE.AsString := 'VI�OSA';
  TabFornecedoresUF.AsString := 'MG';
end;

end.
