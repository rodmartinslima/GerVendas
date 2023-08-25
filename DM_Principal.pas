unit DM_Principal;

interface

uses
  SysUtils, Classes, WideStrings, DBXFirebird, SqlExpr, DB, IBCustomDataSet,
  IBDatabase, IniFiles;

type
  TDataModule1 = class(TDataModule)
    dbprincipal: TIBDatabase;
    IBTransaction1: TIBTransaction;
    SQLConnection1: TSQLConnection;
  private
    FCaminhoBD: string;
    function GetCaminhoBD: string;
    procedure SetCaminhoBD(const Value: string);
    //Geral
  public
    //Geral
    function Gerador(campo, tabela: String): Integer;
    property CaminhoBD: string read GetCaminhoBD write SetCaminhoBD;

    constructor Create;
    destructor  Destroy; Override;
  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.dfm}

{ TDataModule }

constructor TDataModule1.Create;
begin
  FCaminhoBD := '';
end;

destructor TDataModule1.Destroy;
begin
  inherited;
end;

function TDataModule1.Gerador(campo, tabela: String): Integer;
var
  Sql: String;
  Qry: TSQLQuery;
begin
  Sql := 'SELECT MAX( '+ campo +') AS GERADOR FROM ' + tabela;

  Qry := TSQLQuery.Create(nil);
  try
    Qry.SQLConnection := Self.SQLConnection1;
    Qry.SQL.Clear;
    Qry.SQL.Text := Sql;
    Qry.Open;
    Result := Qry.FieldByName('GERADOR').AsInteger;

    if Result < 0 then
      Result := 0;

    Result := Result + 1;
  finally
    Qry.Close;
    FreeAndNil(Qry);
  end;
end;

function TDataModule1.GetCaminhoBD: string;
begin
  Result := FCaminhoBD;
end;

procedure TDataModule1.SetCaminhoBD(const Value: string);
begin
  if Value <> '' then
    FCaminhoBD := Value;
end;

end.
