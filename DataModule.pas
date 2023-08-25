unit DataModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, IBCustomDataSet, IBDatabase, DBTables, FMTBcd, SqlExpr,
  WideStrings, DBXFirebird;

type
  TfrmDataModule = class(TForm)
    dbprincipal: TIBDatabase;
    IBTransaction1: TIBTransaction;
    dtsClientes: TDataSource;
    idsClientes: TIBDataSet;
    idsClientesIDCLI: TIntegerField;
    idsClientesNOME: TIBStringField;
    idsClientesLOGRADOURO: TIBStringField;
    idsClientesNUMERO: TIntegerField;
    idsClientesBAIRRO: TIBStringField;
    idsClientesCIDADE: TIBStringField;
    idsClientesUF: TIBStringField;
    idsClientesLIMITECREDITO: TFloatField;
    dtsProdutos: TDataSource;
    idsProdutos: TIBDataSet;
    idsProdutosIDPROD: TIntegerField;
    idsProdutosDESCRICAO: TIBStringField;
    idsProdutosPRCUSTO: TFloatField;
    idsProdutosMARGEMLUCRO: TFloatField;
    idsProdutosPRUNITARIO: TFloatField;
    dtsVendas: TDataSource;
    idsVendas: TIBDataSet;
    idsVendasIDVENDA: TIntegerField;
    idsVendasIDCLIENTE: TIntegerField;
    idsVendasDATA_HORA: TDateTimeField;
    idsVendasVALORBRUTO: TFloatField;
    idsVendasAJUSTE: TFloatField;
    idsVendasVALORLIQUIDO: TFloatField;
    dtsItensVendas: TDataSource;
    idsItensVendas: TIBDataSet;
    idsItensVendasID: TIntegerField;
    idsItensVendasID_VENDA: TIntegerField;
    idsItensVendasID_PRODUTO: TIntegerField;
    idsItensVendasPRC_UNITARIO: TFloatField;
    idsItensVendasQUANTIDADE: TFloatField;
    idsItensVendasAJUSTE: TFloatField;
    idsItensVendasPRC_TOTAL: TFloatField;
    idsClientesDATA_NASCIMENTO: TDateField;
    SQLConnection1: TSQLConnection;
    procedure idsClientesNewRecord(DataSet: TDataSet);
    procedure idsClientesBeforePost(DataSet: TDataSet);
    procedure idsClientesAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    function Gerador(name: String): Integer;
  end;

var
  frmDataModule: TfrmDataModule;

implementation

{$R *.dfm}

function TfrmDataModule.Gerador(name: String): Integer;
var
  Sql: String;
  Qry: TSQLQuery;
begin
  Sql := 'SELECT GEN_ID( '+ name +', 0) FROM RDB$DATABASE';

  Qry := TSQLQuery.Create(nil);
  try
    Qry.SQLConnection := Self.SQLConnection1;
    Qry.SQL.Clear;
    Qry.SQL.Add(Sql);
    Result := Qry.ExecSQL();

    if Result = 0 then
      Result := Result + 1;
  finally
    FreeAndNil(Qry);
  end;
end;

procedure TfrmDataModule.idsClientesAfterPost(DataSet: TDataSet);
begin
  //if not (idsClientes.State in [dsInsert, dsEdit]) then
    //idsClientes.Open;

  idsClientes.Refresh;
end;

procedure TfrmDataModule.idsClientesBeforePost(DataSet: TDataSet);
begin
  IBTransaction1.Commit;
end;

procedure TfrmDataModule.idsClientesNewRecord(DataSet: TDataSet);
begin
  idsClientes.Open();
  idsClientes.FieldByName('IDCLI').AsInteger := Self.Gerador('GEN_CLIENTES_ID');
end;

end.
