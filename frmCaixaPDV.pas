unit frmCaixaPDV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBCtrls, Grids, DBGrids, DB, IBDatabase,
  IBCustomDataSet, IBTable, WideStrings, DBXFirebird, SqlExpr, IBQuery,
  DM_Principal, ActnList;

type
  TfrmCaixa = class(TForm)
    panCabecalho: TPanel;
    panRodape: TPanel;
    panConsultaProdutos: TPanel;
    panListaProdutosVenda: TPanel;
    panBackground: TPanel;
    panTopoConsultaProdutos: TPanel;
    LabBuscarProduto: TLabel;
    edtBuscarProdutos: TEdit;
    panRodapeConsultaProdutos: TPanel;
    panDadosItemConsultaProdutos: TPanel;
    panGrdProduto: TPanel;
    panSubTotalProdutos: TPanel;
    labSubTotalProds: TLabel;
    panValoresSubTotalProds: TPanel;
    labCifrao: TLabel;
    panValorSubTotalProds: TPanel;
    labValorSubTotalProd: TLabel;
    panNomeProduto: TPanel;
    labNomeProd: TLabel;
    panQtdProd: TPanel;
    labQtdProd: TLabel;
    panVlrUnitarioProd: TPanel;
    labVrlUnitProd: TLabel;
    panLinhaTopo: TPanel;
    panLogo: TPanel;
    imgLogo1: TImage;
    imgLogo2: TImage;
    panMensagens: TPanel;
    labPDV: TLabel;
    labDiaSemana: TLabel;
    labData: TLabel;
    panHora: TPanel;
    labHora: TLabel;
    Timer1: TTimer;
    panCaixaLivre: TPanel;
    labCaixaLivre: TLabel;
    edtQtdeProd: TEdit;
    edtValorUnitProd: TEdit;
    panTotalPagar: TPanel;
    labTotalPagar: TLabel;
    edtPrecoTotal: TEdit;
    DBGrid1: TDBGrid;
    BDVendas: TIBDatabase;
    TransactionVendas: TIBTransaction;
    TableVendas: TIBTable;
    dtsVendas: TDataSource;
    TableVendasID_VENDA: TIntegerField;
    TableVendasID_PRODUTO: TIntegerField;
    TableVendasPRC_UNITARIO: TFloatField;
    TableVendasQUANTIDADE: TFloatField;
    TableVendasAJUSTE: TFloatField;
    TableVendasPRC_TOTAL: TFloatField;
    TableVendasDESCRICAO_PROD_VENDA: TIBStringField;
    btnSair: TButton;
    panCliente: TPanel;
    labBuscaCliente: TLabel;
    edtBuscarCliente: TEdit;
    labCodigoNomeCliente: TLabel;
    panDadosCliente: TPanel;
    labEnderecoCliente: TLabel;
    SQLConexaoPDV: TSQLConnection;
    grdConsultaProdutos: TDBGrid;
    dtsConsultaProd: TDataSource;
    IBTransactionConsultaProd: TIBTransaction;
    QryConsultaProd: TIBQuery;
    QryConsultaProdIDPROD: TIntegerField;
    QryConsultaProdDESCRICAO: TIBStringField;
    QryConsultaProdPRCVENDA: TFloatField;
    btnInserirItem: TButton;
    btnConfirmaVenda: TButton;
    actList: TActionList;
    actInserirItem: TAction;
    actConfirmarVenda: TAction;
    btnExcluirItem: TButton;
    actExcluirItem: TAction;
    btnLimparVenda: TButton;
    actLimparVenda: TAction;
    TableVendasORDEM: TIntegerField;
    TableVendasID: TIntegerField;
    TransactionItensVendas: TIBTransaction;
    dtsItensVendas: TDataSource;
    procedure btnSairClick(Sender: TObject);
    procedure imgLogo1MouseEnter(Sender: TObject);
    procedure imgLogo2MouseLeave(Sender: TObject);
    procedure imgLogo2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtQtdeProdExit(Sender: TObject);
    procedure btnInserirItemClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure edtValorUnitProdExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtBuscarClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtBuscarProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure edtQtdeProdKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorUnitProdKeyPress(Sender: TObject; var Key: Char);
    procedure actConfirmarVendaExecute(Sender: TObject);
    procedure actInserirItemExecute(Sender: TObject);
    procedure actExcluirItemExecute(Sender: TObject);
    procedure grdConsultaProdutosDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FNumCup, FNumItens, FCodCli, FCodProd: Integer;
    FCupomAberto, FClienteEncontrado: Boolean;
    FNomeCli: String;

    function DiaDaSemana(Data:TDateTime): String;

    //Produtos
    procedure AtualizarSubTotal(const aValorUnitario, aValorSubTotal: Double);
    procedure ConsultaProdutoNome(const NomeProd:String);
    procedure ConsultaProdutoId(const IdProd:Integer);

    //Clientes
    procedure ConsultaClientePorNome(const NomeCli:String);
    procedure ConsultaClientesPorId(const IdCli: Integer);

    //Vendas
    procedure AbrirVenda;
    procedure AtualizarPrecoTotal(const aPrcTotalItem: Currency; TpOpe: String);
    procedure FecharVenda(const aTotalBruto, aAjuste, aTotalLiquido: Currency);
    procedure GravarItens(const aOrdem, aIdVenda, aIDProd: Integer; const aQtde: Double;
                          const aAjuste, aPrcUnit, aPrcTotal: Currency; ADescr: String);
  public
    { Public declarations }
  end;

