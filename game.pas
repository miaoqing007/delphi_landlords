unit game;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation, FMX.StdCtrls, System.JSON,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, FMX.Edit,uDSimpleTcpClient,
  System.ImageList, FMX.ImgList, FMX.Objects,tcp,login,handler,user,setUserName,card,
  common,room;

type
  TGameInterface = class(TForm)
    StartGame: TButton;
    outOfCard: TButton;
    giveUpCard: TButton;
    cancelMatch: TButton;
    AniIndicator1: TAniIndicator;
    Text1: TText;

    dawang: TImage;
    xiaowang: TImage;

    three_1: TImage;
    three_2: TImage;
    three_4: TImage;
    three_3: TImage;

    four_1: TImage;
    four_2: TImage;
    four_3: TImage;
    four_4: TImage;

    five_1: TImage;
    five_2: TImage;
    five_3: TImage;
    five_4: TImage;

    six_1: TImage;
    six_2: TImage;
    six_3: TImage;
    six_4: TImage;

    seven_1: TImage;
    seven_2: TImage;
    seven_3: TImage;
    seven_4: TImage;

    eight_1: TImage;
    eight_2: TImage;
    eight_3: TImage;
    eight_4: TImage;

    nine_1: TImage;
    nine_2: TImage;
    nine_3: TImage;
    nine_4: TImage;

    ten_1: TImage;
    ten_2: TImage;
    ten_3: TImage;
    ten_4: TImage;

    J_1: TImage;
    J_2: TImage;
    J_3: TImage;
    J_4: TImage;

    Q_1: TImage;
    Q_2: TImage;
    Q_3: TImage;
    Q_4: TImage;

    K_1: TImage;
    K_2: TImage;
    K_3: TImage;
    K_4: TImage;

    A_1: TImage;
    A_2: TImage;
    A_3: TImage;
    A_4: TImage;

    two_1: TImage;
    two_2: TImage;
    two_3: TImage;
    two_4: TImage;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure StartGameClick(Sender: TObject);
    procedure cancelMatchClick(Sender: TObject);
    procedure showHoleCards(images : Tarray<string>);
    procedure showMyCards(images : Tarray<string>);
    procedure FormResize(Sender: TObject);
    procedure dawangClick(Sender: TObject);
    procedure ClickCard(Sender: TObject);
    procedure EvaluationImageTagString();

  private
    { Private declarations }
//     image1ClickCount:integer;
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


procedure TGameInterface.dawangClick(Sender: TObject);
begin
//      rm.cardsClickCountMap[]
      dawang.Position.Y:=dawang.Position.Y-50;
end;

procedure TGameInterface.FormCreate(Sender: TObject);
begin
    G_TcpMessage := TcpMessage.Create;
    ExHandler := executeHandler.Create;
    UI := UserInfo.Create;
    CM:=cmFunction.Create;
    CI:=CardInfo.Create;

    G_TcpMessage.ConnectionService();

    EvaluationImageTagString();

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

procedure TGameInterface.FormResize(Sender: TObject);
  var
  uid : string;
begin
    if ui=nil then
    begin
      exit;
    end;
    uid := ui.GetUserId();
    if (uid = '') or (rm = nil)  then
    begin
      exit;
    end
    else if (rm.playerMap<>nil) and (rm.playerMap.ContainsKey(uid)) then
      begin
         showMyCards(rm.playerMap[uid].cards);
         showHoleCards(rm.holeCards);
      end;
end;

procedure TGameInterface.StartGameClick(Sender: TObject);
//var
//  js:TJsonObject;
begin
//     js:=TJsonObject.Create;
       G_TcpMessage.SendTcpMessageToService('',2003);
       AniIndicator1.Visible:=true;
       AniIndicator1.Enabled:=true;
       startGame.Visible:=false;
       cancelMatch.Visible := true;
end;

