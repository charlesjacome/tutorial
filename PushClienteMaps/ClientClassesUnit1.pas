//
// Created by the DataSnap proxy generator.
// 26/05/2017 22:28:57
//

unit ClientClassesUnit1;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type
  TServerMethods1Client = class(TDSAdminRestClient)
  private
    Fpr_Registrar_GCMCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function pr_Registrar_GCM(id_usuario: Integer; token: string; latidude: string; longitude: string; const ARequestFilter: string = ''): Integer;
  end;

const
  TServerMethods1_pr_Registrar_GCM: array [0..4] of TDSRestParameterMetaData =
  (
    (Name: 'id_usuario'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'token'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'latidude'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'longitude'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 6; TypeName: 'Integer')
  );

implementation

function TServerMethods1Client.pr_Registrar_GCM(id_usuario: Integer; token: string; latidude: string; longitude: string; const ARequestFilter: string): Integer;
begin
  if Fpr_Registrar_GCMCommand = nil then
  begin
    Fpr_Registrar_GCMCommand := FConnection.CreateCommand;
    Fpr_Registrar_GCMCommand.RequestType := 'GET';
    Fpr_Registrar_GCMCommand.Text := 'TServerMethods1.pr_Registrar_GCM';
    Fpr_Registrar_GCMCommand.Prepare(TServerMethods1_pr_Registrar_GCM);
  end;
  Fpr_Registrar_GCMCommand.Parameters[0].Value.SetInt32(id_usuario);
  Fpr_Registrar_GCMCommand.Parameters[1].Value.SetWideString(token);
  Fpr_Registrar_GCMCommand.Parameters[2].Value.SetWideString(latidude);
  Fpr_Registrar_GCMCommand.Parameters[3].Value.SetWideString(longitude);
  Fpr_Registrar_GCMCommand.Execute(ARequestFilter);
  Result := Fpr_Registrar_GCMCommand.Parameters[4].Value.GetInt32;
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TServerMethods1Client.Destroy;
begin
  Fpr_Registrar_GCMCommand.DisposeOf;
  inherited;
end;

end.

