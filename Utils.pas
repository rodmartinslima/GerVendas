unit Utils;

interface
function LerArquivoIniString(const tag, parametro: String): String;
function LerArquivoIniBool(const tag, parametro: String): Boolean;

procedure EscreverArquivoIniBool(const tag, parametro: String; const aValue: Boolean);

implementation

uses
  IniFiles, SysUtils, Forms;

function LerArquivoIniString(const tag, parametro: String): String;
var
  ArquivoINI: TIniFile;
  CaminhoINI: String;
begin
  CaminhoINI := ExtractFilePath(Application.ExeName) + 'gervendas.ini';
  ArquivoINI := TIniFile.Create(CaminhoINI);
  try
    Result := ArquivoINI.ReadString(tag, parametro, '');
  finally
    FreeAndNil(ArquivoINI);
  end;
end;

function LerArquivoIniBool(const tag, parametro: String): Boolean;
var
  ArquivoINI: TIniFile;
  CaminhoINI: String;
begin
  CaminhoINI := ExtractFilePath(Application.ExeName) + 'gervendas.ini';
  ArquivoINI := TIniFile.Create(CaminhoINI);
  try
    Result := ArquivoINI.ReadBool(tag, parametro, False);
  finally
    FreeAndNil(ArquivoINI);
  end;
end;

procedure EscreverArquivoIniBool(const tag, parametro: String; const aValue: Boolean);
var
  ArquivoINI: TIniFile;
  CaminhoINI: String;
begin
  CaminhoINI := ExtractFilePath(Application.ExeName) + 'gervendas.ini';
  ArquivoINI := TIniFile.Create(CaminhoINI);
  try
    ArquivoINI.WriteBool(tag, parametro, aValue);
  except
    //
  end;

end;

end.
