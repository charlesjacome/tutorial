program pushcliente;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitMenuCliente in 'UnitMenuCliente.pas' {FormMenuCliente},
  ClientClassesUnit1 in 'ClientClassesUnit1.pas',
  ClientModuleUnit1 in 'ClientModuleUnit1.pas' {ClientModule1: TDataModule},
  constantes_cliente in 'constantes_cliente.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMenuCliente, FormMenuCliente);
  Application.CreateForm(TClientModule1, ClientModule1);
  Application.Run;
end.
