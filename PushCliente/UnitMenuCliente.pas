unit UnitMenuCliente;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IPPeerClient,
  REST.Backend.PushTypes, System.JSON, REST.Backend.KinveyPushDevice,
  System.PushNotification, FMX.StdCtrls, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Backend.BindSource, REST.Backend.PushDevice,
  REST.Backend.KinveyProvider, FMX.Edit, FMX.Controls.Presentation,
  FMX.ScrollBox, FMX.Memo;

type
  TFormMenuCliente = class(TForm)
    btn_registrar_GCM: TButton;
    edt_token_recebido: TEdit;
    tmr_ativar_GCM: TTimer;
    KinveyProvider_gcm: TKinveyProvider;
    PushEvents_gcm: TPushEvents;
    lbl_1: TLabel;
    Memo_log: TMemo;
    procedure tmr_ativar_GCMTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PushEvents_gcmDeviceTokenReceived(Sender: TObject);
    procedure PushEvents_gcmDeviceTokenRequestFailed(Sender: TObject;
      const AErrorMessage: string);
    procedure btn_registrar_GCMClick(Sender: TObject);
    procedure PushEvents_gcmPushReceived(Sender: TObject;
      const AData: TPushData);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMenuCliente: TFormMenuCliente;











const
  GoogleCloudMessage_AppID =  '537075826758';











implementation

{$R *.fmx}




uses
  ClientModuleUnit1;




procedure TFormMenuCliente.btn_registrar_GCMClick(Sender: TObject);
begin
  ClientModule1.ServerMethods1Client.pr_Registrar_GCM( 1,
                     edt_token_recebido.Text  );

end;









procedure TFormMenuCliente.FormShow(Sender: TObject);
begin
   edt_token_recebido.Text := 'Processando, aguarde...';
   tmr_ativar_GCM.Enabled := true;
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
begin
  Memo_log.Lines.Add(AData.Message);
end;

procedure TFormMenuCliente.tmr_ativar_GCMTimer(Sender: TObject);
begin
  tmr_ativar_GCM.Enabled := False;
  KinveyProvider_gcm.AndroidPush.GCMAppID := GoogleCloudMessage_AppID;
  PushEvents_gcm.Active := True;
end;

end.
