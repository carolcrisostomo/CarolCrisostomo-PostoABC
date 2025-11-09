unit uRelAbastecimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Vcl.Imaging.jpeg,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Imaging.pngimage;

type
  TfrmRelAbastecimento = class(TForm)
    RLAbastecimento: TRLReport;
    RLBCabecalho: TRLBand;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLImage1: TRLImage;
    RLLabel4: TRLLabel;
    qryRelatorio: TFDQuery;
    qryRelatorioIDABASTECIMENTO: TIntegerField;
    qryRelatorioDATAABAST: TDateField;
    qryRelatorioVALOR: TFMTBCDField;
    qryRelatorioLITROS: TFMTBCDField;
    qryRelatorioIMPOSTO: TFMTBCDField;
    qryRelatorioIDTANQUE: TIntegerField;
    qryRelatorioTANQUE: TStringField;
    qryRelatorioIDBOMBA: TIntegerField;
    qryRelatorioBOMBA: TStringField;
    qryRelatorioIDCOMBUSTIVEL: TIntegerField;
    qryRelatorioCOMBUSTIVEL: TStringField;
    dsRelatorio: TDataSource;
    RLSystemInfo4: TRLSystemInfo;
    RLGroup1: TRLGroup;
    RLBand1: TRLBand;
    RlDbBomba: TRLDBText;
    RLBand2: TRLBand;
    RlDbData: TRLDBText;
    RlDbTanque: TRLDBText;
    RlDbLitro: TRLDBText;
    RlDbValor: TRLDBText;
    RlDbImposto: TRLDBText;
    RLBand3: TRLBand;
    RLDBResult1: TRLDBResult;
    RLDBResult2: TRLDBResult;
    RLDBResult3: TRLDBResult;
    RLPanel1: TRLPanel;
    qryTotalGeral: TFDQuery;
    dsTotalGeral: TDataSource;
    RLBand4: TRLBand;
    RLDraw1: TRLDraw;
    RLLabel5: TRLLabel;
    RLDBText1: TRLDBText;
    qryTotalGeralTOTALVALOR: TFMTBCDField;
    qryTotalGeralTOTALLITROS: TFMTBCDField;
    qryTotalGeralTOTALIMPOSTOS: TFMTBCDField;
    RLDraw2: TRLDraw;
    RLLabel6: TRLLabel;
    RLDBText2: TRLDBText;
    RLDraw3: TRLDraw;
    RLLabel7: TRLLabel;
    RLDBText3: TRLDBText;
    RlTitulo: TRLLabel;
    RLBand5: TRLBand;
    RlLblData: TRLLabel;
    RlLblTanque: TRLLabel;
    RlLblLitros: TRLLabel;
    RlLblValor: TRLLabel;
    RLLabel1: TRLLabel;
    qryTotalPorBomba: TFDQuery;
    FMTBCDField1: TFMTBCDField;
    FMTBCDField2: TFMTBCDField;
    FMTBCDField3: TFMTBCDField;
    dsTotalPorBomba: TDataSource;
    RLImage2: TRLImage;
    RLDBResult4: TRLDBResult;
    procedure RLSystemInfo4BeforePrint(Sender: TObject; var AText: string;
      var PrintIt: Boolean);
    procedure RLSystemInfo1BeforePrint(Sender: TObject; var AText: string;
      var PrintIt: Boolean);
    procedure RLSystemInfo2BeforePrint(Sender: TObject; var AText: string;
      var PrintIt: Boolean);
    procedure RLDBResult4BeforePrint(Sender: TObject; var AText: string;
      var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelAbastecimento: TfrmRelAbastecimento;

implementation

{$R *.dfm}

uses uConexao;

procedure TfrmRelAbastecimento.RLDBResult4BeforePrint(Sender: TObject;
  var AText: string; var PrintIt: Boolean);
begin
   AText:= 'Total de abastedimento: ' + AText;
end;

procedure TfrmRelAbastecimento.RLSystemInfo1BeforePrint(Sender: TObject;
  var AText: string; var PrintIt: Boolean);
begin
   AText:= 'Data: ' + AText;
end;

procedure TfrmRelAbastecimento.RLSystemInfo2BeforePrint(Sender: TObject;
  var AText: string; var PrintIt: Boolean);
begin
   AText:= 'Hora: ' + AText;
end;

procedure TfrmRelAbastecimento.RLSystemInfo4BeforePrint(Sender: TObject;
  var AText: string; var PrintIt: Boolean);
begin
  AText:= 'Página: ' + AText;
end;

end.
