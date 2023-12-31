unit Vendas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, DBGrids, DM_Principal, DBCtrls, Mask,
  Buttons;

type
  TfrmVendas = class(TForm)
    MemoVendas: TMemo;
    panDetalhesVendas: TPanel;
    grdProdutos: TDBGrid;
    dbEdit: TDBEdit;
    panProdutos: TPanel;
    edtQtde: TEdit;
    dbPrcVenda: TDBEdit;
    labNomeProd: TLabel;
    labQtd: TLabel;
    labPrcVenda: TLabel;
    btnInserir: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
  private
    procedure HeadVenda;
  public
    { Public declarations }
  end;

var
  frmVendas: TfrmVendas;

implementation

{$R *.dfm}

procedure TfrmVendas.btnInserirClick(Sender: TObject);
begin
  with DataModule1 do
  begin
    MemoVendas.Lines.Add('  ' +
        VarToStr(idsProdutosIDPROD.AsInteger) + '     ' +
        idsProdutosDESCRICAO.AsString + '                                        ' +
        edtQtde.Text                  + '          ' +
        VarToStr(idsItensVendasPRC_UNITARIO.AsCurrency)
      );
    MemoVendas.Lines.Add('');
  end;
end;

procedure TfrmVendas.FormShow(Sender: TObject);
begin
  DataModule1.idsProdutos.Close;
  DataModule1.idsProdutos.Open;
  HeadVenda();
end;

procedure TfrmVendas.HeadVenda;
begin
  MemoVendas.Lines.Add('============= DADOS DA VENDA ==============');
  MemoVendas.Lines.Add('');
  MemoVendas.Lines.Add('Data: ' + VarToStr(now()));
  MemoVendas.Lines.Add('Cliente: ');
  MemoVendas.Lines.Add('');
  MemoVendas.Lines.Add('============= P R O D U T O S =============');
  MemoVendas.Lines.Add('C�d.     Descri��o                              Qtde    Prc de venda');
  MemoVendas.Lines.Add('');
end;

end.
