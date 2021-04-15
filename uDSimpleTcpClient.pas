unit uDSimpleTcpClient;

interface

uses
  System.Classes, System.SysUtils, FMX.Dialogs, System.SyncObjs, System.Generics.Collections, System.Threading, FMX.Forms, FMX.Types, IdTCPClient, IdGlobal, uWaitingGroup;


const
  MaxSize: Integer = 1024*1024;
  MaxRead: Integer = 1024*1024*20;


type TOnReadProc = procedure(AStream: TMemoryStream) of object;

type TConnection = class
  private
    { Private declarations }
    FClient: TIdTCPClient;
    FTempStream: TMemoryStream;
    FOnRead: TOnReadProc;
    FOnDisconnected: TNotifyEvent;
    FThread: TThread;
    FExitSignal: Boolean;
    FExited: Boolean;
    FRunning: Boolean;
    FSendQueue: TQueue<TMemoryStream>;
    FMutex: TMutex;
    FGroup: TWaitGroup;
    FIp: string;
    FPort: Word;
  private
    function getDisConnected: TNotifyEvent;
    procedure setDisConnected(const Value: TNotifyEvent);
    function getConnected: TNotifyEvent;
    procedure setConnected(const Value: TNotifyEvent);
    function getIsConnected: Boolean;
  private
    function ReadBytesWrap(AByteCount: Integer): Boolean;
    function ReadNBytes(ACount: Integer): Boolean;
    procedure DoReconnect;
    procedure HandleMsg;
    function ParseHeader: Boolean;
    function PasreLength: Boolean;
    procedure HandleReadCompleteData;
    function GetClientConnected: Boolean;
    procedure ReConnect;
    procedure TryReConnected;
  public
    constructor Create;
    destructor  Destroy; override;
  public
    procedure ConnectTo(Ip: string; Port: Word);
    procedure ResetIpPort(Ip: string; Port: Word);
    procedure Write(AStream: TMemoryStream);
  public
    property OnDisConnected: TNotifyEvent read getDisConnected write setDisConnected;
    property OnConnected: TNotifyEvent read getConnected write setConnected;
    property OnRead: TOnReadProc read FOnRead write FOnRead;
    property IsConnected: Boolean read getIsConnected;
  end;

implementation

{ TConnection }

constructor TConnection.Create;
begin
  FThread := nil;
  FClient := TIdTCPClient.Create(nil);
  FClient.ReadTimeout := 20;
  FTempStream := TMemoryStream.Create;
  FSendQueue := TQueue<TMemoryStream>.Create;
  FMutex := TMutex.Create;
  FGroup := TWaitGroup.Create;
end;

destructor TConnection.Destroy;
begin
  FExitSignal := True;
  FGroup.WaitDone;
//  while FRunning and (not FExited) do
//  begin
//    //
//  end;

  FClient.DisposeOf;
  FTempStream.DisposeOf;
  FSendQueue.DisposeOf;
  FMutex.DisposeOf;
  FGroup.DisposeOf;

  inherited;
end;

procedure TConnection.DoReconnect;
begin
 if FExitSignal then
 Exit;

  if Assigned(FOnDisconnected) then
  begin
    TThread.Synchronize(nil, procedure
    begin
      FOnDisconnected(Self);
    end);
  end;

  FTempStream.Clear;

  TryReConnected;

end;

function TConnection.GetClientConnected: Boolean;
begin
  try
    Exit(FClient.Connected);
  except
    Exit(False);
  end;
end;

function TConnection.getConnected: TNotifyEvent;
begin
  Result := FClient.OnConnected;
end;

function TConnection.getDisConnected: TNotifyEvent;
begin
  Result := FOnDisconnected;
end;

function TConnection.getIsConnected: Boolean;
begin
  Result := GetClientConnected;
end;

procedure TConnection.HandleMsg;
begin
  if FThread <> nil then
  Exit;

  FGroup.Add(2);
  FRunning := True;

  TThread.CreateAnonymousThread(procedure
  var
    LStream: TMemoryStream;
  begin
    try
 
      while not FExitSignal do
      begin
        Sleep(2);
        FMutex.Acquire;
     
        try
           if FSendQueue.Count > 0 then
           begin
             try
               LStream := FSendQueue.Dequeue;
               try
                FClient.IOHandler.Write(LStream);
               except

               end;

             finally
               LStream.DisposeOf;
             end;

           end;          
        finally
          FMutex.Release;
        end;
        
      end;
    finally
      FGroup.Done;
    end;

  end).Start;

  FThread := TThread.CreateAnonymousThread(procedure
  begin

    try
      while True do
      begin
        try

          ReadNBytes(2);

          if FExitSignal then
          begin
            FExited := True;
            Exit;
          end;


          if not ParseHeader then
          begin
            Sleep(1);
            Continue;
          end;

          ReadNBytes(4);

          if FExitSignal then
          begin
            FExited := True;
            Exit;
          end;

          if not PasreLength then
          begin
            Sleep(1);
            Continue;
          end;

          if FExitSignal then
          begin
            FExited := True;
            Exit;
          end;

          TThread.Synchronize(nil, procedure
          begin
            HandleReadCompleteData;
          end);

        finally

        end;



      end;

    finally
      FGroup.Done;
    end;


  end);

  FThread.Start;
