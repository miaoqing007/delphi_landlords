unit login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Objects, FMX.Controls.Presentation,tcp,System.JSON;

type
  TLoginFrame = class(TFrame)
    rect_Login: TRectangle;
    userName: TText;
    inputUserName: TEdit;
    password: TText;
    inputPassword: TEdit;
    Rectangle1: TRectangle;
    Image1: TImage;
    Rectangle2: TRectangle;
    Text3: TText;
    Text1: TText;
    procedure Text3Click(Sender: TObject);
  private
    function Login:int16;
    { Private declarations }
  public

    { Public declarations }
  end;

implementation

{$R *.fmx}


procedure TLoginFrame.Text3Click(Sender: TObject);
var
result : int16;
begin
    result:=Login;
    if result=0 then
    begin
         self.Visible:=false
    end
    else if result=-1 then
         begin
           showMessage('用户名或密码不能为空');
         end;

end;


function TLoginFrame.Login:int16;
var
userName : string;
password: string;
LJson: TJsonObject;
begin
  userName:=inputUserName.Text;
  password:=inputPassword.Text;
    if (name='')or (password='') then
    begin
      Result:= -1;
    end
    else
    begin
        LJson:=TJsonObject.Create;
        LJson.AddPair('account',TJsonString.Create(userName));
        LJson.AddPair('password',TJsonString.Create(password));
        G_TcpMessage.SendTcpMessageToService(LJson.ToString,2001);
        LJson.DisposeOf
    end;
end;

end.

