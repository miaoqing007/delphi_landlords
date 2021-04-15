unit tcp;

interface

uses
 System.Classes, System.SysUtils, uDsimpleTcpClient,handler,System.Generics.Collections,System.JSON;

type TcpMessage = class
private
     FCon: TConnection;
public
    procedure SendTcpMessageToService(data: String;tos : Uint16);
    function ConnectionService:Boolean;
    procedure OnSocketRead(AStream: TMemoryStream);
public
  constructor Create;
  destructor Destroy; override;
  public
    OnRead: TOnReadProc;
end;


var
  G_TcpMessage: TcpMessage;

implementation

uses FMX.Dialogs;


constructor TcpMessage.Create;
begin
  fcon:= TConnection.Create;
  FCon.OnRead := OnSocketRead;

end;

destructor TcpMessage.Destroy;
begin
    fcon.DisposeOf;
  inherited;
end;

procedure TcpMessage.SendTcpMessageToService(data: String;tos :Uint16);
var
  LStr: TStringStream;
  LStream: TMemoryStream;
begin
  if not Fcon.IsConnected then
  begin
    showMessage('服务器断开连接');
    Exit
  end;

  LStr := TStringStream.Create('', TEncoding.UTF8);
  LStr.WriteString(data);
  LStr.Seek(0, 0);

  LStream:=TMemoryStream.Create;

  LStream.Write(tos,SizeOf(Uint16));

  LStream.CopyFrom(LStr, LStr.Size);

  FCon.Write(LStream);

  LStream.DisposeOf;
  LStr.DisposeOf;
end;


procedure TcpMessage.OnSocketRead(AStream: TMemoryStream);
var
  tos: uint16;
  LStr: TStringStream;
begin
  AStream.Seek(0, 0);
  AStream.Read(tos,SizeOf(uint16));
  LStr := TStringStream.Create('', TEncoding.UTF8);
  LStr.CopyFrom(AStream, AStream.Size-AStream.Position);
  LStr.Seek(0, 0);
  ExHandler.CallBackDictionary[tos](Lstr);
  LStr.DisposeOf;
//  v(LStr);

//  case tos of
//  2001:
//  showMessage(Lstr.DataString);
//  2002:
//  end;

//  if Assigned(OnRead) then
//   OnRead(AStream);
//   showmessage(LStr.DataString);

end;

function tcpMessage.ConnectionService:Boolean;
begin
  fcon.ConnectTo('127.0.0.1',51000);
  Result:=fcon.IsConnected;
end;

end.