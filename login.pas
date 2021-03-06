unit login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Objects, FMX.Controls.Presentation,tcp,System.JSON, FMX.Layouts,system.IOUtils,
  uToast,appfilepath;

type
  TLoginFrame = class(TFrame)
    userName: TText;
    inputUserName: TEdit;
    password: TText;
    inputPassword: TEdit;
    Rectangle1: TRectangle;
    Image1: TImage;
    Rectangle2: TRectangle;
    Text3: TText;
    Layout1: TLayout;


    procedure Text3Click(Sender: TObject);
    procedure Text2Click(Sender: TObject);
    procedure LoginFailed(msg : string);
    procedure ReadJsonFile;
    procedure WriteJsonFile(username,password :string);
    procedure Login(username,password :string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TLoginFrame.Text2Click(Sender: TObject);
begin
//   showMessage('??ʼע??');
end;

procedure TLoginFrame.ReadJsonFile;
var
  m_Json: TJSONObject;
  m_StringStream:      TStringStream;
  pathName,username,password : string;
begin
  pathName:=appfilepath.WinRootLandlordsDir+'loginfile.json';
   if fileExists(pathName) then
  begin
  m_StringStream := TStringStream.Create('', TEncoding.UTF8);
  m_Json := TJSONObject.Create;

  m_StringStream.LoadFromFile(pathName);

  m_Json := TJSONObject.ParseJSONValue(m_StringStream.DataString) as TJSONObject;
  m_json.TryGetValue('username',username);
  m_json.TryGetValue('password',password);

  Login(username,password);

  m_stringstream.DisposeOf;
  m_json.DisposeOf;
  end;
end;


procedure TLoginFrame.WriteJsonFile(username,password :string);
var
  m_Json: TJSONObject;
  m_StringStream:      TStringStream;
begin
  m_StringStream := TStringStream.Create('', TEncoding.UTF8);
  m_Json := TJSONObject.Create;
  m_Json.AddPair('username',username);
  m_Json.AddPair('password',password);

  m_stringStream.Clear;
  m_stringStream.WriteString(m_json.ToString);
  m_stringstream.SaveToFile(appfilepath.WinRootLandlordsDir+'loginfile.json');

  m_stringstream.DisposeOf;
  m_Json.DisposeOf;
end;


procedure TLoginFrame.Text3Click(Sender: TObject);
begin
   Login(inputUsername.Text,inputpassword.Text);
end;


procedure TLoginFrame.Login(username,password :string);
var
LJson: TJsonObject;
begin
    if (username='')or (password='') then
    begin
    Self.LAYOUT1.BringToFront;
    TToast.MakeText(Self.LAYOUT1,'?û????????벻??Ϊ??', TToastLength.Toast_LENGTH_LONG);
    end
    else
    begin
        LJson:=TJsonObject.Create;
        LJson.AddPair('account',TJsonString.Create(userName));
        LJson.AddPair('password',TJsonString.Create(password));
        G_TcpMessage.SendTcpMessageToService(LJson.ToString,2001);
        LJson.DisposeOf;
    end;
end;

procedure TLoginFrame.LoginFailed(msg : string);
begin
  self.Layout1.BringToFront;
  TToast.MakeText(Self.LAYOUT1,msg, TToastLength.Toast_LENGTH_LONG);
end;

end.

