unit NovoCadastroBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, ExtCtrls;

type
  TfrmNovoCadastroBase = class(TForm)
    panPrincipal: TPanel;
    labCodigo: TLabel;
    edtCodigo: TDBEdit;
    labDescricao: TLabel;
    edtDescricao: TDBEdit;
    btnOk: TButton;
    btnCancelar: TButton;
    DBEdit1: TDBEdit;
    labCampo3: TLabel;
    labCampo4: TLabel;
    edtCampo4: TDBEdit;
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNovoCadastroBase: TfrmNovoCadastroBase;

implementation

{$R *.dfm}

procedure TfrmNovoCadastroBase.btnCancelarClick(Sender: TObject);
begin
  Self.Close();
end;

end.
