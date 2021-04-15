unit game;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation, FMX.StdCtrls, System.JSON,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, FMX.Edit,uDSimpleTcpClient,
  System.ImageList, FMX.ImgList, FMX.Objects,tcp,login;

type
  TGameInterface = class(TForm)
    Memo1: TMemo;
    Button2: TButton;
    Memo2: TMemo;
    ImageControl1: TImageControl;
    Image1: TImage;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

  private
//    procedure OnSocketRead(AStream: TMemoryStream);
  public
    { Public declarations }
  end;

var
  GameInterface: TGameInterface;


implementation

{$R *.fmx}

procedure TGameInterface.FormCreate(Sender: TObject);
var
  LFrame: TLoginFrame;
begin
    G_TcpMessage:=TcpMessage.Create;
//    G_TcpMessage.OnRead := G_TcpMessage.OnSocketRead;
     LFrame := TLoginFrame.Create(Self);
    LFrame.Parent := Self;
    if not G_TcpMessage.ConnectionService()then
    begin
//         LFrame.Text1.Visible:=true;
    end;
    LFrame.BringToFront;
end;

//procedure TGameInterface.OnSocketRead(AStream: TMemoryStream);
//var
//  LJson: TJsonObject;
//begin


//  if Cmd = Login then
//    begin
//      if Success then
//
//    end;
//var by :Byte;
//var
//  LStr: TStringStream;
//begin
//   LStr := TStringStream.Create('', TEncoding.UTF8);
//   LStr.CopyFrom(AStream, AStream.Size);
//   Memo2.Lines.Add(LStr.DataString);
//   LStr.DisposeOf;
//end;

end.