var
  frmCaixa: TfrmCaixa;

implementation

{$R *.dfm}

procedure TfrmCaixa.btnSairClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmCaixa.AbrirVenda;
var
  Sql: String;
  Qry: TSQLQuery;
begin
  FNumItens := 1;
  FNumCup := DataModule1.Gerador('IDVENDA', 'VENDAS');

  Sql := 'INSERT INTO VENDAS (IDVENDA, IDCLIENTE, DATA_HORA, STATUS) '+
         'VALUES (:IDVENDA, :IDCLIENTE, :DATA_HORA, :STATUS)';

  Qry := TSQLQuery.Create(nil);
  try
    if not TransactionVendas.Active then
      TransactionVendas.Active := True;

    Qry.SQLConnection := Self.SQLConexaoPDV;
    Qry.SQL.Clear;
    Qry.SQL.Text := Sql;
    Qry.ParamByName('IDVENDA').AsInteger := FNumCup;
    Qry.ParamByName('IDCLIENTE').AsInteger := FCodCli;
    Qry.ParamByName('DATA_HORA').AsDateTime := Now();
    Qry.ParamByName('STATUS').AsInteger := 0; //Aberto
    Qry.ExecSQL;
  finally
    Qry.Close;
    FreeAndNil(Qry);
    TransactionVendas.CommitRetaining;
    FCupomAberto := True;
  end;
end;

procedure TfrmCaixa.actConfirmarVendaExecute(Sender: TObject);
var
 vTotalBruto, vAjuste, VTotalLiq: Currency;
 OrdemItem: Integer;
begin
  vTotalBruto := 0;
  vAjuste := 0;
  VTotalLiq := 0;
  OrdemItem := 1;

  TableVendas.First;
  while not TableVendas.Eof do
  begin
    vTotalBruto := vTotalBruto + (TableVendasQUANTIDADE.AsFloat * TableVendasPRC_UNITARIO.AsCurrency);
    vAjuste := vAjuste + TableVendasAJUSTE.AsCurrency;
    VTotalLiq := VTotalLiq + TableVendasPRC_TOTAL.AsCurrency;

    GravarItens(OrdemItem, TableVendasID_VENDA.AsInteger,
                TableVendasID_PRODUTO.AsInteger,
                TableVendasQUANTIDADE.AsFloat,
                TableVendasAJUSTE.AsFloat, TableVendasPRC_UNITARIO.AsCurrency, TableVendasPRC_TOTAL.AsCurrency,
                TableVendasDESCRICAO_PROD_VENDA.AsString);

    Inc(OrdemItem);
    TableVendas.Next;
  end;

  Self.FecharVenda(vTotalBruto, vAjuste, VTotalLiq);

  if not (dtsVendas.State in [dsInsert, dsEdit]) then
    dtsVendas.Edit;

  TableVendas.EmptyTable;
  TableVendas.Close;
  TableVendas.Open;
  edtPrecoTotal.Text := '0,00';
  labValorSubTotalProd.Caption := '0,00';
end;

procedure TfrmCaixa.actExcluirItemExecute(Sender: TObject);
begin
  if TableVendas.RecordCount > 0 then
  begin
    Self.AtualizarPrecoTotal(TableVendasPRC_TOTAL.AsCurrency, '-');
    TableVendas.Delete;
  end;
