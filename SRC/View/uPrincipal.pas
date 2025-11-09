unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.Skia,
  Vcl.Skia, Vcl.Buttons, Vcl.ControlList, Vcl.FormTabsBar,
  Vcl.BaseImageCollection, Vcl.ImageCollection, Vcl.VirtualImage;

type
  TfrmPrincipal = class(TForm)
    lblTitle: TLabel;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    procedure btnAbastecimentosClick(Sender: TObject);
    procedure btnRelatoriosClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses uCadastroAbastecimento, fRelatorio;

procedure TfrmPrincipal.btnAbastecimentosClick(Sender: TObject);
begin
  if not Assigned(FrmCadastroAbastecimento) then
    Application.CreateForm(TFrmCadastroAbastecimento, FrmCadastroAbastecimento);
  FrmCadastroAbastecimento.Show;
end;

procedure TfrmPrincipal.btnRelatoriosClick(Sender: TObject);
begin
  if not Assigned(frmRelatorio) then
    Application.CreateForm(TfrmRelatorio, frmRelatorio);
  frmRelatorio.Show;
end;

procedure TfrmPrincipal.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Application.Terminate;
    Key := #0;
  end;
end;

procedure TfrmPrincipal.SpeedButton1Click(Sender: TObject);
begin
  if not Assigned(frmRelatorio) then
    Application.CreateForm(TfrmRelatorio, frmRelatorio);
  frmRelatorio.Show;
end;

procedure TfrmPrincipal.SpeedButton2Click(Sender: TObject);
begin
  if not Assigned(FrmCadastroAbastecimento) then
    Application.CreateForm(TFrmCadastroAbastecimento, FrmCadastroAbastecimento);
  FrmCadastroAbastecimento.Show;
end;

end.
