object dmConexao: TdmConexao
  Height = 199
  Width = 309
  object FDConnection: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      
        'Database=C:\CarolCrisostomo-PostoABC\CarolCrisostomo-PostoABC\DB' +
        '\POSTOABC.FDB'
      'DriverID=FB')
    LoginPrompt = False
    Left = 54
    Top = 33
  end
  object qryListaBombas: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT'
      '    BT.IdBombaTanque,'
      
        '    B.Descricao || '#39' - '#39' || T.Descricao || '#39' - '#39' || C.Descricao ' +
        'as IDENTIFICACAO,'
      '    C.Valor'
      'FROM'
      '    BombaTanque BT'
      'INNER JOIN'
      '    Tanque T'
      '        ON T.IdTanque = BT.IdTanque'
      'INNER JOIN'
      '    Bomba B'
      '        ON B.IdBomba = BT.IdBomba'
      'INNER JOIN'
      '    Combustivel C'
      '        ON C.IdCombustivel = T.IdCombustivel'
      'ORDER BY'
      '    B.Descricao,'
      '    C.Descricao,'
      '    T.Descricao;')
    Left = 48
    Top = 112
    object qryListaBombasIDBOMBATANQUE: TIntegerField
      FieldName = 'IDBOMBATANQUE'
      Origin = 'IDBOMBATANQUE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryListaBombasIDENTIFICACAO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'IDENTIFICACAO'
      Origin = 'IDENTIFICACAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 116
    end
    object qryListaBombasVALOR: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'VALOR'
      Origin = 'VALOR'
      ProviderFlags = []
      ReadOnly = True
      Precision = 18
      Size = 2
    end
  end
  object qryValorCombustivel: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT'
      '    C.Valor'
      'FROM'
      '    BombaTanque BT'
      'INNER JOIN'
      '    Tanque T'
      '        ON T.IdTanque = BT.IdTanque'
      'INNER JOIN'
      '    Bomba B'
      '        ON B.IdBomba = BT.IdBomba'
      'INNER JOIN'
      '    Combustivel C'
      '        ON C.IdCombustivel = T.IdCombustivel'
      'WHERE '
      '  BT.IdBombaTanque = :IdBombaTanque')
    Left = 160
    Top = 112
    ParamData = <
      item
        Name = 'IDBOMBATANQUE'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object IntegerField1: TIntegerField
      FieldName = 'IDBOMBATANQUE'
      Origin = 'IDBOMBATANQUE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object StringField1: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'IDENTIFICACAO'
      Origin = 'IDENTIFICACAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 116
    end
    object FMTBCDField1: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'VALOR'
      Origin = 'VALOR'
      ProviderFlags = []
      ReadOnly = True
      Precision = 18
      Size = 2
    end
  end
end
