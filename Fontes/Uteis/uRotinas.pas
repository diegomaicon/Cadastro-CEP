unit uRotinas;

interface

uses
   System.SysUtils, uCep ,IdSMTP, IdSSLOpenSSL, IdMessage, IdText, IdAttachmentFile,
   IdExplicitTLSClientServerBase, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
   IdServerIOHandler, IdCoderMIME,  XMLIntf, XMLDoc, uCepXML;

function  Ret_Numero(Key: Char; Texto: string; EhDecimal: Boolean = False): Char;


implementation

function  Ret_Numero(Key: Char; Texto: string; EhDecimal: Boolean = False): Char;
begin
  if  not EhDecimal then
  begin
    {Chr(8) = Back Space}
    if  not ( Key in ['0'..'9', Chr(8)] ) then
      Key := #0
  end;
  Result := Key;
end;

end.
