unit CadastroProdutos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, ExtCtrls, DM_Principal, DB, DBClient,
  IBCustomDataSet, IBDatabase, Grids, DBGrids, WideStrings, DBXFirebird, SqlExpr;

type
  TfrmCadastroProdutos = class(TForm)
    panProdutos: TPanel;
    grbDadosItem: TGroupBox;
    edtCodigo: TDBEdit;
    labCodigo: TLabel;
    labDescricao: TLabel;
    grbPrecos: TGroupBox;
    btnCancelar: TButton;
    btnOk: TButton;
    labValorVenda: TLabel;
    labMargem: TLabel;
    labValorRepasse: TLabel;
    edtDescricao: TEdit;
    edtValorVenda: TEdit;
    edtMargem: TEdit;
    edtValorRepasse: TEdit;
    panRodape: TPanel;
    dtsFornecedores: TDataSource;
    idsFornec: TIBDataSet;
    IBTransaction1: TIBTransaction;
    dbFornec: TIBDatabase;
    idsFornecIDFORNEC: TIntegerField;
    idsFornecNOME: TIBStringField;
    idsFornecLOGRADOURO: TIBStringField;
    idsFornecNUMERO: TIntegerField;
    idsFornecBAIRRO: TIBStringField;
    idsFornecCIDADE: TIBStringField;
    idsFornecUF: TIBStringField;
    idsFornecTELEFONE: TIBStringField;
    grbFornec: TGroupBox;
    edtCodFornec: TEdit;
    edtNomeFornec: TEdit;
    grbFornecedores: TDBGrid;
    SQLConexaoProd: TSQLConnection;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtMargemBDExit(Sender: TObject);
    procedure edtValorVendaBDExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grbFornecedoresColEnter(Sender: TObject);
    procedure edtNomeFornecKeyPress(Sender: TObject; var Key: Char);
    procedure btnOkClick(Sender: TObject);
    procedure grbFornecedoresDblClick(Sender: TObject);
    procedure edtValorVendaExit(Sender: TObject);
    procedure edtMargemExit(Sender: TObject);
  private
    FNomeProd, FNomeFornec: String;
    FValorVenda, FMargem, FValorRepasse: Currency;
    FAlteracao: Boolean;
    FIdProd, FIdFornec: Integer;

    procedure AtribuirFornecedor;
    procedure AtualizarPrecoRepasse;
    procedure GravarDados;
  public
    property IdProd: Integer read FIdProd write FIdProd;
    property IdFornec: Integer read FIdFornec write FIdFornec;
    property NomeProd: String read FNomeProd write FNomeProd;
    property NomeFornec: String read FNomeFornec write FNomeFornec;
    property ValorVenda: Currency read FValorVenda write FValorVenda;
    property Margem: Currency read FMargem write FMargem;
    property ValorRepasse: Currency read FValorRepasse write FValorRepasse;
    property isAlteracao: Boolean read FAlteracao write FAlteracao;
  end;

var
  frmCadastroProdutos: TfrmCadastroProdutos;

implementation

{$R *.dfm}

procedure TfrmCadastroProdutos.AtribuirFornecedor;
begin
  edtCodFornec.Text := IntToStr(idsFornecIDFORNEC.AsInteger);
  edtNomeFornec.Text := idsFornecNOME.AsString;
end;

procedure TfrmCadastroProdutos.AtualizarPrecoRepasse;
begin
  edtValorRepasse.Text := FloatToStr(StrToFloat(edtValorVenda.Text) -
    (StrToFloat(edtValorVenda.Text) * (StrToFloat(edtMargem.Text) / 100)));
end;

procedure TfrmCadastroProdutos.btnCancelarClick(Sender: TObject);
begin
  Self.Close();
end;

procedure TfrmCadastroProdutos.btnOkClick(Sender: TObject);
begin
  GravarDados();
end;

procedure TfrmCadastroProdutos.edtMargemBDExit(Sender: TObject);
begin
  AtualizarPrecoRepasse();
end;

procedure TfrmCadastroProdutos.edtMargemExit(Sender: TObject);
begin
  AtualizarPrecoRepasse();
end;

procedure TfrmCadastroProdutos.edtNomeFornecKeyPress(Sender: TObject; var Key: Char);
var
 sl: TStrings;