end;

procedure TfrmCaixa.actInserirItemExecute(Sender: TObject);
var
  Qtd, PrcUnit, Ajuste: Double;
begin
  Qtd := StrToFloat(StringReplace(Trim(edtQtdeProd.Text), '.', ',', [rfReplaceAll, rfIgnoreCase]));

  if Qtd <= 0 then
    raise Exception.Create('A quantidade de venda deve ser maior do que zero.');

  PrcUnit := StrToFloat(StringReplace(Trim(edtValorUnitProd.Text), '.', ',', [rfReplaceAll, rfIgnoreCase]));

  if PrcUnit = 0 then
    raise Exception.Create('O pre�o unit�rio deve ser maior do que zero.');

  Ajuste := QryConsultaProdPRCVENDA.AsCurrency - PrcUnit;

  if (not FCupomAberto) and (not TableVendas.EOF) then
  begin
    TableVendas.First;
    FCupomAberto := True;
    FNumCup := TableVendasID_VENDA.AsInteger
  end
  else if (not FCupomAberto) and (TableVendas.EOF) then
    Self.AbrirVenda();

  TableVendas.Open;
  TableVendas.Append;

  TableVendasID.AsInteger := DataModule1.Gerador('ID', 'ITENS_VENDAS');
  TableVendasORDEM.AsInteger := FNumItens;
  TableVendasID_VENDA.AsInteger := FNumCup;
  TableVendasID_PRODUTO.AsInteger := FCodProd; // QryConsultaProdIDPROD.AsInteger;
  TableVendasPRC_UNITARIO.AsCurrency := QryConsultaProdPRCVENDA.AsCurrency;
  TableVendasQUANTIDADE.AsFloat := Qtd;
  TableVendasAJUSTE.AsCurrency := Ajuste;
  TableVendasPRC_TOTAL.AsCurrency := Qtd * PrcUnit;
  TableVendasDESCRICAO_PROD_VENDA.AsString := QryConsultaProdDESCRICAO.AsString;

  TableVendas.Post;
  TableVendas.Refresh;

  Self.AtualizarPrecoTotal(Qtd * PrcUnit, '+');

  FNumItens := FNumItens + 1;
  edtQtdeProd.Text := '1';
  edtValorUnitProd.Text := '0,00';
  labValorSubTotalProd.Caption := '0,00';

  btnLimparVenda.Enabled := True;
end;

procedure TfrmCaixa.AtualizarPrecoTotal(const aPrcTotalItem: Currency; TpOpe: String);
var
  PrecoTotal: Currency;
begin
  edtPrecoTotal.Text := StringReplace(edtPrecoTotal.Text, '.', '', [rfReplaceAll, rfIgnoreCase]);

  if TpOpe = '-' then
    PrecoTotal := StrToFloat(Trim(edtPrecoTotal.Text)) - aPrcTotalItem
  else
    PrecoTotal := StrToFloat(Trim(edtPrecoTotal.Text)) + aPrcTotalItem;

  edtPrecoTotal.Text := FormatFloat('#,,0.00',PrecoTotal);
end;

procedure TfrmCaixa.AtualizarSubTotal(const aValorUnitario, aValorSubTotal: Double);
begin
  edtValorUnitProd.Text := FormatFloat('#,,0.00',aValorUnitario);
  labValorSubTotalProd.Caption := FormatFloat('#,,0.00',aValorSubTotal);
end;

procedure TfrmCaixa.btnInserirItemClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmCaixa.ConsultaClientePorNome(const NomeCli:String);
var
  Sql: String;
  Qry: TSQLQuery;
