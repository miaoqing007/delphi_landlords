unit game;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation, FMX.StdCtrls, System.JSON,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, FMX.Edit,uDSimpleTcpClient,
  System.ImageList, FMX.ImgList, FMX.Objects,tcp,login,handler,user,setUserName,room;

type
  TGameInterface = class(TForm)
    MySelf: TMemo;
    Image1: TImage;
    PlayerOne: TMemo;
    PlayerTwo: TMemo;
    StartGame: TButton;
    outOfCard: TButton;
    GiveUpCard: TButton;
    Memo1: TMemo;
    Rectangle1: TRectangle;
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure StartGameClick(Sender: TObject);

  private
    { Private declarations }
     image1ClickCount:integer;
  private
//    procedure OnSocketRead(AStream: TMemoryStream);
  public
    { Public declarations }
  end;

var
  GameInterface: TGameInterface;
  LFrame: TLoginFrame;
  SName:TsetUserNameFrame;


implementation

{$R *.fmx}

procedure TGameInterface.FormCreate(Sender: TObject);
begin
    G_TcpMessage := TcpMessage.Create;
    ExHandler := executeHandler.Create;
    UI := UserInfo.Create;
    RM := rmInfo.Create;

    G_TcpMessage.ConnectionService();

    LFrame := TLoginFrame.Create(Self);
    LFrame.Parent := Self;

    SName:=TsetUserNameFrame.Create(Self);
    SName.Parent:=Self;

    SName.BringToFront;
    LFrame.BringToFront;
end;

procedure TGameInterface.FormDestroy(Sender: TObject);
begin
    G_TcpMessage.DisposeOf;
end;

procedure TGameInterface.Image1Click(Sender: TObject);
begin
      if (Image1ClickCount mod 2=0) then
       begin
        Image1.Position.Y:=Image1.Position.Y-40;
       end
       else
       begin
         Image1.Position.Y:=Image1.Position.Y+40;
       end;
       Image1ClickCount:= image1ClickCount+1;
       if Image1ClickCount=2 then
       begin
         Image1ClickCount:=0;
       end;

end;

procedure TGameInterface.StartGameClick(Sender: TObject);
//var
//  js:TJsonObject;
begin
//     js:=TJsonObject.Create;
       G_TcpMessage.SendTcpMessageToService('',2003);
end;

end.

