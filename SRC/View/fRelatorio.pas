unit fRelatorio;

interface

uses
  Vcl.Forms, Vcl.StdCtrls, Vcl.ComCtrls, System.Classes, Vcl.ExtCtrls, { RLReport,} FireDAC.Comp.Client,
  Vcl.Controls, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, Vcl.Buttons, Vcl.Imaging.pngimage;

type
  TfrmRelatorio = class(TForm)
    dtIni: TDateTimePicker;
    dtFim: TDateTimePicker;
    SpeedButton1: TSpeedButton;
    Image1: TImage;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
  public
  end;

var
  frmRelatorio: TfrmRelatorio;

implementation

{$R *.dfm}

uses uAbastecimentoDAO, uConexao, System.SysUtils, DateUtils, uAbastecimento,
  uRelAbastecimento;

procedure TfrmRelatorio.Button1Click(Sender: TObject);
begin
   if frmRelAbastecimento.qryRelatorio.Active then
      frmRelAbastecimento.qryRelatorio.Close;
   var Abastecimento :=  TAbastecimentoDAO.Create();
    Abastecimento.ListarPorPeriodo(frmRelAbastecimento.qryRelatorio, dtIni.Date, dtFim.Date);
end;

procedure TfrmRelatorio.FormCreate(Sender: TObject);
begin
  dtIni.Date := StartOfTheMonth(Date);
  dtFim.Date := Date;
end;

procedure TfrmRelatorio.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Close;
    Key := #0;
  end;
end;

procedure TfrmRelatorio.SpeedButton1Click(Sender: TObject);
begin
  if not Assigned(frmRelAbastecimento) then
    Application.CreateForm(TfrmRelAbastecimento, frmRelAbastecimento);
  try
    if frmRelAbastecimento.qryRelatorio.Active then
      frmRelAbastecimento.qryRelatorio.Close;
    var Abastecimento :=  TAbastecimentoDAO.Create();
    Abastecimento.ListarPorPeriodo(frmRelAbastecimento.qryRelatorio, dtIni.Date, dtFim.Date);
    Abastecimento.SomatorioGeral(frmRelAbastecimento.qryTotalGeral, dtIni.Date, dtFim.Date);
    frmRelAbastecimento.RlTitulo.Caption:= 'RESUMO EXECUTIVO - Período: ' + DatetoStr(dtIni.Date) + ' - '  + DateToStr(dtFim.Date);
    frmRelAbastecimento.RLAbastecimento.Preview;
  except
    on E: Exception do
      ShowMessage('Erro ao gerar relatório: ' + E.Message);
  end;
end;

end.
