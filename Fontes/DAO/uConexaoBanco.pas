unit uConexaoBanco;

interface

uses
   SysUtils, Forms, inifiles, FireDAC.Comp.Client,
    FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite;

type
   TConexaoBanco = class
      private
       FDconn : TFDConnection;
      public
       constructor Create;
       destructor  Destroy; override;

       function GetConexao : TFDConnection;
       property ConexaoBanco : TFDConnection read GetConexao;
       function CriarQuery: TFDQuery;

   end;

implementation

{ TConexaoBanco }

constructor TConexaoBanco.Create;
var
  DataBase, ArquivoINI, DriverName :String;
  Configuracoes: TIniFile;
begin


   ArquivoINI := ExtractFilePath(Application.ExeName) + 'conexao.ini';

   if not FileExists(ArquivoINI) then
   begin
      raise Exception.Create('Arquivo de Config não Encontrado !'+ExtractFilePath(Application.ExeName)+'\conexao.ini');
      Exit;
   end;

   Configuracoes := TIniFile.Create(ArquivoINI);
   Try
      DataBase    := Configuracoes.ReadString('Dados', 'DataBase',   DataBase);
      DriverName := Configuracoes.ReadString('Dados', 'DriverName', DriverName);
   Finally
     Configuracoes.Free;
   end;

   if not FileExists(DataBase) then
   begin
      raise Exception.Create('DataBase nao encontrado !'+DataBase);
      Exit;
   end;


   try

     FDconn := TFDConnection.Create(nil);
     FDconn.DriverName := DriverName;
     FDconn.Params.Values['DriverID'] := DriverName;
     FDconn.Params.Values['Database'] := DataBase;
     FDconn.LoginPrompt := False;
     FDconn.Connected  := True;
   except
     raise Exception.Create('Erro ao Conectar o Banco de dados. Verifique as preferencias do sistema!');
   end;

end;


destructor TConexaoBanco.Destroy;
begin
  FDconn.Free;
  inherited;
end;

function TConexaoBanco.GetConexao: TFDConnection;
begin
   Result := FDconn;
end;

function TConexaoBanco.CriarQuery: TFDQuery;
var
  FDqry: TFDQuery;
begin
  FDqry := TFDQuery.Create(nil);
  FDqry.Connection := FDconn;

  Result := FDqry;
end;

end.
