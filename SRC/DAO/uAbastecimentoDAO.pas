unit uAbastecimentoDAO;

interface

uses FireDAC.Comp.Client, System.SysUtils, DateUtils, Dialogs;

type
  TAbastecimentoDAO = class
  public
    procedure ListarPorPeriodo(var AQuery: TFDQuery; ADataIni, ADataFim: TDateTime);
    procedure SomatorioGeral(var AQuery: TFDQuery; ADataIni, ADataFim: TDateTime);
    procedure SomatorioPorBomba(var AQuery: TFDQuery; ADataIni, ADataFim: TDateTime);
  end;

implementation

uses uConexao;

procedure TAbastecimentoDAO.ListarPorPeriodo(var AQuery: TFDQuery; ADataIni, ADataFim: TDateTime);
begin
  AQuery.Connection := dmConexao.FDConnection;
  AQuery.SQL.Clear;
  AQuery.SQL.Add('SELECT');
  AQuery.SQL.Add('    A.IdAbastecimento, ');
  AQuery.SQL.Add('    A.DataAbast,');
  AQuery.SQL.Add('    A.Valor,');
  AQuery.SQL.Add('    A.Litros,');
  AQuery.SQL.Add('    A.Imposto,');
  AQuery.SQL.Add('    T.IdTanque as IdTanque,');
  AQuery.SQL.Add('    T.Descricao as Tanque,');
  AQuery.SQL.Add('    B.IdBomba as IdBomba,');
  AQuery.SQL.Add('    B.Descricao as Bomba,');
  AQuery.SQL.Add('    C.IdCombustivel as IdCombustivel,');
  AQuery.SQL.Add('    C.Descricao as Combustivel');
  AQuery.SQL.Add('FROM');
  AQuery.SQL.Add('    Abastecimento A ');
  AQuery.SQL.Add('INNER JOIN ');
  AQuery.SQL.Add('    BombaTanque BT ON A.IdBombaTanque = BT.IdBombaTanque');
  AQuery.SQL.Add('INNER JOIN');
  AQuery.SQL.Add('    Tanque T ON T.IdTanque = BT.IdTanque ');
  AQuery.SQL.Add('INNER JOIN');
  AQuery.SQL.Add('    Bomba B ON B.IdBomba = BT.IdBomba');
  AQuery.SQL.Add('INNER JOIN');
  AQuery.SQL.Add('    Combustivel C ON C.IdCombustivel = T.IdCombustivel');
  AQuery.SQL.Add('WHERE');
  AQuery.SQL.Add('    A.DataAbast BETWEEN :DataInicio AND :DataFinal');
  AQuery.SQL.Add('ORDER BY ');
  AQuery.SQL.Add('    B.Descricao,');
  AQuery.SQL.Add('    A.DataAbast,');
  AQuery.SQL.Add('    T.Descricao');

  AQuery.ParamByName('DataInicio').AsDate := ADataIni;
  AQuery.ParamByName('DataFinal').AsDate := ADataFim;
  AQuery.Open;
end;

procedure TAbastecimentoDAO.SomatorioGeral(var AQuery: TFDQuery; ADataIni, ADataFim: TDateTime);
begin
  AQuery.Connection := dmConexao.FDConnection;
  AQuery.SQL.Clear;
  AQuery.SQL.Add('SELECT');
  AQuery.SQL.Add('  sum(A.Valor) as TotalValor,  ');
  AQuery.SQL.Add('  sum(A.Litros) as TotalLitros, ');
  AQuery.SQL.Add('  sum(A.Imposto) as TotalImpostos');
  AQuery.SQL.Add('FROM');
  AQuery.SQL.Add('    Abastecimento A ');
  AQuery.SQL.Add('INNER JOIN ');
  AQuery.SQL.Add('    BombaTanque BT ON A.IdBombaTanque = BT.IdBombaTanque');
  AQuery.SQL.Add('INNER JOIN');
  AQuery.SQL.Add('    Tanque T ON T.IdTanque = BT.IdTanque ');
  AQuery.SQL.Add('INNER JOIN');
  AQuery.SQL.Add('    Bomba B ON B.IdBomba = BT.IdBomba');
  AQuery.SQL.Add('INNER JOIN');
  AQuery.SQL.Add('    Combustivel C ON C.IdCombustivel = T.IdCombustivel');
  AQuery.SQL.Add('WHERE');
  AQuery.SQL.Add('    A.DataAbast BETWEEN :DataInicio AND :DataFinal');

  AQuery.ParamByName('DataInicio').AsDate := ADataIni;
  AQuery.ParamByName('DataFinal').AsDate := ADataFim;
  AQuery.Open;
end;


procedure TAbastecimentoDAO.SomatorioPorBomba(var AQuery: TFDQuery; ADataIni, ADataFim: TDateTime);
begin
  AQuery.Connection := dmConexao.FDConnection;
  AQuery.SQL.Clear;
  AQuery.SQL.Add('SELECT');
  AQuery.SQL.Add('  sum(A.Valor) as TotalValor,  ');
  AQuery.SQL.Add('  sum(A.Litros) as TotalLitros, ');
  AQuery.SQL.Add('  sum(A.Imposto) as TotalImpostos');
  AQuery.SQL.Add('FROM');
  AQuery.SQL.Add('    Abastecimento A ');
  AQuery.SQL.Add('INNER JOIN ');
  AQuery.SQL.Add('    BombaTanque BT ON A.IdBombaTanque = BT.IdBombaTanque');
  AQuery.SQL.Add('INNER JOIN');
  AQuery.SQL.Add('    Tanque T ON T.IdTanque = BT.IdTanque ');
  AQuery.SQL.Add('INNER JOIN');
  AQuery.SQL.Add('    Bomba B ON B.IdBomba = BT.IdBomba');
  AQuery.SQL.Add('INNER JOIN');
  AQuery.SQL.Add('    Combustivel C ON C.IdCombustivel = T.IdCombustivel');
  AQuery.SQL.Add('WHERE');
  AQuery.SQL.Add('    A.DataAbast BETWEEN :DataInicio AND :DataFinal');

  AQuery.ParamByName('DataInicio').AsDate := ADataIni;
  AQuery.ParamByName('DataFinal').AsDate := ADataFim;
  AQuery.Open;
end;


end.
