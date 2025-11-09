program PostoABC;

uses
  Vcl.Forms,
  uPrincipal in 'SRC\View\uPrincipal.pas' {frmPrincipal},
  uCadastroAbastecimento in 'SRC\View\uCadastroAbastecimento.pas' {frmCadastroAbastecimento},
  uConexao in 'SRC\DataModules\uConexao.pas' {dmConexao: TDataModule},
  uAbastecimento in 'SRC\Model\uAbastecimento.pas',
  fRelatorio in 'SRC\View\fRelatorio.pas' {frmRelatorio},
  uAbastecimentoDAO in 'SRC\DAO\uAbastecimentoDAO.pas',
  uRelAbastecimento in 'SRC\Reports\uRelAbastecimento.pas' {frmRelAbastecimento},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Slate Classico');
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
