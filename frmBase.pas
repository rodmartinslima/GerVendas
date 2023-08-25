unit frmBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, DBCtrls, ActnList;

type
  TForm1 = class(TForm)
    btnSair: TButton;
    panMenu: TPanel;
    panPesquisa: TPanel;
    labTpPesquisa: TLabel;
    cbxPesquisar: TComboBox;
    edtPesquisar: TEdit;
    dbgPrincipal: TDBGrid;
    panBackground: TPanel;
    panRodape: TPanel;
    labMsgPadrão: TLabel;
    DBNavi: TDBNavigator;
    btnPesquisar: TButton;
    actGeral: TActionList;
    actPesquisar: TAction;
    actSair: TAction;
    procedure actPesquisarExecute(Sender: TObject);
    procedure actSairExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.actPesquisarExecute(Sender: TObject);
begin
  //
end;

procedure TForm1.actSairExecute(Sender: TObject);
begin
  Self.Close;
end;

end.
