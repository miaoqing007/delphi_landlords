unit handler;

interface

uses uDSimpleTcpClient,System.Classes,System.SysUtils,System.Generics.Collections,
FMX.Dialogs,system.JSON;

type  executeFunction= procedure(LStr :TStringStream) of object;

type executeHandler = class
  private

  public
  CallBackDictionary: TDictionary<int16,executeFunction>;
  procedure dealwithAfterLogin(LStr:TStringStream);
  procedure AddCallBackDictionary;
  constructor Create;
  destructor Destroy; override;
end;


var ExHandler :executeHandler;

implementation

uses game;

constructor executeHandler.Create;
begin
   CallBackDictionary:= TDictionary<int16,executeFunction>.Create;
   AddCallBackDictionary();
end;

destructor executeHandler.Destroy;
begin
   CallBackDictionary.DisposeOf;
   inherited;
end;

procedure executeHandler.AddCallBackDictionary();
begin
   CallBackDictionary.Add(2002,dealwithAfterLogin);
end;

procedure executeHandler.dealwithAfterLogin(LStr:TStringStream);
var
  js: TJsonObject;
  msg: string;

begin
    js:=TJsonObject.ParseJSONValue(Lstr.DataString) as TJsonObject;
    js.TryGetValue('f_msg',msg);
//    LFrame.Visible=false;
    showMessage(msg);
    js.DisposeOf;
    end;
end.
