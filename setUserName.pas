unit setUserName;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Edit,system.JSON,tcp,utoast,
  FMX.Layouts;

type
  TsetUserNameFrame = class(TFrame)
    Edit1: TEdit;
    button: TButton;
    Image1: TImage;
    Layout1: TLayout;
    Text1: TText;
    procedure buttonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TsetUserNameFrame.buttonClick(Sender: TObject);
var
  name:string;
  LJson: TJsonObject;
begin
     name:=Edit1.Text;
     if name='' then
     begin
      Self.Layout1.BringToFront;
      TToast.MakeText(Self.Layout1,'名字不能为空', TToastLength.Toast_LENGTH_LONG);
     end
     else
     begin
         LJson:= TJsonObject.Create;
         LJson.AddPair('msg',name);
         G_TcpMessage.SendTcpMessageToService(LJson.ToString,2013);
         LJson.DisposeOf;
     end;
end;

end.
