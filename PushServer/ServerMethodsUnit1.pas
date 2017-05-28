unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
    DataSnap.DSProviderDataModuleAdapter,
    Datasnap.DSServer, Datasnap.DSAuth;

type
  TServerMethods1 = class(TDSServerModule)
  private
    { Private declarations }
  public
    { Public declarations }
    function pr_Registrar_GCM( id_usuario: integer; token, latidude, longitude:string): integer;
  end;


implementation

{$R *.dfm}

uses FormUnit1;

{ TServerMethods1 }

function TServerMethods1.pr_Registrar_GCM(id_usuario: integer;
  token, latidude, longitude : string): integer;
begin
   Form1.edt_token_id.Text  := token;
   Form1.Edit_longitude.Text:= longitude;
   Form1.Edit_latidude.Text := latidude;
end;

end.

