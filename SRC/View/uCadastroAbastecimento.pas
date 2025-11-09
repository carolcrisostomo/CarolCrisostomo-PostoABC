unit uCadastroAbastecimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, FireDAC.Comp.Client,
  Vcl.Buttons, Vcl.Imaging.pngimage;

type
  TfrmCadastroAbastecimento = class(TForm)
    pnlMain: TPanel;
    lblBomba: TLabel;
    lblData: TLabel;
    lblLitros: TLabel;
    lblValor: TLabel;
    lblImposto: TLabel;
    cbBomba: TComboBox;
    dtData: TDateTimePicker;
    edtLitros: TEdit;
    edtValor: TEdit;
    lblValorCombustivel: TLabel;
    btnSalvar: TSpeedButton;
    Image1: TImage;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure edtLitrosExit(Sender: TObject);
    procedure edtLitrosKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton1Click(Sender: TObject);
    procedure cbBombaKeyPress(Sender: TObject; var Key: Char);
    procedure dtDataKeyPress(Sender: TObject; var Key: Char);
    procedure cbBombaChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FValorCombustivel: Double;
    procedure CarregarBombas;
    procedure LimparTela;
    procedure FiltrarNumericosComPontuacao(Sender: TObject; var Key: Char);
    procedure PassarFocoNoEnter(var Key: Char);
    procedure RecuperarValorCombustível;
    procedure ChecarBombaSelecionada;
  public
    { Public declarations }
  end;

var
  frmCadastroAbastecimento: TfrmCadastroAbastecimento;

implementation

{$R *.dfm}

uses uConexao, uAbastecimento;

{ TForm1 }

procedure TfrmCadastroAbastecimento.btnSalvarClick(Sender: TObject);
begin
  if cbBomba.ItemIndex < 0 then
  begin
    ShowMessage('Selecione a bomba.');
    Exit;
  end;
  var lAbastecimento := TAbastecimento.Create;
  try
    var idBombaTanque := Integer(cbBomba.Items.Objects[cbBomba.ItemIndex]);
    lAbastecimento.IdBombaTanque := idBombaTanque;
    lAbastecimento.Data := dtData.Date;
    lAbastecimento.Litros := StrToFloatDef(edtLitros.Text, 0);
    lAbastecimento.Valor := StrToFloatDef(edtValor.Text, 0);
    lAbastecimento.Salvar;
    ShowMessage('Abastecimento salvo com sucesso.');
    LimparTela;
  finally
    lAbastecimento.Free;
  end;

end;

procedure TfrmCadastroAbastecimento.CarregarBombas;
begin
  try
    dmConexao.qryListaBombas.Open;
    cbBomba.Items.Clear;
    while not dmConexao.qryListaBombas.Eof do
    begin
      cbBomba.Items.AddObject(dmConexao.qryListaBombas.FieldByName('IDENTIFICACAO').AsString, TObject(dmConexao.qryListaBombas.FieldByName('IdBombaTanque').AsInteger));
      dmConexao.qryListaBombas.Next;
    end;
  finally
    dmConexao.qryListaBombas.Close;
  end;
end;

procedure TfrmCadastroAbastecimento.cbBombaChange(Sender: TObject);
begin
  RecuperarValorCombustível;
end;

procedure TfrmCadastroAbastecimento.cbBombaKeyPress(Sender: TObject;
  var Key: Char);
begin
  RecuperarValorCombustível;
  PassarFocoNoEnter(Key);
end;

procedure TfrmCadastroAbastecimento.ChecarBombaSelecionada;
begin
  if cbBomba.ItemIndex < 0 then
  begin
    ShowMessage('Selecione a bomba.');
    cbBomba.SetFocus;
    Exit;
  end;
end;

procedure TfrmCadastroAbastecimento.dtDataKeyPress(Sender: TObject;
  var Key: Char);
begin
  PassarFocoNoEnter(Key);
end;

procedure TfrmCadastroAbastecimento.edtLitrosExit(Sender: TObject);
var
  lLitros: Double;
begin
  if cbBomba.ItemIndex < 0 then
    exit;

  if TryStrToFloat(edtLitros.Text, lLitros) then
  begin
     edtValor.Text := Format('%.2f', [lLitros * FValorCombustivel]);
  end;

  if TryStrToFloat(edtValor.Text, FValorCombustivel) then
  begin
    lblImposto.Caption := Format('Imposto (13%%): R$ %.2f', [FValorCombustivel * 0.13]);
  end;

end;
procedure TfrmCadastroAbastecimento.edtLitrosKeyPress(Sender: TObject;
  var Key: Char);
begin
  ChecarBombaSelecionada;
  PassarFocoNoEnter(Key);
  FiltrarNumericosComPontuacao(Sender, Key);
end;

procedure TfrmCadastroAbastecimento.edtValorKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key <> #13) or (Key <> #$D) then
  begin
     Key := #0;
     Exit;
  end;

  btnSalvar.Click;

end;

procedure TfrmCadastroAbastecimento.FormCreate(Sender: TObject);
begin
  CarregarBombas;
  LimparTela;
end;

procedure TfrmCadastroAbastecimento.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #27 then
  begin
    Close;
    Key := #0;
  end;
end;

procedure TfrmCadastroAbastecimento.LimparTela;
begin
  edtLitros.Text := '';
  edtValor.Text := '';
  cbBomba.ItemIndex:= -1;
  dtData.Date := Date;
  lblImposto.Caption := 'Imposto (13%): R$ 0,00';
  lblValorCombustivel.Caption := 'Valor do combustível: R$ 0,00';
end;

procedure TfrmCadastroAbastecimento.SpeedButton1Click(Sender: TObject);
begin
  var lAbastecimento := TAbastecimento.Create;
  try
    var idBombaTanque := Integer(cbBomba.Items.Objects[cbBomba.ItemIndex]);
    lAbastecimento.IdBombaTanque := idBombaTanque;
    lAbastecimento.Data := dtData.Date;
    lAbastecimento.Litros := StrToFloatDef(edtLitros.Text, 0);
    lAbastecimento.Valor := StrToFloatDef(edtValor.Text, 0);
    lAbastecimento.Salvar;
    ShowMessage('Abastecimento salvo com sucesso.');
    LimparTela;
    cbBomba.SetFocus;
  finally
    lAbastecimento.Free;
  end;

end;


procedure TfrmCadastroAbastecimento.FiltrarNumericosComPontuacao(Sender: TObject; var Key: Char);
begin
  if not (Key in [#8, '0'..'9', ',']) then
    begin
      Key := #0;
    end
end;

procedure TfrmCadastroAbastecimento.PassarFocoNoEnter(var Key: Char);
begin
  if Key = #13 then
  begin
    Perform(WM_NEXTDLGCTL, 0, 0);
    Key := #0;
  end;
end;

procedure TfrmCadastroAbastecimento.RecuperarValorCombustível;
begin
  if cbBomba.ItemIndex < 0 then
    Exit;
  var lAbastecimento := TAbastecimento.Create;
  try
    var idBombaTanque := Integer(cbBomba.Items.Objects[cbBomba.ItemIndex]);
    FValorCombustivel:= lAbastecimento.BuscaValorCombustivel(idBombaTanque);
    lblValorCombustivel.Caption := Format('Valor do combustível: R$ %.2f', [FValorCombustivel]);
  finally
    lAbastecimento.Free;
  end;
end;

end.