begin
  Sql := 'SELECT IDCLI, NOME, LOGRADOURO, NUMERO, BAIRRO, CIDADE '+
         'FROM CLIENTES WHERE NOME = :NOME';

  Qry := TSQLQuery.Create(nil);
  try
    Qry.SQLConnection := Self.SQLConexaoPDV;
    Qry.SQL.Clear;
    Qry.SQL.Text := Sql;
    Qry.ParamByName('NOME').AsString := NomeCli;
    Qry.Open;

    if Qry.FieldByName('IDCLI').AsInteger = 0 then
    begin
      raise Exception.Create('Nenhum cliente encontrado com o nome: ' + #13 +
                             NomeCli)
    end else
    begin
      labCodigoNomeCliente.Caption := IntToStr(Qry.FieldByName('IDCLI').AsInteger) +
                                      ' - ' + Qry.FieldByName('NOME').AsString;

      labEnderecoCliente.Caption := Qry.FieldByName('LOGRADOURO').AsString + ', ' +
                                    IntToStr(Qry.FieldByName('NUMERO').AsInteger) + ' - ' +
                                    Qry.FieldByName('BAIRRO').AsString + ' - ' +
                                    Qry.FieldByName('CIDADE').AsString;
      FClienteEncontrado := True;
      FCodCli := Qry.FieldByName('IDCLI').AsInteger;
    end;
  finally
    Qry.Close;
    FreeAndNil(Qry);
  end;
end;

procedure TfrmCaixa.ConsultaClientesPorId(const IdCli: Integer);
var
  Sql: String;
  Qry: TSQLQuery;
begin
  Sql := 'SELECT IDCLI, NOME, LOGRADOURO, NUMERO, BAIRRO, CIDADE '+
         'FROM CLIENTES WHERE IDCLI = :IDCLI';

  Qry := TSQLQuery.Create(nil);
  try
    Qry.SQLConnection := Self.SQLConexaoPDV;
    Qry.SQL.Clear;
    Qry.SQL.Text := Sql;
    Qry.ParamByName('IDCLI').AsInteger := IdCli;
    Qry.Open;

    if Qry.FieldByName('IDCLI').AsInteger = 0 then
    begin
      raise Exception.Create('Nenhum cliente encontrado com o c�digo: ' + #13 +
                             IntToStr(IdCli))
    end else
    begin
      labCodigoNomeCliente.Caption := IntToStr(Qry.FieldByName('IDCLI').AsInteger) +
                                      ' - ' + Qry.FieldByName('NOME').AsString;

      labEnderecoCliente.Caption := Qry.FieldByName('LOGRADOURO').AsString + ', ' +
                                    IntToStr(Qry.FieldByName('NUMERO').AsInteger) + ' - ' +
                                    Qry.FieldByName('BAIRRO').AsString + ' - ' +
                                    Qry.FieldByName('CIDADE').AsString;
      FClienteEncontrado := True;
    end;
  finally
    Qry.Close;
    FreeAndNil(Qry);
  end;
end;

procedure TfrmCaixa.ConsultaProdutoId(const IdProd: Integer);
var
  Sql: String;
  Qry: TSQLQuery;
begin
  Sql := 'SELECT IDPROD, DESCRICAO, PRCVENDA, MARGEM, PRCREPASSE '+
         'FROM PRODUTOS WHERE IDPROD = :IDPROD';

  QryConsultaProd.Close;
  QryConsultaProd.SQL.Clear;
  QryConsultaProd.SQL.Add(Sql);
  QryConsultaProd.ParamByName('IDPROD').AsInteger := IdProd;
  QryConsultaProd.Open;

  if QryConsultaProd.FieldByName('IDPROD').AsInteger = 0 then
  begin
    raise Exception.Create('Nenhum produto encontrado com o c�digo: ' + #13 +
                           IntToStr(IdProd))
  end else
  begin
    labNomeProd.Caption := QryConsultaProd.FieldByName('DESCRICAO').AsString;
    Self.AtualizarSubTotal(QryConsultaProd.FieldByName('PRCVENDA').AsFloat,
      StrToFloat(edtQtdeProd.Text) * QryConsultaProd.FieldByName('PRCVENDA').AsFloat);
  end;
end;

procedure TfrmCaixa.ConsultaProdutoNome(const NomeProd: String);
var
  Sql: String;
begin
  Sql := 'SELECT IDPROD, DESCRICAO, PRCVENDA, MARGEM, PRCREPASSE '+
         'FROM PRODUTOS WHERE DESCRICAO = :DESCRICAO';

  QryConsultaProd.Close;
  QryConsultaProd.SQL.Clear;
  QryConsultaProd.SQL.Add(Sql);
  QryConsultaProd.ParamByName('DESCRICAO').AsString := NomeProd;
  QryConsultaProd.Open;

  if QryConsultaProd.FieldByName('IDPROD').AsInteger = 0 then
  begin
      raise Exception.Create('Nenhum produto encontrado com o nome: ' + #13 +
                             NomeProd)
  end else
  begin
    labNomeProd.Caption := QryConsultaProd.FieldByName('DESCRICAO').AsString;
    edtValorUnitProd.Text := FloatToStr(QryConsultaProd.FieldByName('PRCVENDA').AsFloat);

    labValorSubTotalProd.Caption := FloatToStr(StrToFloat(labValorSubTotalProd.Caption) +
                                    QryConsultaProd.FieldByName('PRCVENDA').AsFloat);
  end;
