unit Principal;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, System.ImageList, Vcl.ImgList, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.WinXCtrls, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.StorageBin, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Imaging.pngimage, System.Actions, Vcl.ActnList, Vcl.CategoryButtons,  System.JSON,
  REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, uCep, StrUtils,
  System.TypInfo, uRotinas, Vcl.Mask, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.DApt, uConexaoBanco, FireDAC.Stan.ExprFuncs, XMLIntf, XMLDoc,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite,
  Data.Bind.DBScope, uCepDAO;
type
  Grud = (tpInsert,tpUpdate,tpDelete);
  TFrmPrincipal = class(TForm)
    dsBusca: TDataSource;
    SV: TSplitView;
    catMenuItems: TCategoryButtons;
    imlIcons: TImageList;
    actAcoes: TActionList;
    actHome: TAction;
    actCadastroLocalidade: TAction;
    actLimpaBanco: TAction;
    imgMenu: TImage;
    panToolbar: TPanel;
    imgMenuPrincipal: TImage;
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    imgFechar: TImage;
    panCentral: TPanel;
    paginas: TPageControl;
    tabHome: TTabSheet;
    tabLista: TTabSheet;
    PanelSuperior: TPanel;
    lblBuscaCEP: TLabel;
    btnFiltrar: TImage;
    edtBusca: TEdit;
    Panel3: TPanel;
    btnFechar: TButton;
    btnDeletar: TButton;
    btnIncluir: TButton;
    dbgLocalidades: TDBGrid;
    tabCadastro: TTabSheet;
    panCadPrincipal: TPanel;
    gpbPrincipal: TGroupBox;
    lblCEP: TLabel;
    imgBuscarCEP: TImage;
    lblLogradouro: TLabel;
    lblComplemento: TLabel;
    lblBairro: TLabel;
    lblLocalidade: TLabel;
    lblUF: TLabel;
    lblBusca: TLabel;
    lblIBGE: TLabel;
    edtLogradouro: TEdit;
    edtComplemento: TEdit;
    edtBairro: TEdit;
    edtLocalidade: TEdit;
    edtUF: TEdit;
    edtCep: TMaskEdit;
    edtIBGe: TEdit;
    panCadBotoes: TPanel;
    btnCancel_exclui: TButton;
    btnSalvar: TButton;
    FDQryCEP: TFDQuery;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    rdgTipoArquivo: TRadioGroup;
    lblTitle: TLabel;
    procedure imgMenuPrincipalClick(Sender: TObject);
    procedure actHomeExecute(Sender: TObject);
    procedure actCadastroLocalidadeExecute(Sender: TObject);
    procedure actLimpaBancoExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure imgBuscarCEPClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure edtCepKeyPress(Sender: TObject; var Key: Char);
    procedure imgFecharClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure catMenuItemsCategoryCollapase(Sender: TObject; const Category: TButtonCategory);
    procedure btnCancel_excluiClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtBuscaChange(Sender: TObject);
    procedure edtCepExit(Sender: TObject);
  private
    { Private declarations }
    FConexao: TConexaoBanco;
    FCepDAO: TCepDAO;
    FCep:  TCep;
    property cep: TCep read FCep write FCep;

    procedure BuscaCep(cep:string);
    procedure Salvar(cep: TCep);
    procedure FechaCadastro;
    procedure AbreCadastro;
    procedure LimpaCampos;
    procedure ListaCEPGet(filtro:String = '');
    procedure Filtrar();

  public
    { Public declarations }
  end;
var
  FrmPrincipal: TFrmPrincipal;

implementation

uses
  uCepXML;


{$R *.dfm}

procedure TFrmPrincipal.actCadastroLocalidadeExecute(Sender: TObject);
begin
   tabLista.TabVisible := True;
   paginas.ActivePage := tabLista;
   ListaCEPGet();
end;

procedure TFrmPrincipal.actHomeExecute(Sender: TObject);
begin
  paginas.ActivePage := tabHome;
end;

procedure TFrmPrincipal.actLimpaBancoExecute(Sender: TObject);
var
   qryLimpaBanco : TFDQuery;
begin

  If Application.MessageBox('Deseja realmente limpar banco ?','Atenção',52)=7 then
    Exit;

  FCepDAO.LimparTebela;

  paginas.ActivePage := tabLista;
  MessageDlg(' Banco limpo com sucesso. ',mtInformation,[mbOk],0);
  actCadastroLocalidadeExecute(nil);
end;

procedure TFrmPrincipal.btnSalvarClick(Sender: TObject);
var
  arquivo:string;
