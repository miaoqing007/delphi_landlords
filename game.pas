unit game;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation, FMX.StdCtrls, System.JSON,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, FMX.Edit,uDSimpleTcpClient,
  System.ImageList, FMX.ImgList, FMX.Objects,tcp,login,handler;

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
  LFrame: TLoginFrame;


implementation

{$R *.fmx}

procedure TGameInterface.FormCreate(Sender: TObject);
begin
    G_TcpMessage:=TcpMessage.Create;
    ExHandler:=executeHandler.Create;
    LFrame := TLoginFrame.Create(Self);
    LFrame.Parent := Self;
    G_TcpMessage.ConnectionService();
    LFrame.BringToFront;
end;

end.
