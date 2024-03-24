unit uCep;
interface
  uses System.Math, System.SysUtils;
  Type
  {$M+}
  {$TYPEINFO ON}
  TCep = class
  private
    FID: Integer;
    FCep: String;
    FLogradouro: String;
    FComplemento:string;
    FBairro: String;
    FLocalidade :string;
    FUF: String;
    FIBGE: Integer;
    FGIA: Integer;
    FDDD: Integer;
    FSiafi: Integer;
   {Metodo de validação do CPF}
    procedure SetCep(const Value: String);
    function ValidarCEP(const Value: string): Boolean;
 protected
  public
  published
    property ID          :Integer read FID write FID;
    property Cep         :String read FCep write SetCep;
    property Logradouro  :String read FLogradouro write FLogradouro;
    property Complemento :String read FComplemento write FComplemento;
    property Bairro      :String read FBairro write FBairro;
    property Localidade  :String read FLocalidade write FLocalidade;
    property UF          :String read FUF write FUF;
    property IBGE        :Integer read FIBGE write FIBGE;
    property GIA         :Integer read FGIA write FGIA;
    property DDD         :Integer read FDDD write FDDD;
    property Siafi       :Integer read FSiafi write FSiafi;
  end;
implementation

{ TCep }
procedure TCep.SetCep(const Value: String);
begin
  If ValidarCEP(Value) Then
     FCep := Value
  else
    raise Exception.Create('CEP inválido');
end;

Function TCep.ValidarCEP(const Value: string): Boolean;
var
  I: integer;
  cepAux: string;
begin
  Result := True;
  for I := 1 to Length(Value) do
    if Value[I] in ['0'..'9'] then
      cepAux := cepAux + Value[I];
    if Length(cepAux) <> 8 then
        Result := False;
end;

end.
