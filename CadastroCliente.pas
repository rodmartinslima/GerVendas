unit CadastroCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NovoCadastroBase, StdCtrls, Mask, DBCtrls, ExtCtrls, ComCtrls;

type
  TfrmNovoCadastroCliente = class(TfrmNovoCadastroBase)
    labNumero: TLabel;
    edtNumero: TDBEdit;
    labCidade: TLabel;
    edtCidade: TDBEdit;
    labUF: TLabel;
    labDtNascimento: TLabel;
    cbxUF: TDBComboBox;
    edtDataNasc: TDateTimePicker;
  private

  public
    { Public declarations }
  end;

var
  frmNovoCadastroCliente: TfrmNovoCadastroCliente;

implementation
{$R *.dfm}

end.