procedure TGameInterface.ClickCard(Sender: TObject);
begin
      if rm.cardsClickCountMap[TImage(Sender).TagString] then
      begin
         TImage(Sender).Position.Y:=TImage(Sender).Position.Y - 40;
         rm.cardsClickCountMap[TImage(Sender).TagString] := false;
      end
      else
      begin
        TImage(Sender).Position.Y := TImage(Sender).Position.Y + 40;
         rm.cardsClickCountMap[TImage(Sender).TagString] := true;
      end;
end;

procedure TGameInterface.cancelMatchClick(Sender: TObject);
begin
     G_TcpMessage.SendTcpMessageToService('',2008);
     AniIndicator1.Enabled:=false;
     AniIndicator1.Visible:=false;
end;

procedure  TGameInterface.showHoleCards(images : Tarray<string>) ;
begin
//
end;

procedure TGameInterface.showMyCards(images : Tarray<string>);
var
 i : integer;
 cardslength : single;
 totalCardsLength : single;
 marginLeft : single;
begin
  if length(images)=0 then
  begin
    exit;
  end;

    totalCardsLength :=(Length(images)-1)* 30 + 80;

    marginLeft := (self.Width-totalCardsLength) / 2;

  for i := 0 to High(images) do
      begin
         CI.cardMap[images[i]].Position.X := marginleft + i * 30;
         CI.cardMap[images[i]].Position.Y := self.Height-200;
         CI.cardMap[images[i]].Width := 80;
         CI.cardMap[images[i]].Height := 150;
         CI.cardMap[images[i]].WrapMode:=TImageWrapMode.Stretch;
         Ci.cardMap[images[i]].Visible := true;
         CI.cardMap[images[i]].BringToFront;
      end;
end;

procedure TGameInterface.EvaluationImageTagString();
begin
    dawang.TagString:= 'Q88';
    xiaowang.TagString:= 'K99';

    three_1.TagString:= 'A3';
    three_2.TagString:= 'B3';
    three_3.TagString:= 'C3';
    three_4.TagString:= 'D3';


    four_1.TagString:= 'A4';
    four_2.TagString:= 'B4';
    four_3.TagString:= 'C4';
    four_4.TagString:= 'D4';

    five_1.TagString:= 'A5';
    five_2.TagString:= 'B5';
    five_3.TagString:= 'C5';
    five_4.TagString:= 'D5';

    six_1.TagString:= 'A6';
    six_2.TagString:= 'B6';
    six_3.TagString:= 'C6';
    six_4.TagString:= 'D6';

    seven_1.TagString:= 'A7';
    seven_2.TagString:= 'B7';
    seven_3.TagString:= 'C7';
    seven_4.TagString:= 'D7';

    eight_1.TagString:= 'A8';
    eight_2.TagString:= 'B8';
    eight_3.TagString:= 'C8';
    eight_4.TagString:= 'D8';

    nine_1.TagString:='A9';
    nine_2.TagString:='B9';
    nine_3.TagString:='C9';
    nine_4.TagString:='D9';

    ten_1.TagString:='A10';
    ten_2.TagString:='B10';
    ten_3.TagString:='C10';
    ten_4.TagString:='D10';

    J_1.TagString:='A11';
    J_2.TagString:='B11';
    J_3.TagString:='C11';
    J_4.TagString:='D11';

    Q_1.TagString:='A12';
    Q_2.TagString:='B12';
    Q_3.TagString:='C12';
    Q_4.TagString:='D12';

    K_1.TagString:='A13';
    K_2.TagString:='B13';
    K_3.TagString:='C13';
    K_4.TagString:='D13';

    A_1.TagString:='A14';
    A_2.TagString:='B14';
    A_3.TagString:='C14';
    A_4.TagString:='D14';

    two_1.TagString:= 'A15';
    two_2.TagString:= 'B15';
    two_3.TagString:= 'C15';
    two_4.TagString:= 'D15';
end;

end.