begin
  if Trim(edtLogradouro.Text) = EmptyStr then
  begin
       MessageDlg('Não há registro para salvar !',mtInformation,[mbOk],0);
       exit;
  end;

  cep.Logradouro  := edtLogradouro.Text;
  cep.Complemento := edtComplemento.Text;
  cep.Bairro      := edtBairro.Text;
  cep.Localidade  := edtLocalidade.Text;
  cep.UF          := edtUF.Text;
  cep.IBGE        := StrToInt(edtIBGE.Text);

  Salvar(cep);
  FechaCadastro;
end;

procedure TFrmPrincipal.btnCancel_excluiClick(Sender: TObject);
begin
  If Application.MessageBox('Deseja cancelar cadastro ?','Atenção',52) = 6 then
    FechaCadastro;
end;

procedure TFrmPrincipal.btnDeletarClick(Sender: TObject);
begin
  if FDQryCEP.RecordCount > 0 then
  begin
      try
        If Application.MessageBox('Deseja realmente deletar CEP ?','Atenção',52) = 7 then
          Exit;

        FCepDAO.Excluir(FDQryCEP.FieldByName('ID').AsInteger);

      except on E: Exception do
        MessageDlg(' Falha ao deletar CEP. Erro: '+E.Message, mtError,[mbOk],0);
      end;
      ListaCEPGet();
  end
  else
        MessageDlg('Não há registro para ser deletado !',mtInformation,[mbOk],0);
end;

procedure TFrmPrincipal.btnFecharClick(Sender: TObject);
begin
  tabLista.TabVisible := False;
end;

procedure TFrmPrincipal.btnFiltrarClick(Sender: TObject);
begin
    Filtrar();
end;

procedure TFrmPrincipal.edtBuscaChange(Sender: TObject);
begin
    if  Length(Trim(edtBusca.Text)) >= 3 then
        Filtrar();
end;

procedure TFrmPrincipal.btnIncluirClick(Sender: TObject);
begin
  AbreCadastro;
end;

procedure TFrmPrincipal.FechaCadastro;
begin
  tabCadastro.TabVisible := False;
  tabLista.TabVisible := True;
  paginas.ActivePage := tabLista;
  cep.Free;
  LimpaCampos;
  ListaCEPGet;
  actLimpaBanco.Enabled :=  not tabCadastro.TabVisible;
  actCadastroLocalidade.Enabled  :=not tabCadastro.TabVisible;
  actHome.Enabled  := not tabCadastro.TabVisible;
end;

procedure TFrmPrincipal.Filtrar;
var
    chave:String;
begin
  chave:=  Trim(edtBusca.Text);
  if chave <> EmptyStr then
  begin
     ListaCEPGet(FcepDAO.Filtrar(chave));
  end;
end;

procedure TFrmPrincipal.AbreCadastro;
begin
  tabCadastro.TabVisible := True;
  tabLista.TabVisible := False;
  paginas.ActivePage := tabCadastro;
  cep := TCep.Create;
  actLimpaBanco.Enabled := not tabCadastro.TabVisible;
  actCadastroLocalidade.Enabled :=  not tabCadastro.TabVisible;
  actHome.Enabled  :=  not tabCadastro.TabVisible;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
   FConexao := TConexaoBanco.Create;
   FDQryCEP.Connection := FConexao.GetConexao;
   FCepDAO := TcepDAO.Create;
   ListaCEPGet;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  tabCadastro.TabVisible := False;
  tabLista.TabVisible    := False;
  paginas.ActivePage     := tabHome;
end;

procedure TFrmPrincipal.imgMenuPrincipalClick(Sender: TObject);
begin
  if SV.Opened then
    SV.Close
  else
    SV.Open;
end;

procedure TFrmPrincipal.imgBuscarCEPClick(Sender: TObject);
begin
   try
      lblBusca.Visible := True;
      Application.ProcessMessages;

      try
          cep.Cep := edtCep.text;
      except on E: Exception do
        begin
          MessageDlg(E.Message, mtWarning,[mbOk],0);
          if Pos ('CEP', E.Message) > 0 then
          begin
            if edtCep.CanFocus then edtCep.SetFocus;
            edtCep.Text := EmptyStr;
          end;
          exit;
        end;
      end;

      ListaCEPGet('AND CEP = '+QuotedStr(Trim(cep.Cep)));
      if FDQryCEP.RecordCount = 0 then
          BuscaCep(cep.Cep)
      else
      begin
         If Application.MessageBox(' CEP registrado na base de dados. '+slineBreak+
                                   ' Deseja realmente atualizar ?','Informação',52) = 7 then
         Exit;

         BuscaCep(cep.Cep);
         cep.ID :=  FDQryCEP.FieldByName('ID').AsInteger;
      end;
   finally
      lblBusca.Visible := False;
   end;
end;

procedure TFrmPrincipal.imgFecharClick(Sender: TObject);
begin
  FrmPrincipal.Close;
end;

procedure TFrmPrincipal.LimpaCampos;
var
  i:Word;
