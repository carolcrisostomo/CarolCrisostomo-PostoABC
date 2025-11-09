unit uAbastecimento;

interface

uses System.SysUtils, System.Classes;

type
  TAbastecimento = class
  private
    FIdAbastecimento: Integer;
    FIdBombaTanque: Integer;
    FDataAbast: TDateTime;
    FLitros: Double;
    FValor: Double;
    FImposto: Double;
    procedure CalcularImposto;
  public
    property IdAbastecimento: Integer read FIdAbastecimento write FIdAbastecimento;
    property IdBombaTanque: Integer read FIdBombaTanque write FIdBombaTanque;
    property Data: TDateTime read FDataAbast write FDataAbast;
    property Litros: Double read FLitros write FLitros;
    property Valor: Double read FValor write FValor;
    property Imposto: Double read FImposto write FImposto;
    procedure Salvar;
    function BuscaValorCombustivel(pIdBombaTanque: Integer):Real;
    constructor Create;
  end;

implementation

uses uConexao, FireDAC.Comp.Client;

constructor TAbastecimento.Create;
begin
  inherited;
  FDataAbast := Date;
end;

function TAbastecimento.BuscaValorCombustivel(pIdBombaTanque: Integer): Real;
var
  qry: TFDQuery;
begin
  If pIdBombaTanque < 0 then
    Exit(0);
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := dmConexao.FDConnection;
    qry.SQL.add('SELECT');
    qry.SQL.add('    C.Valor');
    qry.SQL.add('FROM ');
    qry.SQL.add('    BombaTanque BT ');
    qry.SQL.add('INNER JOIN ');
    qry.SQL.add('    Tanque T ON T.IdTanque = BT.IdTanque ');
    qry.SQL.add('INNER JOIN ');
    qry.SQL.add('    Combustivel C ON C.IdCombustivel = T.IdCombustivel');
    qry.SQL.add('WHERE');
    qry.SQL.add('    BT.IdBombaTanque = :IdBombaTanque;');
    qry.ParamByName('IdBombaTanque').AsInteger := pIdBombaTanque;
    qry.Open;
    if qry.FieldByName('Valor').AsFloat > 0 then
      result:= qry.FieldByName('Valor').AsFloat;
    qry.Close;
  finally
      FreeAndNil(qry);
  end;
end;

procedure TAbastecimento.CalcularImposto;
begin
  FImposto := FValor * 0.13;
end;

procedure TAbastecimento.Salvar;
var
  qry: TFDQuery;
begin
  CalcularImposto;
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := dmConexao.FDConnection;
    qry.SQL.Text := 'INSERT INTO Abastecimento (IdBombaTanque, DataAbast, Litros, Valor, Imposto) VALUES (:IdBombaTanque, :DataAbast, :Litros, :Valor, :Imposto)';
    qry.ParamByName('IdBombaTanque').AsInteger := FIdBombaTanque;
    qry.ParamByName('DataAbast').AsDate := FDataAbast;
    qry.ParamByName('Litros').AsFloat := FLitros;
    qry.ParamByName('Valor').AsFloat := FValor;
    qry.ParamByName('Imposto').AsFloat := FImposto;
    qry.ExecSQL;
  finally
    qry.Free;
  end;
end;

end.
