
{***********************************************************************************}
{                                                                                   }
{                                 XML Data Binding                                  }
{                                                                                   }
{         Generated on: 22/03/2024 20:55:47                                         }
{       Generated from: C:\Users\diego\Documents\SoftPlan\Cadastro-CEP\CepXML.xsd   }
{   Settings stored in: C:\Users\diego\Documents\SoftPlan\Cadastro-CEP\CepXML.xdb   }
{                                                                                   }
{***********************************************************************************}

unit uCepXML;

interface

uses Xml.xmldom, Xml.XMLDoc, Xml.XMLIntf;

type

{ Forward Decls }

  IXMLXmlcep = interface;

{ IXMLXmlcep }

  IXMLXmlcep = interface(IXMLNode)
    ['{40046BC2-C95A-4644-BA81-1D9FD6B82526}']
    { Property Accessors }
    function Get_Cep: UnicodeString;
    function Get_Logradouro: UnicodeString;
    function Get_Complemento: UnicodeString;
    function Get_Bairro: UnicodeString;
    function Get_Localidade: UnicodeString;
    function Get_Uf: UnicodeString;
    function Get_Ibge: LongWord;
    function Get_Gia: Word;
    function Get_Ddd: Byte;
    function Get_Siafi: Word;
    procedure Set_Cep(const Value: UnicodeString);
    procedure Set_Logradouro(const Value: UnicodeString);
    procedure Set_Complemento(const Value: UnicodeString);
    procedure Set_Bairro(const Value: UnicodeString);
    procedure Set_Localidade(const Value: UnicodeString);
    procedure Set_Uf(const Value: UnicodeString);
    procedure Set_Ibge(const Value: LongWord);
    procedure Set_Gia(const Value: Word);
    procedure Set_Ddd(const Value: Byte);
    procedure Set_Siafi(const Value: Word);
    { Methods & Properties }
    property Cep: UnicodeString read Get_Cep write Set_Cep;
    property Logradouro: UnicodeString read Get_Logradouro write Set_Logradouro;
    property Complemento: UnicodeString read Get_Complemento write Set_Complemento;
    property Bairro: UnicodeString read Get_Bairro write Set_Bairro;
    property Localidade: UnicodeString read Get_Localidade write Set_Localidade;
    property Uf: UnicodeString read Get_Uf write Set_Uf;
    property Ibge: LongWord read Get_Ibge write Set_Ibge;
    property Gia: Word read Get_Gia write Set_Gia;
    property Ddd: Byte read Get_Ddd write Set_Ddd;
    property Siafi: Word read Get_Siafi write Set_Siafi;
  end;

{ Forward Decls }

  TXMLXmlcep = class;

{ TXMLXmlcep }

  TXMLXmlcep = class(TXMLNode, IXMLXmlcep)
  protected
    { IXMLXmlcep }
    function Get_Cep: UnicodeString;
    function Get_Logradouro: UnicodeString;
    function Get_Complemento: UnicodeString;
    function Get_Bairro: UnicodeString;
    function Get_Localidade: UnicodeString;
    function Get_Uf: UnicodeString;
    function Get_Ibge: LongWord;
    function Get_Gia: Word;
    function Get_Ddd: Byte;
    function Get_Siafi: Word;
    procedure Set_Cep(const Value: UnicodeString);
    procedure Set_Logradouro(const Value: UnicodeString);
    procedure Set_Complemento(const Value: UnicodeString);
    procedure Set_Bairro(const Value: UnicodeString);
    procedure Set_Localidade(const Value: UnicodeString);
    procedure Set_Uf(const Value: UnicodeString);
    procedure Set_Ibge(const Value: LongWord);
    procedure Set_Gia(const Value: Word);
    procedure Set_Ddd(const Value: Byte);
    procedure Set_Siafi(const Value: Word);
  end;

{ Global Functions }

function Getxmlcep(Doc: IXMLDocument): IXMLXmlcep;
function Loadxmlcep(const FileName: string): IXMLXmlcep;
function Newxmlcep: IXMLXmlcep;

const
  TargetNamespace = '';

implementation

uses System.Variants, System.SysUtils, Xml.xmlutil;

{ Global Functions }

function Getxmlcep(Doc: IXMLDocument): IXMLXmlcep;
begin
  Result := Doc.GetDocBinding('xmlcep', TXMLXmlcep, TargetNamespace) as IXMLXmlcep;
end;

function Loadxmlcep(const FileName: string): IXMLXmlcep;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('xmlcep', TXMLXmlcep, TargetNamespace) as IXMLXmlcep;
end;

function Newxmlcep: IXMLXmlcep;
begin
  Result := NewXMLDocument.GetDocBinding('xmlcep', TXMLXmlcep, TargetNamespace) as IXMLXmlcep;
end;

{ TXMLXmlcep }

function TXMLXmlcep.Get_Cep: UnicodeString;
begin
  Result := ChildNodes['cep'].Text;
end;

procedure TXMLXmlcep.Set_Cep(const Value: UnicodeString);
begin
  ChildNodes['cep'].NodeValue := Value;
end;

function TXMLXmlcep.Get_Logradouro: UnicodeString;
begin
  Result := ChildNodes['logradouro'].Text;
end;

procedure TXMLXmlcep.Set_Logradouro(const Value: UnicodeString);
begin
  ChildNodes['logradouro'].NodeValue := Value;
end;

function TXMLXmlcep.Get_Complemento: UnicodeString;
begin
  Result := ChildNodes['complemento'].Text;
end;

procedure TXMLXmlcep.Set_Complemento(const Value: UnicodeString);
begin
  ChildNodes['complemento'].NodeValue := Value;
end;

function TXMLXmlcep.Get_Bairro: UnicodeString;
begin
  Result := ChildNodes['bairro'].Text;
end;

procedure TXMLXmlcep.Set_Bairro(const Value: UnicodeString);
begin
  ChildNodes['bairro'].NodeValue := Value;
end;

function TXMLXmlcep.Get_Localidade: UnicodeString;
begin
  Result := ChildNodes['localidade'].Text;
end;

procedure TXMLXmlcep.Set_Localidade(const Value: UnicodeString);
begin
  ChildNodes['localidade'].NodeValue := Value;
end;

function TXMLXmlcep.Get_Uf: UnicodeString;
begin
  Result := ChildNodes['uf'].Text;
end;

procedure TXMLXmlcep.Set_Uf(const Value: UnicodeString);
begin
  ChildNodes['uf'].NodeValue := Value;
end;

function TXMLXmlcep.Get_Ibge: LongWord;
begin
  Result := ChildNodes['ibge'].NodeValue;
end;

procedure TXMLXmlcep.Set_Ibge(const Value: LongWord);
begin
  ChildNodes['ibge'].NodeValue := Value;
end;

function TXMLXmlcep.Get_Gia: Word;
begin
  Result := XmlStrToInt(ChildNodes['gia'].Text);
end;

procedure TXMLXmlcep.Set_Gia(const Value: Word);
begin
  ChildNodes['gia'].NodeValue := Value;
end;

function TXMLXmlcep.Get_Ddd: Byte;
begin
  Result := XmlStrToInt(ChildNodes['ddd'].Text);
end;

procedure TXMLXmlcep.Set_Ddd(const Value: Byte);
begin
  ChildNodes['ddd'].NodeValue := Value;
end;

function TXMLXmlcep.Get_Siafi: Word;
begin
  Result := XmlStrToInt(ChildNodes['siafi'].Text);
end;

procedure TXMLXmlcep.Set_Siafi(const Value: Word);
begin
  ChildNodes['siafi'].NodeValue := Value;
end;

end.