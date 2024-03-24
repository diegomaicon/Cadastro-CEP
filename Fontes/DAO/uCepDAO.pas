unit uCepDAO;

interface

uses
  FireDAC.Comp.Client, uConexaoBanco, uCep, System.SysUtils;

type
  TCepDAO = class
  private
    FConexao: TConexaoBanco;
  public
    constructor Create;

    function Incluir(cep: TCep): Boolean;
    function Alterar(cep: TCep): Boolean;
    function Excluir(ID: Integer): Boolean;
    function LimparTebela: Boolean;
    function SQLQryCEPGet(filtro:string): String;
    function Filtrar(chave:string):string;
  end;

implementation

{ TClienteDao }

function TCepDAO.Alterar(cep: TCep): Boolean;
var
  FDqry: TFDQuery;
begin
  FDqry := FConexao.CriarQuery();
  try
    FDqry.ExecSQL('UPDATE CEP SET                   '+
                  '    CEP         = '+QuotedStr(cep.CEP)+
                  '   ,LOGRADOURO  = '+QuotedStr(cep.Logradouro)+
                  '   ,COMPLEMENTO = '+QuotedStr(cep.Complemento)+
                  '   ,BAIRRO      = '+QuotedStr(cep.Bairro)+
                  '   ,LOCALIDADE  = '+QuotedStr(cep.Localidade)+
                  '   ,UF          = '+QuotedStr(cep.UF)+
                  '   ,IBGE        = '+IntToStr(cep.IBGE)+
                  ' WHERE (ID = :ID)', [cep.ID]);

    Result := True;
  finally
    FDqry.Free;
  end;
end;

constructor TCepDAO.Create;
begin
   FConexao := TConexaoBanco.Create;
end;

function TCepDAO.Excluir(ID: Integer): Boolean;
var
  FDqry: TFDQuery;
begin
  FDqry := FConexao.CriarQuery();
  try
    FDqry.ExecSQL('DELETE FROM CEP WHERE (ID = :ID)', [ID]);

    Result := True;
  finally
    FDqry.Free;
  end;
end;

function TCepDAO.Incluir(cep: TCep): Boolean;
var
  FDqry: TFDQuery;
begin
  FDqry := FConexao.CriarQuery();
  try
    FDqry.ExecSQL('INSERT INTO CEP (CEP, LOGRADOURO, COMPLEMENTO, BAIRRO, LOCALIDADE, UF, IBGE) VALUES  '+
                  ' (:CEP, :LOGRADOURO, :COMPLEMENTO, :BAIRRO, :LOCALIDADE, :UF, :IBGE)', [cep.CEP,cep.LOGRADOURO,cep.COMPLEMENTO,cep.BAIRRO,cep.LOCALIDADE,cep.UF, cep.IBGE]);

    Result := True;
  finally
    FDqry.Free;
  end;
end;

function TCepDAO.LimparTebela: Boolean;
var
  FDqry: TFDQuery;
begin
  FDqry := FConexao.CriarQuery();
  try
    FDqry.ExecSQL('DELETE FROM CEP;                        '+
                  'UPDATE SQLITE_SEQUENCE SET seq = 1 WHERE name = ''CEP''');

    Result := True;
  finally
    FDqry.Free;
  end;
end;


function TCepDAO.SQLQryCEPGet(filtro:string): String;
begin
  result :=
     '  Select ID,     '+
     '     CEP,        '+
     '     CAST(UF || ''/'' || LOCALIDADE|| ''/'' || LOGRADOURO ||         '+
     '     IIF(IFNULL(COMPLEMENTO,'''') <> '''' ,''-'' || COMPLEMENTO || '', '','', '') || BAIRRO AS VARCHAR(500))     '+
     '     AS ENDERECO '+
     '   FROM CEP      '+
     '   WHERE 1 = 1 '+
     filtro;
end;

function TCepDAO.Filtrar(chave: string): string;
begin
  if chave <> EmptyStr then
  begin
    if StrtointDef(chave, 0) > 0 then
        result := ' AND CEP LIKE ''%'+chave+'%'' '
    else
    begin
       result := ' AND  Lower(CAST(UF || ''/'' || LOCALIDADE|| ''/'' || LOGRADOURO ||           '+
                   '      IIF(IFNULL(COMPLEMENTO,'''') <> '''' ,''-'' || COMPLEMENTO || '', '','', '') || BAIRRO AS VARCHAR(500)))   '+
                   '      LIKE Lower(''%'+chave+'%'') ';
    end;
  end;
end;

end.