end;

function TfrmCaixa.DiaDaSemana(Data: TDateTime): String;
//var
  //NoDia : Integer;
  //DiaSemana : array [1..7] of String[13];
begin
  {DiaSemana [1] := 'Domingo';
  DiaSemana [2] := 'Segunda-feira';
  DiaSemana [3] := 'Ter�a-feira';
  DiaSemana [4] := 'Quarta-feira';
  DiaSemana [5] := 'Quinta-feira';
  DiaSemana [6] := 'Sexta-feira';
  DiaSemana [7] := 'S�bado';

  NoDia:=DayOfWeek(Data);
  Result := Diasemana[NoDia];}
end;

procedure TfrmCaixa.edtBuscarClienteKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if StrToIntDef(edtBuscarCliente.Text, -9999) = -9999 then
      Self.ConsultaClientePorNome(edtBuscarCliente.Text)
    else
    begin
      FCodCli := StrToInt(edtBuscarCliente.Text);
      Self.ConsultaClientesPorId(FCodCli);
    end;

    edtQtdeProd.SetFocus;
  end;
end;

procedure TfrmCaixa.edtBuscarProdutosKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if StrToIntDef(edtBuscarProdutos.Text, -9999) = -9999 then
      Self.ConsultaProdutoNome(edtBuscarProdutos.Text)
    else
      Self.ConsultaProdutoId(StrToInt(edtBuscarProdutos.Text));

    edtBuscarCliente.SetFocus;
  end;
end;

procedure TfrmCaixa.edtQtdeProdExit(Sender: TObject);
begin
  if StrToFloat(edtQtdeProd.Text) <= 0 then
    edtQtdeProd.Text := IntToStr(1);
end;

procedure TfrmCaixa.edtQtdeProdKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    edtValorUnitProd.SetFocus;
end;

procedure TfrmCaixa.edtValorUnitProdExit(Sender: TObject);
begin
  actInserirItem.Execute();
  //Se tiver informado cliente,adicionado cliente na venda
  //Calcular desconto, se o pre�o unit�rio informado for diferente do dataset
  //Inserir itens na venda
  //Voltar o foco para o campo buscar produtos
end;

procedure TfrmCaixa.edtValorUnitProdKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    edtValorUnitProd.SetFocus;
end;

procedure TfrmCaixa.FecharVenda(const aTotalBruto, aAjuste, aTotalLiquido: Currency);
var
  Sql: String;
  Qry: TSQLQuery;
begin
  Sql := 'UPDATE VENDAS SET IDCLIENTE = :IDCLIENTE, STATUS = :STATUS,             '+
         'VALORBRUTO = :VALORBRUTO, AJUSTE = :AJUSTE, VALORLIQUIDO=:VALORLIQUIDO  '+
         'WHERE IDVENDA = :IDVENDA                                               ';

  Qry := TSQLQuery.Create(nil);
  try
    Qry.SQLConnection := Self.SQLConexaoPDV;
    Qry.SQL.Clear;
    Qry.SQL.Text := Sql;
    Qry.ParamByName('IDVENDA').AsInteger := FNumCup;
    Qry.ParamByName('IDCLIENTE').AsInteger := FCodCli;
    Qry.ParamByName('STATUS').AsInteger := 1; //Fechado
    Qry.ParamByName('VALORBRUTO').AsCurrency := aTotalBruto;
    Qry.ParamByName('AJUSTE').AsCurrency := aAjuste;
    Qry.ParamByName('VALORLIQUIDO').AsCurrency := aTotalLiquido;
    Qry.ExecSQL;
    FCupomAberto := False;
  finally
    Qry.Close;
    FreeAndNil(Qry);
    TransactionVendas.CommitRetaining;
  end;
end;

procedure TfrmCaixa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TableVendas.Close;
  QryConsultaProd.Close;
  BDVendas.Close;
end;

