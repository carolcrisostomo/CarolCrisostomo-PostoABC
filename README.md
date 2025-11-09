# Posto ABC - Projeto com Fortes Report integrado

Este pacote foi gerado para RAD Studio 12 (Delphi). O formulário de relatórios (`fRelatorio`) 
já está integrado com o Fortes Report (component TRLReport) e com o TFDQuery `qryRelatorio` 
do DataModule `uConexao`.

## Como usar
1. Extraia o ZIP.
2. Abra `PostoABC.dpr` no RAD Studio 12.
3. Certifique-se de que o pacote Fortes Report CE está instalado no Delphi (componentes RL* disponíveis).
4. Crie o banco executando `db/script_criacao.sql` ou use seu .fdb. (Firebird 3.0)
5. Execute o projeto e use "Relatórios" → "Gerar Relatório".

## Observações
- `db/postoabc.fdb` é um placeholder; crie o DB real com o script.
- O componente RLReport1 no form está configurado para usar `dmConexao.qryRelatorio` como source.
- Ajuste layout do relatório no designer do Fortes Report se desejar.
