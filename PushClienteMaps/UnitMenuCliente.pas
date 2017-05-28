unit UnitMenuCliente;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IPPeerClient,
  REST.Backend.PushTypes, System.JSON, REST.Backend.KinveyPushDevice,
  System.PushNotification, FMX.StdCtrls, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Backend.BindSource, REST.Backend.PushDevice,
  REST.Backend.KinveyProvider, FMX.Edit, FMX.Controls.Presentation,
  FMX.ScrollBox, FMX.Memo, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Sensors,
  FMX.WebBrowser, System.Sensors.Components, FMX.TabControl, FMX.Layouts;

type
  TFormMenuCliente = class(TForm)
    btn_registrar_GCM: TButton;
    edt_token_recebido: TEdit;
    tmr_ativar_GCM: TTimer;
    KinveyProvider_gcm: TKinveyProvider;
    PushEvents_gcm: TPushEvents;
    lbl_ubliv: TLabel;
    Memo_log: TMemo;
    Button_navegar: TButton;
    LocationSensor1: TLocationSensor;
    WebBrowser1: TWebBrowser;
    Label_gps_status: TLabel;
    TabControl1: TTabControl;
    TabItem_registra: TTabItem;
    TabItem_Notifica: TTabItem;
    TabItem_mapa: TTabItem;
    Edit_servidor: TEdit;
    Label_ip: TLabel;
    Layout1: TLayout;
    procedure tmr_ativar_GCMTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PushEvents_gcmDeviceTokenReceived(Sender: TObject);
    procedure PushEvents_gcmDeviceTokenRequestFailed(Sender: TObject;
      const AErrorMessage: string);
    procedure btn_registrar_GCMClick(Sender: TObject);
    procedure PushEvents_gcmPushReceived(Sender: TObject;
      const AData: TPushData);
    procedure LocationSensor1LocationChanged(Sender: TObject; const OldLocation,
      NewLocation: TLocationCoord2D);
    procedure Button_navegarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMenuCliente: TFormMenuCliente;

  ENUSLat_inicial, ENUSLong_inicial,
  ENUSLat, ENUSLong: String;


implementation

{$R *.fmx}

uses
  ClientModuleUnit1,   REST.Json,  IdURI,
  constantes_cliente;

procedure TFormMenuCliente.btn_registrar_GCMClick(Sender: TObject);
begin
  ClientModule1.ServerMethods1Client.pr_Registrar_GCM( 1, edt_token_recebido.Text, ENUSLat, ENUSLong  );
end;


procedure TFormMenuCliente.Button_navegarClick(Sender: TObject);
const
  LGoogleMapsDirections: String = 'https://www.google.com/maps/dir/?api=1&origin=%s,%s&destination=%s,%s';
begin
   WebBrowser1.Navigate(TIdURI.URLEncode(
                        Format(LGoogleMapsDirections,
                        [ENUSLat_inicial,ENUSLong_inicial,  ENUSLat, ENUSLong])) );
   TabControl1.ActiveTab := TabItem_mapa;
end;

procedure TFormMenuCliente.FormShow(Sender: TObject);
begin
   ClientModule1.DSRestConnection1.Host := Edit_servidor.Text;
   ClientModule1.DSRestConnection1.Port := 8080;

   TabControl1.ActiveTab := TabItem_registra;
   edt_token_recebido.Text := 'Processando, aguarde...';
   tmr_ativar_GCM.Enabled := true;

end;

procedure TFormMenuCliente.LocationSensor1LocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);
const
  LGoogleMapsURL: String = 'https://maps.google.com/maps?q=%s,%s';
begin
  ENUSLat := NewLocation.Latitude.ToString(ffGeneral, 5, 2, TFormatSettings.Create('en-US'));
  ENUSLong := NewLocation.Longitude.ToString(ffGeneral, 5, 2, TFormatSettings.Create('en-US'));

  ENUSLat_inicial := ENUSLat;
  ENUSLong_inicial :=  ENUSLong;
  Label_gps_status.text := Format('GPS: Lat:%s Lon:%s', [ENUSLat, ENUSLong] );

  LocationSensor1.Active := false;

  WebBrowser1.Navigate(Format(LGoogleMapsURL, [ENUSLat, ENUSLong]));
end;

procedure TFormMenuCliente.PushEvents_gcmDeviceTokenReceived(Sender: TObject);
begin
   edt_token_recebido.Text := PushEvents_gcm.DeviceToken ;
end;

procedure TFormMenuCliente.PushEvents_gcmDeviceTokenRequestFailed(
  Sender: TObject; const AErrorMessage: string);
begin
   ShowMessage('Erro ao registrar');
end;

procedure TFormMenuCliente.PushEvents_gcmPushReceived(Sender: TObject;
  const AData: TPushData);
var
  retorno:string;
  LJSON,
  novojson : TJSONObject;
begin
  TabControl1.ActiveTab := TabItem_Notifica;
  Memo_log.Lines.Clear;
  Memo_log.Lines.Add('Seu roteiro chegou:');
  Memo_log.Lines.Add(AData.GCM.Title);
  Memo_log.Lines.Add(AData.GCM.Message);
  Memo_log.Lines.Add('clique no botão abaixo:');

  LJSON := TJSONObject.Create;
  AData.Extras.Save(LJSON, '');

  ENUSLat := StringReplace( LJSON.GetValue('latitude').ToString, '"', '',[ rfReplaceAll]  );
  ENUSLong:= StringReplace( LJSON.GetValue('longitude').ToString, '"', '',[ rfReplaceAll]  );

  Button_navegar.text := Format('Rota para: Lat:%s Lon:%s', [ENUSLat, ENUSLong] );

  LJSON.Free;

end;

procedure TFormMenuCliente.tmr_ativar_GCMTimer(Sender: TObject);
begin
  tmr_ativar_GCM.Enabled := False;
  KinveyProvider_gcm.AndroidPush.GCMAppID := GoogleCloudMessage_AppID;
  PushEvents_gcm.Active := True;
end;

end.