procedure TfrmCaixa.FormCreate(Sender: TObject);
begin
  FCupomAberto := False;
  FClienteEncontrado :=False;
  FNumCup := -9999;
  FCodCli := -9999;
  FNomeCli := '';
  FCodProd := -9999;

  TableVendas.Open; //Manter para obter itens na mem�ria?
  QryConsultaProd.Open;
  BDVendas.Open;

  if TableVendas.RecordCount > 0 then
  begin
    while not TableVendas.EOF do
    begin
      Self.AtualizarPrecoTotal(TableVendasQUANTIDADE.AsFloat * TableVendasPRC_UNITARIO.AsCurrency, '+');
      TableVendas.Next;
    end;
  end;
end;

procedure TfrmCaixa.FormShow(Sender: TObject);
begin
  edtBuscarProdutos.SetFocus;
  labDiaSemana.Caption := Self.DiaDaSemana(now());
  labData.Caption := FormatDateTime('dd "de" mmmm "de" yyyy', Now());
end;

procedure TfrmCaixa.GravarItens(const aOrdem, aIdVenda, aIDProd: Integer; const aQtde: Double;
                               const aAjuste, aPrcUnit, aPrcTotal: Currency; ADescr: String);
var
  Sql: String;
  Qry: TSQLQuery;
begin
  Sql := 'INSERT INTO ITENS_VENDAS ' +
         ' (ID, ORDEM, ID_VENDA, ID_PRODUTO, PRC_UNITARIO, QUANTIDADE, AJUSTE, PRC_TOTAL, DESCRICAO_PROD_VENDA) '+
         'VALUES (:ID, :ORDEM, :ID_VENDA, :ID_PRODUTO, :PRC_UNITARIO, :QUANTIDADE, :AJUSTE, :PRC_TOTAL, :DESCRICAO_PROD_VENDA)';

  TransactionVendas.RollbackRetaining;
  if not TransactionItensVendas.Active then
    TransactionItensVendas.Active := True;

  Qry := TSQLQuery.Create(TransactionItensVendas);
  try
    Qry.SQLConnection := Self.SQLConexaoPDV;
    Qry.SQL.Clear;
    Qry.SQL.Text := Sql;
    Qry.ParamByName('ID').AsInteger := DataModule1.Gerador('ID', 'ITENS_VENDAS');
    Qry.ParamByName('ORDEM').AsInteger := aOrdem;
    Qry.ParamByName('ID_VENDA').AsInteger := aIdVenda;
    Qry.ParamByName('ID_PRODUTO').AsInteger := aIDProd;
    Qry.ParamByName('QUANTIDADE').AsFloat := aQtde;
    Qry.ParamByName('PRC_UNITARIO').AsCurrency := aPrcUnit;
    Qry.ParamByName('AJUSTE').AsCurrency := aAjuste;
    Qry.ParamByName('PRC_TOTAL').AsCurrency := aPrcTotal;
    Qry.ParamByName('DESCRICAO_PROD_VENDA').AsString := ADescr;
    Qry.ExecSQL();
  finally
    Qry.Close;
    FreeAndNil(Qry);
    TransactionItensVendas.CommitRetaining;
    //Atualizar data de venda dos itens
  end;
end;

procedure TfrmCaixa.grdConsultaProdutosDblClick(Sender: TObject);
begin
  labNomeProd.Caption := QryConsultaProdDESCRICAO.AsString;
  edtBuscarProdutos.Text := QryConsultaProdDESCRICAO.AsString;
  FCodProd := QryConsultaProdIDPROD.AsInteger;

  Self.AtualizarSubTotal(QryConsultaProd.FieldByName('PRCVENDA').AsFloat,
      StrToFloat(edtQtdeProd.Text) * QryConsultaProd.FieldByName('PRCVENDA').AsFloat);
end;

procedure TfrmCaixa.imgLogo1MouseEnter(Sender: TObject);
begin
  imgLogo1.Visible := False;
  imgLogo2.Visible := True;
end;

procedure TfrmCaixa.imgLogo2Click(Sender: TObject);
begin
  ShowMessage('Vers�o 1.0');
end;

procedure TfrmCaixa.imgLogo2MouseLeave(Sender: TObject);
begin
  imgLogo1.Visible := True;
  imgLogo2.Visible := False;
end;

procedure TfrmCaixa.Timer1Timer(Sender: TObject);
begin
  labHora.Caption := TimeToStr(Time);
end;

end.


