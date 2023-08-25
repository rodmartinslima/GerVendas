unit UtilsUnit;

interface

function diaDaSemana(Data: TDateTime): String;
function iif(const Condicao: Boolean; const Verdadeiro, Falso: Variant): Variant;

procedure escreverLog(texto:String);

implementation

uses
  SysUtils;

function diaDaSemana(Data: TDateTime): String;
var
  NoDia : Integer;
  DiaSemana : array [1..7] of String[13];
begin
  DiaSemana [1] := 'Domingo';
  DiaSemana [2] := 'Segunda-feira';
  DiaSemana [3] := 'Ter�a-feira';
  DiaSemana [4] := 'Quarta-feira';
  DiaSemana [5] := 'Quinta-feira';
  DiaSemana [6] := 'Sexta-feira';
  DiaSemana [7] := 'S�bado';

  NoDia:=DayOfWeek(Data);
  Result := Diasemana[NoDia];
end;

function iif(const Condicao: Boolean; const Verdadeiro, Falso: Variant): Variant;
begin
  if Condicao then
    Result := Verdadeiro
  else
    Result := Falso;
end;

procedure escreverLog(texto:String);
//var
  {fs:TFileStream;
  FileName, fn: string; }
begin
{  FileName := 'C:\Logs\LogGerVendas.txt';

  if not FileExists(FileName) then
  begin
    fs := TFileStream.Create(FileName, fmCreate);
    fn := fn + FormatDateTime('dd/mm/yyyy hh:nn:ss', Now()) + ' : ' + texto + #13;
  end
  else
  begin
    fs := TFileStream.Create(FileName, fmOpenRead);
    fn := fn + FormatDateTime('dd/mm/yyyy hh:nn:ss', Now()) + ' : ' + texto + #13;
  end;

  try
    fs.position := fs.size;
    fs.Write(fn[1],Length(fn));
  finally
    fa.Free
  end; }
end;

end.
