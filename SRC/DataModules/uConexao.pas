unit uConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TdmConexao = class(TDataModule)
    FDConnection: TFDConnection;
    qryListaBombas: TFDQuery;
    qryListaBombasIDBOMBATANQUE: TIntegerField;
    qryListaBombasIDENTIFICACAO: TStringField;
    qryListaBombasVALOR: TFMTBCDField;
    qryValorCombustivel: TFDQuery;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    FMTBCDField1: TFMTBCDField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmConexao: TdmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses System.IOUtils;

initialization
  dmConexao := TdmConexao.Create(nil);
  dmConexao.FDConnection.Params.DriverID := 'FB';
  dmConexao.FDConnection.Params.Database := TPath.Combine(ExtractFilePath(ParamStr(0)), 'db\postoabc.fdb');
  dmConexao.FDConnection.Params.UserName := 'sysdba';
  dmConexao.FDConnection.Params.Password := 'masterkey';
  dmConexao.FDConnection.LoginPrompt := False;
  dmConexao.FDConnection.Connected:= True;

end.
