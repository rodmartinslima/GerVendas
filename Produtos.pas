unit Produtos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, StdCtrls, ExtCtrls, Grids, DBGrids, DM_Principal, DBCtrls,
  CadastroProdutos, DB, IBCustomDataSet, IBTable, IBDatabase, IBQuery, ActnList;

type
  TfrmProdutos = class(TForm1)
    DataBaseProd: TIBDatabase;
    IBTransactionProd: TIBTransaction;
    TabProdutos: TIBTable;
    DataSourceProdutos: TDataSource;
    TabProdutosIDPROD: TIntegerField;
    TabProdutosDESCRICAO: TIBStringField;
    TabProdutosPRCVENDA: TFloatField;
    TabProdutosMARGEM: TFloatField;
    TabProdutosPRCREPASSE: TFloatField;
    TabProdutosDATA_CADASTRO: TDateField;
    TabProdutosDATA_VENDA: TDateField;
    TabProdutosHORA_CADASTRO: TTimeField;
    TabProdutosHORA_VENDA: TTimeField;
    TabProdutosIDFORNEC: TIntegerField;
    TabProdutosNOMEFORNEC: TIBStringField;
    cbxCadastroDetalhado: TCheckBox;
    procedure TabProdutosBeforeDelete(DataSet: TDataSet);
    procedure TabProdutosBeforePost(DataSet: TDataSet);
    procedure TabProdutosNewRecord(DataSet: TDataSet);
    procedure TabProdutosAfterInsert(DataSet: TDataSet);
    procedure TabProdutosAfterEdit(DataSet: TDataSet);
    procedure TabProdutosAfterDelete(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure dbgPrincipalColExit(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    {procedure idsProdutosNewRecord(DataSet: TDataSet);
    procedure idsProdutosBeforePost(DataSet: TDataSet);
    procedure idsProdutosBeforeDelete(DataSet: TDataSet);
    procedure idsProdutosAfterInsert(DataSet: TDataSet);
    procedure idsProdutosAfterEdit(DataSet: TDataSet);
    procedure idsProdutosAfterDelete(DataSet: TDataSet);}
    procedure TabProdutosBeforeInsert(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TabProdutosBeforeEdit(DataSet: TDataSet);
    procedure dbgPrincipalDblClick(Sender: TObject);
  private

  public
    { Public declarations }
  end;

var
  frmProdutos: TfrmProdutos;

implementation

uses
  Utils;

{$R *.dfm}

procedure TfrmProdutos.actPesquisarExecute(Sender: TObject);
var
  Sql: string;
begin
  {inherited;
  if edtPesquisar.Text = '' then
  begin
    Sql := 'Select * from PRODUTOS';
    idsProdutos.Close;
    idsProdutos.SelectSQL.Clear;
    idsProdutos.SelectSQL.Add(Sql);
    idsProdutos.Open;
  end
  else if cbxPesquisar.ItemIndex = 0 then
  begin
    Sql := 'Select * from PRODUTOS where DESCRICAO = :NOME';
    idsProdutos.Close;
    idsProdutos.SelectSQL.Clear;
    idsProdutos.SelectSQL.Add(Sql);
    idsProdutos.ParamByName('NOME').AsString := edtPesquisar.Text;
    idsProdutos.Open;
  end else
  begin
    if StrToIntDef(edtPesquisar.Text, -9999) = -9999 then
      Abort;

    Sql := 'Select * from PRODUTOS where IDPROD = :IDPROD';
    idsProdutos.Close;
    idsProdutos.SelectSQL.Clear;
    idsProdutos.SelectSQL.Add(Sql);
    idsProdutos.ParamByName('IDPROD').AsInteger := StrToInt(edtPesquisar.Text);
    idsProdutos.Open;
  end; }
end;

procedure TfrmProdutos.dbgPrincipalColExit(Sender: TObject);
begin
  inherited;

  if ((dbgPrincipal.Columns.Items[dbgPrincipal.SelectedIndex].Title.Caption = 'Margem(%)') or
    (dbgPrincipal.Columns.Items[dbgPrincipal.SelectedIndex].Title.Caption = 'Pre�o Venda(R$)')) and
    (TabProdutosPRCVENDA.AsFloat > 0) and (TabProdutosMARGEM.AsFloat > 0) then
  begin
    if not (DataSourceProdutos.State in [dsInsert, dsEdit]) then
      DataSourceProdutos.Edit;

    TabProdutosPRCREPASSE.AsFloat := TabProdutosPRCVENDA.AsFloat -
                                     (TabProdutosPRCVENDA.AsFloat * (TabProdutosMARGEM.AsFloat / 100));
  end
  else if (dbgPrincipal.Columns.Items[dbgPrincipal.SelectedIndex].Title.Caption = 'C�digo Fornecedor') then
  begin
    //Fazer consulta sql

    if not (DataSourceProdutos.State in [dsInsert, dsEdit]) then
      DataSourceProdutos.Edit;

    //ShowMessage('Saiu da coluna ID Fornec');
  end
  else if (dbgPrincipal.Columns.Items[dbgPrincipal.SelectedIndex].Title.Caption = 'Nome Fornecedor') then
  begin
    //Fazer Consulta sql

    if not (DataSourceProdutos.State in [dsInsert, dsEdit]) then
      DataSourceProdutos.Edit;

    //ShowMessage('Saiu da coluna Nome Fornec');
  end;
end;

procedure TfrmProdutos.dbgPrincipalDblClick(Sender: TObject);
begin
  inherited;
  TabProdutos.Edit;
end;

procedure TfrmProdutos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  EscreverArquivoIniBool('CONFIG', 'cadastroDetalhado', cbxCadastroDetalhado.Checked);
end;

procedure TfrmProdutos.FormShow(Sender: TObject);
var
  caminhoBD: String;
begin
  inherited;
  DBNavi.DataSource := DataSourceProdutos;
  labMsgPadr�o.Caption := 'Cadastro de Produtos';
  TabProdutos.Open;

  caminhoBD := LerArquivoIniString('CONFIG', 'bd');
  cbxCadastroDetalhado.Checked := LerArquivoIniBool('CONFIG', 'cadastroDetalhado');

  if caminhoBD <> '' then
  begin
    DataBaseProd.Close;
    DataBaseProd.DatabaseName := caminhoBD;
    DataBaseProd.Open;
  end;
end;

{procedure TfrmProdutos.idsProdutosAfterDelete(DataSet: TDataSet);
begin
  inherited;
  IBTransactionProd.CommitRetaining;
end;

procedure TfrmProdutos.idsProdutosAfterEdit(DataSet: TDataSet);
begin
  inherited;
  IBTransactionProd.CommitRetaining;
end;

procedure TfrmProdutos.idsProdutosAfterInsert(DataSet: TDataSet);
begin
  inherited;
  IBTransactionProd.CommitRetaining;
end;

procedure TfrmProdutos.idsProdutosBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  if MessageDlg('Deseja excluir o produto ' + TabProdutosDESCRICAO.AsString+ '?',
     mtWarning,[mbYes, mbNo],0) = mrNo then
    Abort;
end;

procedure TfrmProdutos.idsProdutosBeforePost(DataSet: TDataSet);
begin
  inherited;
  idsProdutosDESCRICAO.AsString := UpperCase(TabProdutosDESCRICAO.AsString);

  if idsProdutosPRCVENDA.AsFloat > 0 then  //Pre�o de repasse 50%
    idsProdutosPRCREPASSE.AsFloat := idsProdutosPRCVENDA.AsFloat -
                                     (idsProdutosPRCVENDA.AsFloat * (idsProdutosMARGEM.AsFloat / 100));
end;

procedure TfrmProdutos.idsProdutosNewRecord(DataSet: TDataSet);
begin
  IBTransactionProd.CommitRetaining;
  inherited;
  //Atribuindo valores
  idsProdutosIDPROD.AsInteger := DataModule1.Gerador('IDPROD', 'PRODUTOS');
  idsProdutosPRCVENDA.AsFloat := 1;
  idsProdutosMARGEM.AsFloat := 50;
  idsProdutosDATA_CADASTRO.AsDateTime := Date();
  idsProdutosHORA_CADASTRO.AsDateTime := Time();
  idsProdutosPRCREPASSE.AsFloat := idsProdutosPRCVENDA.AsFloat / 2;
end;
}
procedure TfrmProdutos.TabProdutosAfterDelete(DataSet: TDataSet);
begin
  inherited;
  IBTransactionProd.CommitRetaining;
end;

procedure TfrmProdutos.TabProdutosAfterEdit(DataSet: TDataSet);
begin
  inherited;
  IBTransactionProd.CommitRetaining;
end;

procedure TfrmProdutos.TabProdutosAfterInsert(DataSet: TDataSet);
begin
  inherited;
  IBTransactionProd.CommitRetaining;
  TabProdutos.Close;
  TabProdutos.Open;
end;

procedure TfrmProdutos.TabProdutosBeforeDelete(DataSet: TDataSet);
begin
  inherited;

  if MessageDlg('Deseja excluir o produto ' + TabProdutosDESCRICAO.AsString+ '?',
     mtWarning,[mbYes, mbNo],0) = mrNo then
    Abort;
end;

procedure TfrmProdutos.TabProdutosBeforeEdit(DataSet: TDataSet);
var
  CadastroProdutos: TfrmCadastroProdutos;
begin
  inherited;

  if cbxCadastroDetalhado.Checked then
  begin
    CadastroProdutos := TfrmCadastroProdutos.Create(Application);
    try
      with CadastroProdutos do
      begin
        IdProd := TabProdutosIDPROD.AsInteger;
        NomeProd := TabProdutosDESCRICAO.AsString;
        ValorVenda := TabProdutosPRCVENDA.AsCurrency;
        Margem := TabProdutosMARGEM.AsFloat;
        ValorRepasse := TabProdutosPRCREPASSE.AsCurrency;
        IdFornec := TabProdutosIDFORNEC.AsInteger;
        NomeFornec := TabProdutosNOMEFORNEC.AsString;
        isAlteracao := True;
        ShowModal;
      end;
    finally
      FreeAndNil(CadastroProdutos);
    end;
  end;
end;

procedure TfrmProdutos.TabProdutosBeforeInsert(DataSet: TDataSet);
var
  CadastroProdutos: TfrmCadastroProdutos;
begin
  inherited;

  if cbxCadastroDetalhado.Checked then
  begin
    CadastroProdutos := TfrmCadastroProdutos.Create(Application);
    try
      CadastroProdutos.ShowModal;
    finally
      FreeAndNil(CadastroProdutos);
    end;
  end;
end;

procedure TfrmProdutos.TabProdutosBeforePost(DataSet: TDataSet);
begin
  inherited;
  TabProdutosDESCRICAO.AsString := UpperCase(TabProdutosDESCRICAO.AsString);

  if TabProdutosPRCVENDA.AsFloat > 0 then  //Pre�o de repasse 50%
    TabProdutosPRCREPASSE.AsFloat := TabProdutosPRCVENDA.AsFloat -
                                     (TabProdutosPRCVENDA.AsFloat * (TabProdutosMARGEM.AsFloat / 100));
end;

procedure TfrmProdutos.TabProdutosNewRecord(DataSet: TDataSet);
begin
  IBTransactionProd.CommitRetaining;
  inherited;
  //Atribuindo valores
  TabProdutosIDPROD.AsInteger := DataModule1.Gerador('IDPROD', 'PRODUTOS');
  TabProdutosPRCVENDA.AsFloat := 1;
  TabProdutosMARGEM.AsFloat := 50;
  TabProdutosDATA_CADASTRO.AsDateTime := Date();
  TabProdutosHORA_CADASTRO.AsDateTime := Time();
  TabProdutosPRCREPASSE.AsFloat := TabProdutosPRCVENDA.AsFloat / 2;
end;

end.
