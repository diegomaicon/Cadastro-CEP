program MVP_CEP;
uses
  Vcl.Forms,
  Principal in 'Principal.pas' {FrmPrincipal},
  uCep in 'Fontes\Classe\uCep.pas',
  uRotinas in 'Fontes\Uteis\uRotinas.pas',
  uConexaoBanco in 'Fontes\DAO\uConexaoBanco.pas',
  uCepXML in 'Fontes\Classe\uCepXML.pas',
  uCepDAO in 'Fontes\DAO\uCepDAO.pas';

{$R *.res}
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
