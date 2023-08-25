unit Clientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, StdCtrls, ExtCtrls, Grids, DBGrids, CadastroCliente, DBCtrls,
  WideStrings, DBXFirebird, DB, IBCustomDataSet, IBTable, IBDatabase, SqlExpr,
  ActnList;

type
  TfrmClientes = class(TForm1)
    BDClientes: TIBDatabase;
    TransactionCLi: TIBTransaction;
    TableClientes: TIBTable;
    DataSourceCli: TDataSource;
    TableClientesIDCLI: TIntegerField;
    TableClientesNOME: TIBStringField;
    TableClientesLOGRADOURO: TIBStringField;
    TableClientesNUMERO: TIntegerField;
    TableClientesBAIRRO: TIBStringField;
    TableClientesCIDADE: TIBStringField;
    TableClientesUF: TIBStringField;
    TableClientesDATA_NASCIMENTO: TDateField;
    procedure btnSairClick(Sender: TObject);
    procedure TableClientesNewRecord(DataSet: TDataSet);
    procedure TableClientesBeforePost(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure TableClientesBeforeDelete(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure TableClientesAfterDelete(DataSet: TDataSet);
    procedure TableClientesAfterEdit(DataSet: TDataSet);
    procedure TableClientesAfterInsert(DataSet: TDataSet);
  private

  public
    { Public declarations }
  end;

var
  frmClientes: TfrmClientes;

implementation

uses
  DM_Principal, Utils;
{$R *.dfm}

procedure TfrmClientes.btnSairClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfrmClientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  TableClientes.Close;
end;

procedure TfrmClientes.FormDestroy(Sender: TObject);
begin
  inherited;
  TableClientes.Close;
end;

procedure TfrmClientes.FormShow(Sender: TObject);
var
  caminhoBD: String;
begin
  inherited;
  caminhoBD := LerArquivoIniString('CONFIG', 'bd');

  if caminhoBD <> '' then
  begin
    BDClientes.Close;
    BDClientes.DatabaseName := caminhoBD;
    BDClientes.Open;
  end;

  DBNavi.DataSource := DataSourceCli;
  labMsgPadrão.Caption := 'Cadastro de Clientes';
  TableClientes.Open;
end;

procedure TfrmClientes.TableClientesAfterDelete(DataSet: TDataSet);
begin
  inherited;
  TransactionCLi.CommitRetaining;
end;

procedure TfrmClientes.TableClientesAfterEdit(DataSet: TDataSet);
begin
  inherited;
  TransactionCLi.CommitRetaining;
end;

procedure TfrmClientes.TableClientesAfterInsert(DataSet: TDataSet);
begin
  inherited;
  TransactionCLi.CommitRetaining;
end;

procedure TfrmClientes.TableClientesBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  if MessageDlg('Deseja excluir o cadastro do cliente: ' + TableClientesNOME.AsString + '?',
    mtConfirmation,[mbYes, mbNo],0) = mrNo then
   Abort;
end;

procedure TfrmClientes.TableClientesBeforePost(DataSet: TDataSet);
begin
  inherited;
  TableClientesNOME.AsString := UpperCase(TableClientesNOME.AsString);
  TableClientesLOGRADOURO.AsString := UpperCase(TableClientesLOGRADOURO.AsString);
  TableClientesBAIRRO.AsString := UpperCase(TableClientesBAIRRO.AsString);
  TableClientesCIDADE.AsString := UpperCase(TableClientesCIDADE.AsString);
  TableClientesUF.AsString := UpperCase(TableClientesUF.AsString);
end;

procedure TfrmClientes.TableClientesNewRecord(DataSet: TDataSet);
begin
  TransactionCLi.CommitRetaining;
  inherited;

  TableClientesIDCLI.AsInteger := DM_Principal.DataModule1.Gerador('IDCLI','CLIENTES');
  TableClientesCIDADE.AsString := UpperCase('VIÇOSA');
  TableClientesUF.AsString := UpperCase('MG');
end;

end.