begin
  if (Key = #13) then
  begin
    sl := TStringList.Create;
    try
      if edtNomeFornec.Text <> '' then
        sl.Text := 'select * from FORNECEDORES where NOME = :NOME'
      else 
        sl.Text := 'select * from FORNECEDORES';
        
      idsFornec.SelectSQL := sl;
      
      if edtNomeFornec.Text <> '' then
        idsFornec.ParamByName('NOME').AsString := edtNomeFornec.Text;

      idsFornec.Open;
    finally
      FreeAndNil(sl);
    end;
  end;
end;

procedure TfrmCadastroProdutos.edtValorVendaBDExit(Sender: TObject);
begin
  AtualizarPrecoRepasse();
end;

procedure TfrmCadastroProdutos.edtValorVendaExit(Sender: TObject);
begin
  AtualizarPrecoRepasse();
end;

procedure TfrmCadastroProdutos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FAlteracao := False;
end;

procedure TfrmCadastroProdutos.FormCreate(Sender: TObject);
begin
  FIdProd := 0;
  FNomeProd := '';
  FValorVenda := 0;
  FMargem := 0;
  FValorRepasse := 0;
  FAlteracao := False;

  edtValorVenda.Text := FormatFloat('#,,0.00',0);
  edtMargem.Text := FormatFloat('#,,0.00',FMargem);
  edtValorRepasse.Text := FormatFloat('#,,0.00',0);
end;

procedure TfrmCadastroProdutos.FormShow(Sender: TObject);
begin
  if not FAlteracao then
  begin
    edtCodigo.Text := IntToStr(DataModule1.Gerador('IDPROD', 'PRODUTOS'));
    edtMargem.Text := FormatFloat('#,,0.00',50);
  end else
  begin
    edtCodigo.Text := IntToStr(FIdProd);
    edtDescricao.Text := FNomeProd;
    edtValorVenda.Text := FormatFloat('#,,0.00',FValorVenda);
    edtMargem.Text := FormatFloat('#,,0.00',FMargem);
    edtValorRepasse.Text := FormatFloat('#,,0.00',FValorRepasse);
  end;

  idsFornec.Open;
  while not idsFornec.Eof do
  begin
    //cbxFornecedores.Items.Add(idsFornecNOME.AsString);
    idsFornec.Next;
  end;

  edtDescricao.SetFocus;
end;

procedure TfrmCadastroProdutos.GravarDados;
var
  Sql: String;
  Qry: TSQLQuery;
begin
  if isAlteracao then
  begin
    Sql := 'UPDATE PRODUTOS SET'+
           ' DESCRICAO = :DESCRICAO, PRCVENDA = :PRCVENDA, MARGEM = :MARGEM,           '+
           ' PRCREPASSE = :PRCREPASSE, IDFORNEC = :IDFORNEC, NOMEFORNEC = :NOMEFORNEC  '+
           'WHERE IDPROD = :IDPROD ';

    Qry := TSQLQuery.Create(IBTransaction1);
    try
      edtValorVenda.Text := StringReplace(edtValorVenda.Text, '.', '', [rfReplaceAll, rfIgnoreCase]);
      edtMargem.Text := StringReplace(edtMargem.Text, '.', '', [rfReplaceAll, rfIgnoreCase]);
      edtValorRepasse.Text := StringReplace(edtValorRepasse.Text, '.', '', [rfReplaceAll, rfIgnoreCase]);
    
      Qry.SQLConnection := Self.SQLConexaoProd;
      Qry.SQL.Clear;
      Qry.SQL.Text := Sql;
      Qry.ParamByName('IDPROD').AsInteger := StrToInt(edtCodigo.Text);
      Qry.ParamByName('DESCRICAO').AsString := UpperCase(edtDescricao.Text);
      Qry.ParamByName('PRCVENDA').AsCurrency :=  StrToFloat(Trim(edtValorVenda.Text));
      Qry.ParamByName('MARGEM').AsCurrency := StrToFloat(Trim(edtMargem.Text));;
      Qry.ParamByName('PRCREPASSE').AsCurrency := StrToFloat(Trim(edtValorRepasse.Text));;
      Qry.ParamByName('IDFORNEC').AsInteger := StrToInt(edtCodFornec.Text);
      Qry.ParamByName('NOMEFORNEC').AsString := edtNomeFornec.Text;
      Qry.ExecSQL();
    finally
      Qry.Close;
      FreeAndNil(Qry);
    end;
  end else
  begin
    Sql := 'INSERT INTO PRODUTOS '+
           '(IDPROD, DESCRICAO, PRCVENDA, MARGEM, PRCREPASSE, DATA_CADASTRO, HORA_CADASTRO, IDFORNEC, NOMEFORNEC) '+
           'VALUES '+
           '(:IDPROD, :DESCRICAO, :PRCVENDA, :MARGEM, :PRCREPASSE, :DATA_CADASTRO, :HORA_CADASTRO, :IDFORNEC, :NOMEFORNEC)';

    Qry := TSQLQuery.Create(IBTransaction1);
    try
      edtValorVenda.Text := StringReplace(edtValorVenda.Text, '.', '', [rfReplaceAll, rfIgnoreCase]);
      edtMargem.Text := StringReplace(edtMargem.Text, '.', '', [rfReplaceAll, rfIgnoreCase]);
      edtValorRepasse.Text := StringReplace(edtValorRepasse.Text, '.', '', [rfReplaceAll, rfIgnoreCase]);

      Qry.SQLConnection := Self.SQLConexaoProd;
      Qry.SQL.Clear;
      Qry.SQL.Text := Sql;
      Qry.ParamByName('IDPROD').AsInteger := StrToInt(edtCodigo.Text);
      Qry.ParamByName('DESCRICAO').AsString := UpperCase(edtDescricao.Text);
      Qry.ParamByName('PRCVENDA').AsCurrency := StrToFloat(Trim(edtValorVenda.Text));
      Qry.ParamByName('MARGEM').AsCurrency := StrToFloat(Trim(edtMargem.Text));;
      Qry.ParamByName('PRCREPASSE').AsCurrency := StrToFloat(Trim(edtValorRepasse.Text));;
      Qry.ParamByName('DATA_CADASTRO').AsDate := Date();
      Qry.ParamByName('HORA_CADASTRO').AsTime := Time();
      Qry.ParamByName('IDFORNEC').AsInteger := StrToInt(edtCodFornec.Text);
      Qry.ParamByName('NOMEFORNEC').AsString := edtNomeFornec.Text;
      Qry.ExecSQL();
    finally
      Qry.Close;
      FreeAndNil(Qry);
    end;
  end;
  IBTransaction1.CommitRetaining;
end;

procedure TfrmCadastroProdutos.grbFornecedoresColEnter(Sender: TObject);
begin
  AtribuirFornecedor();
end;

procedure TfrmCadastroProdutos.grbFornecedoresDblClick(Sender: TObject);
begin
  AtribuirFornecedor();
end;

end.