begin
  for i := 0 to FrmPrincipal.ComponentCount - 1 do
  begin
    if FrmPrincipal.Components[i] is TEdit then
        TEdit(FrmPrincipal.Components[i]).Text := EmptyStr;

  end;
  edtCep.Text := EmptyStr;
end;

procedure TFrmPrincipal.ListaCEPGet(filtro:String = '');
begin
   with FDQryCEP do
   begin
       if Active then
          Close;

      SQL.Clear;
      SQL.Add(FCepDAO.SQLQryCEPGet(filtro));
      Open;
   end;
end;

procedure TFrmPrincipal.Salvar(cep: TCep);
begin

    if cep.ID = 0 then
    begin
        FCepDAO.Incluir(cep);
    end
    else
    begin
      FCepDAO.Alterar(cep);
    end;

end;


procedure TFrmPrincipal.BuscaCep(cep:string);
var
    retornoJSON:TJSONObject;
    retornoXML: IXMLXmlcep;
    xml:IXMLDocument;
begin
  try
    if Length(cep) < 7 then
    begin
      MessageDlg(' Cep inválido. ',mtInformation,[mbOk],0);
      edtCep.SetFocus;
      Exit;
    end     //JSON
    else if rdgTipoArquivo.ItemIndex = 0 then
    begin
      try
        RESTClient.BaseURL := 'https://viacep.com.br/ws/'+cep+'/json/';
        RESTRequest.Accept := 'application/json';
        RESTRequest.Execute;
        retornoJSON := RESTRequest.Response.JSONValue as TJSONObject;
      except on E: Exception do
        MessageDlg(' Problema ao cuscar cep !'+E.ToString,mtInformation,[mbOk],0);
      end;
      if Assigned(retornoJSON.GetValue('localidade'))  then
      begin
         edtLocalidade.Text   := retornoJSON.GetValue('localidade').Value;
         edtUF.Text       := retornoJSON.GetValue('uf').Value;
         if retornoJSON.GetValue('logradouro') <> nil then
              edtLogradouro.Text := retornoJSON.GetValue('logradouro').Value;
         if retornoJSON.GetValue('bairro') <> nil then
              edtBairro.Text   :=  retornoJSON.GetValue('bairro').Value ;
         if retornoJSON.GetValue('complemento') <> nil then
              edtComplemento.Text   :=  retornoJSON.GetValue('complemento').Value;
         if retornoJSON.GetValue('ibge') <> nil then
              edtibge.Text   :=  retornoJSON.GetValue('ibge').Value ;
      end
      else
      begin
          MessageDlg(' Cep não encontrado !',mtInformation,[mbOk],0);
          edtCep.SetFocus;
          Exit;
      end;
    end    //XML
    else if rdgTipoArquivo.ItemIndex = 1 then
    begin

        try
            RESTClient.BaseURL := 'https://viacep.com.br/ws/'+cep+'/xml/';
            RESTRequest.Accept := 'text/xml';
            RESTRequest.Execute;

            if Pos('localidade', RESTRequest.Response.Content) <> 0 then
            begin
                xml :=  LoadXMLData(RESTRequest.Response.Content);
                retornoXML := Getxmlcep(xml);
            end;

          except on E: Exception do
            MessageDlg(' Problema ao cuscar cep !'+E.ToString,mtInformation,[mbOk],0);
          end;

        if Assigned(retornoXML)  then
        begin
           edtLocalidade.Text   := retornoXML.Localidade;
           edtUF.Text       := retornoXML.uf;
           if retornoXML.Logradouro <> EmptyStr then
                edtLogradouro.Text := retornoXML.Logradouro;
           if retornoXML.bairro <> EmptyStr then
                edtBairro.Text   :=  retornoXML.bairro;
           if retornoXML.complemento <> EmptyStr then
                edtComplemento.Text   :=  retornoXML.complemento ;
           if retornoXML.Ibge > 0 then
                edtibge.Text   :=  inttoStr(retornoXML.Ibge);
        end
        else
        begin
            MessageDlg(' Cep não encontrado !',mtInformation,[mbOk],0);
            edtCep.SetFocus;
            Exit;
        end;
        end
    except on E: Exception do
          MessageDlg(' Problema ao buscar cep !'+E.ToString,mtInformation,[mbOk],0);
    end;
end;

procedure TFrmPrincipal.catMenuItemsCategoryCollapase(Sender: TObject; const Category: TButtonCategory);
begin
  catMenuItems.Categories[0].Collapsed := false;
end;

procedure TFrmPrincipal.edtCepExit(Sender: TObject);
begin
  if Trim(edtCep.text) <> EmptyStr then
      imgBuscarCEPClick(nil);
end;

procedure TFrmPrincipal.edtCepKeyPress(Sender: TObject; var Key: Char);
begin
  Key := Ret_Numero(Key, edtCep.Text);
end;

end.
