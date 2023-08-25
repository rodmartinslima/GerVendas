program GerVendas;

uses
  Forms,
  frmBase in 'frmBase.pas' {Form1},
  Clientes in 'Clientes.pas' {frmClientes},
  Produtos in 'Produtos.pas' {frmProdutos},
  Principal in 'Principal.pas' {frmPrincipal},
  NovoCadastroBase in 'NovoCadastroBase.pas' {frmNovoCadastroBase},
  DM_Principal in 'DM_Principal.pas' {DataModule1: TDataModule},
  CadastroProdutos in 'CadastroProdutos.pas' {frmCadastroProdutos},
  frmCaixaPDV in 'frmCaixaPDV.pas' {frmCaixa},
  Fornecedores in 'Fornecedores.pas' {frmFornecedores},
  DM_PDV in 'DM_PDV.pas' {DataModulePDV: TDataModule},
  UtilsUnit in 'UtilsUnit.pas',
  Utils in 'Utils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDataModule1, DataModule1);
  //Application.CreateForm(TfrmCadastroProdutos, frmCadastroProdutos);
  //Application.CreateForm(TfrmCaixa, frmCaixa);
  //Application.CreateForm(TfrmFornecedores, frmFornecedores);
  //Application.CreateForm(TDataModulePDV, DataModulePDV);
  Application.Run;
end.
