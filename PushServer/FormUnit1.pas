unit FormUnit1;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.AppEvnts, Vcl.StdCtrls, IdHTTPWebBrokerBridge, Web.HTTPApp;

type
  TForm1 = class(TForm)
    ButtonStart: TButton;
    ButtonStop: TButton;
    EditPort: TEdit;
    Label1: TLabel;
    ApplicationEvents1: TApplicationEvents;
    ButtonOpenBrowser: TButton;
    edt_token_id: TEdit;
    btn_enviar_mensagem: TButton;
    Edit_latidude: TEdit;
    Edit_longitude: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
    procedure ButtonOpenBrowserClick(Sender: TObject);
    procedure btn_enviar_mensagemClick(Sender: TObject);
  private
    FServer: TIdHTTPWebBrokerBridge;
    procedure StartServer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses

  IdHTTP, IdIOHandler, IdSSL, IdSSLOpenSSL,
  constantes,
  WinApi.Windows, Winapi.ShellApi, Datasnap.DSSession;

procedure TForm1.btn_enviar_mensagemClick(Sender: TObject);
var
  GCN_dHTTP: TIDHTTP;
  lsJson : string;
  JsonToSend: TMemoryStream;
begin
  GCN_dHTTP := TIDHTTP.Create(nil);
  GCN_dHTTP.Request.ContentType :=  'application/json';
  GCN_dHTTP.Request.CharSet := 'utf-8';
  GCN_dHTTP.Request.CustomHeaders.Clear;
  GCN_dHTTP.Request.CustomHeaders.AddValue('Authorization', 'key=' + Aserver_key);
  lsJson := Format('{' +
                   '"tag" : "1",' +
                   '"collapse_key" : "msg",' +
                   '"to" : "%s",' +
                   '"data" : {'+
                              '"message" : "%s", "title" : "Coordenadas", '+
                              '"latitude" : "%s", "longitude" : "%s", '+
                              '}, '+
                              '"delay_while_idle" : true ,' +
                              ' "time_to_live" : 30 ' +
                    '}',
                      [ edt_token_id.Text, 'Texto da mensagem aqui',
                        Edit_latidude.Text,
                        Edit_longitude.Text]);
  JsonToSend := TStringStream.Create(lsJson, TEncoding.UTF8);
  JsonToSend.Position := 0;
  GCN_dHTTP.Post(sendUrl, JsonToSend);
  GCN_dHTTP.DisposeOf;
  JsonToSend.DisposeOf;
end;



procedure TForm1.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  ButtonStart.Enabled := not FServer.Active;
  ButtonStop.Enabled := FServer.Active;
  EditPort.Enabled := not FServer.Active;
end;


procedure TForm1.ButtonOpenBrowserClick(Sender: TObject);
var
  LURL: string;
begin
  StartServer;
  LURL := Format('http://localhost:%s', [EditPort.Text]);
  ShellExecute(0,
        nil,
        PChar(LURL), nil, nil, SW_SHOWNOACTIVATE);
end;

procedure TForm1.ButtonStartClick(Sender: TObject);
begin
  StartServer;
end;

procedure TerminateThreads;
begin
  if TDSSessionManager.Instance <> nil then
    TDSSessionManager.Instance.TerminateAllSessions;
end;

procedure TForm1.ButtonStopClick(Sender: TObject);
begin
  TerminateThreads;
  FServer.Active := False;
  FServer.Bindings.Clear;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FServer := TIdHTTPWebBrokerBridge.Create(Self);
end;

procedure TForm1.StartServer;
begin
  if not FServer.Active then
  begin
    FServer.Bindings.Clear;
    FServer.DefaultPort := StrToInt(EditPort.Text);
    FServer.Active := True;
  end;
end;

end.