end;

procedure TConnection.HandleReadCompleteData;
begin
  if FTempStream.Size <= 0 then
  Exit;

  if Assigned(FOnRead) then
    FOnRead(FTempStream);
end;

function TConnection.ParseHeader: Boolean;
var
  LByte1: Byte;
  LByte2: Byte;
begin
  FTempStream.Read(LByte1, 1);
  FTempStream.Read(LByte2, 1);
  if LByte1 <> $EB then
  Exit(False);

  if LByte2 <> $90 then
  Exit(False);

  Exit(True);
end;

function TConnection.PasreLength: Boolean;
var
  LLen: Cardinal;
begin
  LLen := 0;
  FTempStream.Read(LLen, SizeOf(Cardinal));
  //fmx.Types.Log.d('BodySize: %d', [LLen]);
  if LLen > MaxRead then
  Exit(False);

  ReadNBytes(LLen);

  Exit(True);
end;

function TConnection.ReadBytesWrap(AByteCount: Integer): Boolean;
var
  I: Integer;
  LBytes: TIdBytes;
  LByte: Byte;
begin
  if FClient.IOHandler <> nil then
  begin

    try
      FMutex.Acquire;
      try
        FClient.IOHandler.ReadBytes(LBytes, AByteCount, False);
      except
        Exit(False);
      end;
    finally
      FMutex.Release;
    end;


    for I := Low(LBytes) to High(LBytes) do
    begin
      LByte := LBytes[I];
      FTempStream.Write(LByte, 1);
    end;

    Exit(True);

  end;

  Exit(False);
end;

function TConnection.ReadNBytes(ACount: Integer): Boolean;
var
  LBytes: TIdBytes;
  LByte: Integer;
  I: Integer;
begin
  FTempStream.Clear;
  while FTempStream.Size < ACount do
  begin
    if FExitSignal then
    Exit;

    if not GetClientConnected() then
    begin
      DoReconnect;
      Continue;
    end;

    ReadBytesWrap(ACount);

   // Sleep(1);
  end;


  if FTempStream.Size <> ACount then
  begin
    TThread.Synchronize(nil, procedure
    begin
      ShowMessage('????????');
    end);
  end;
  FTempStream.Seek(LongInt(0), 0);
end;

procedure TConnection.ReConnect;
begin
  Sleep(1);

  FClient.Host := FIp;
  FClient.Port := FPort;

  try
    FClient.Disconnect;
    Sleep(1);
  except
    FClient.Connect;
  end;

  FClient.Connect;
end;

procedure TConnection.ResetIpPort(Ip: string; Port: Word);
begin
  FIp := Ip;
  FPort := Port;
end;

procedure TConnection.ConnectTo(Ip: string; Port: Word);
begin
  try
    if FClient.Connected then
    Exit;
  except
    Exit;
  end;


  FClient.Host := Ip;
  FClient.Port := Port;
  FIp := Ip;
  FPort := Port;

  try
    try
      FClient.Disconnect;
    except

    end;
  finally
    FClient.Connect;
    HandleMsg;
  end;
end;

procedure TConnection.setConnected(const Value: TNotifyEvent);
begin
  FClient.OnConnected := Value;
end;

procedure TConnection.setDisConnected(const Value: TNotifyEvent);
begin
  FOnDisconnected := Value;
end;

procedure TConnection.TryReConnected;
begin
  while not FExited do
  begin
    try
      ReConnect;
    except
      Continue;
    end;

    Exit;
  end;

end;

procedure TConnection.Write(AStream: TMemoryStream);
var
  LStream: TMemoryStream;
begin
  AStream.Seek(LongInt(0), 0);
  FMutex.Acquire;
     LStream := TMemoryStream.Create;
     LStream.CopyFrom(AStream, AStream.Size);
     FSendQueue.Enqueue(LStream);
  FMutex.Release;
end;


end.
