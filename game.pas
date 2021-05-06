unit game;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation, FMX.StdCtrls, System.JSON,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, FMX.Edit,uDSimpleTcpClient,
  System.ImageList, FMX.ImgList, FMX.Objects,tcp,login,handler,user,setUserName,card,
  common,room, FMX.Layouts, FMX.TreeView,uToast, Data.Cloud.CloudAPI,
  Data.Cloud.AzureAPI, FMX.Media;

type
  TGameInterface = class(TForm)
    StartGame: TButton;
    outOfCard: TButton;
    giveUpCard: TButton;
    cancelMatch: TButton;
    AniIndicator1: TAniIndicator;
    waitting: TText;

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
    StyleBook1: TStyleBook;
    background: TImage;
    Layout1: TLayout;
    Image1: TImage;
    leftPlayerCardCount: TText;
    rightPlayerCardCount: TText;
    leftPlayerName: TText;
    rightPlayerName: TText;
    myName: TText;
    rightName: TRectangle;
    leftName: TRectangle;
    gameEnd: TRectangle;
    gameEndText: TText;
    ContinueGame: TButton;
    endGame: TButton;
    callLandowner: TButton;
    giveupCall: TButton;
    jiaodizhu: TImage;
    buchu: TImage;
    bujiao: TImage;
    buqiang: TImage;
    Image2: TImage;
    qiangdizhu: TImage;
    grabLandowner: TButton;
    giveupGrab: TButton;
    Timer1: TTimer;
    clock: TImage;
    clockText: TText;
    MediaPlayer1: TMediaPlayer;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure StartGameClick(Sender: TObject);
    procedure cancelMatchClick(Sender: TObject);
    procedure showBackHoleCards();
    procedure showFrontHoleCards();
    procedure showMyCards(cards : Tarray<string>);
    procedure FormResize(Sender: TObject);
    procedure ClickCard(Sender: TObject);
    procedure EvaluationImageTagString();
    procedure SetButton();
    procedure SetCards();
    procedure outOfCardClick(Sender: TObject);
    procedure ShowMyOutOfCards(cards : Tarray<string>);
    procedure ShowLeftPlayerCards(count : integer; name :string);
    procedure ShowRightPlayerCards(count : integer; name : string);
    procedure ShowLeftOutOfCards(cards :Tarray<string>);
    procedure ShowRightOutOfCards(cards : Tarray<string>);
//    procedure ShowMyWaitText();
//    procedure ShowLeftWaitText();
//    procedure ShowRightWaitText();
    procedure giveUpCardClick(Sender: TObject);
    procedure GameVictory();
    procedure GameDefeat();
    procedure CloseRec();
    procedure continueGameClick(Sender: TObject);
    procedure DoGameEnd();
    procedure endGameClick(Sender: TObject);
    procedure callLandownerClick(Sender: TObject);
    procedure giveupCallClick(Sender: TObject);
    procedure showMyBuQiangOrBujiao(ifcall : boolean);
    procedure showLeftBuQiangOrBujiao(ifcall : boolean);
    procedure showRightBuQiangOrBujiao(ifcall : boolean);
    procedure showMyQiangOrJiaoDiZhu(ifcall : boolean);
    procedure showLeftQiangOrJiaoDiZhu(ifcall : boolean);
    procedure showRightQiangOrJiaoDiZhu(ifcall : boolean);
    procedure grabLandownerClick(Sender: TObject);
    procedure giveupGrabClick(Sender: TObject);
    procedure CloseImage();
    procedure CloseButton();
    procedure Timer1Timer(Sender: TObject);
    procedure ShowMyClock();
    procedure showLeftClock();
    procedure showrightClock();

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

uses music;

{$R *.fmx}

procedure TGameInterface.FormCreate(Sender: TObject);
begin
    G_TcpMessage := TcpMessage.Create;
    ExHandler := executeHandler.Create;
    UI := UserInfo.Create;
    CM:=cmFunction.Create;
    CI:=CardInfo.Create;
//    BC:=mc.Create;
     G_TcpMessage.ConnectionService();

//    bc.ExtractRes('SRC','FILE','MusicPath');

    EvaluationImageTagString();
    SetButton();

    LFrame := TLoginFrame.Create(Self);
    LFrame.Parent := Self;

    SName:=TsetUserNameFrame.Create(Self);
    SName.Parent:=Self;

    SName.BringToFront;
    LFrame.BringToFront;

end;

procedure TGameInterface.CloseRec();
begin
    leftPlayerCardCount.Visible:=false;
    rightPlayerCardCount.Visible:=false;
    rightName.Visible:=false;
    leftName.Visible:=false;
//    waitRec.Visible:=false;
end;

procedure TGameInterface.FormDestroy(Sender: TObject);
begin
    G_TcpMessage.DisposeOf;
end;

procedure TGameInterface.FormResize(Sender: TObject);
begin
    SetButton();
    SetCards();
end;

procedure TGameInterface.giveUpCardClick(Sender: TObject);
var
  js : TJsonObject;
begin
     js:=TJsonObject.Create;
     js.AddPair('roomId',TJsonString.Create(rm.roomid));
     G_TcpMessage.SendTcpMessageToService(js.ToString,2016);

     giveupcard.Visible:=false;
     outofcard.Visible:=false;
     clock.Visible:=false;
     clock.Enabled:=false;

     js.DisposeOf;
end;

procedure TGameInterface.giveupGrabClick(Sender: TObject);
var
  js :TJsonObject;
begin
    js:=TJsonObject.Create;
    js.AddPair('roomId',TJsonString.Create(rm.roomid));
    js.AddPair('ifGrab',TJsonBool.Create(false));
    js.AddPair('ifcall',TjsonBool.Create(false));
    G_TcpMessage.SendTcpMessageToService(js.ToString,2018);

    giveupGrab.Visible:=false;
    GrabLandowner.Visible:=false;
    clock.Visible:=false;
    clock.Enabled:=false;

    js.DisposeOf;
end;

procedure TGameInterface.grabLandownerClick(Sender: TObject);
var
  js :TJsonObject;
begin
    js:=TJsonObject.Create;
    js.AddPair('roomId',TJsonString.Create(rm.roomid));
    js.AddPair('ifGrab',TJsonBool.Create(true));
    js.AddPair('ifcall',TjsonBool.Create(false));
    G_TcpMessage.SendTcpMessageToService(js.ToString,2018);

    giveupGrab.Visible:=false;
    GrabLandowner.Visible:=false;
    clock.Visible:=false;
    clock.Enabled:=false;

    js.DisposeOf;

end;

procedure TGameInterface.giveupCallClick(Sender: TObject);
var
  js :TJsonObject;
begin
    js:=TJsonObject.Create;
    js.AddPair('roomId',TJsonString.Create(rm.roomid));
    js.AddPair('ifGrab',TJsonBool.Create(false));
    js.AddPair('ifcall',TjsonBool.Create(true));
    G_TcpMessage.SendTcpMessageToService(js.ToString,2018);

    giveupCall.Visible:=false;
    CallLandowner.Visible:=false;
    clock.Visible:=false;
    clock.Enabled:=false;

    js.DisposeOf;
end;

procedure TGameInterface.callLandownerClick(Sender: TObject);
var
  js :TJsonObject;
begin
  js:=TJsonObject.Create;
  js.AddPair('roomId',TJsonString.Create(rm.roomid));
  js.AddPair('ifGrab',TJsonBool.Create(true));
  js.AddPair('ifcall',TjsonBool.Create(true));
  G_TcpMessage.SendTcpMessageToService(js.ToString,2018);

  giveupCall.Visible:=false;
  CallLandowner.Visible:=false;
  clock.Visible:=false;
  clock.Enabled:=false;

  js.DisposeOf;
end;

procedure TGameInterface.outOfCardClick(Sender: TObject);
var
  card  : string;
  js : TJsonObject;
  JsAy : TjsonArray;
begin
      if rm.choiceCards.Count=0 then
      begin
      Self.LAYOUT1.BringToFront;
      TToast.MakeText(Self.LAYOUT1, '请选择需要出的牌', TToastLength.Toast_LENGTH_LONG);
      exit;
      end;

      js := TJsonObject.Create;
      JsAy := TjsonArray.Create;
      for card in rm.choiceCards.Keys do
      begin
         JsAy.AddElement(TJsonString.Create(card));
      end;

     js.AddPair('cards',JsAy);
     js.AddPair('roomId',TJsonString.Create(rm.roomid));
     G_TcpMessage.SendTcpMessageToService(js.ToString,2007);
     js.DisposeOf;
end;

procedure TGameInterface.SetCards();
  var
  uid : string;
  rp : roomPlayer;
begin
    if ui=nil then
    begin
      exit;
    end;

    uid := ui.GetUserId();
    if (uid = '') or (rm = nil) then
    begin
      exit;
    end;
      if length(rm.MyCards)<>0 then
       begin
          showMyCards(rm.MyCards);
       end;
      if length(rm.outOfCards)<>0 then
      begin
          ShowMyOutOfCards(rm.outOfCards);
      end;
      if length(rm.holeCards)<>0 then
      begin
          if rm.grabLandownerEnd then
          begin
          showFrontHoleCards();
          end
          else
          begin
           showBackHoleCards();
          end;

      end;
      if rm.playerRightMap.Count<>0 then
      begin
          for rp in rm.playerLeftMap.Values do
                begin
                  ShowLeftPlayerCards(rp.cardsCOunt,rp.name);
                  if length(rp.outOfCards)<>0 then
                  begin
                    showLeftOutOfCards(rp.outOfCards);
                  end;
                end;
      end;
      if rm.playerRightMap.Count<>0 then
      begin
        for rp in rm.playerRightMap.Values do
          begin
            ShowRightPlayerCards(rp.cardsCOunt,rp.name);
            if length(rp.outOfCards)<>0 then
            begin
              showRightOutOfCards(rp.outOfCards);
            end;
          end;
      end;
      if rm.nextPlayerId<>'' then
      begin
          rm.ShowWaitClock(rm.nextPlayerId);
      end
      else if length(rm.uids)<>0 then
      begin
          rm.ShowWaitClock(rm.uids[0]);
      end;

end;

procedure TGameInterface.StartGameClick(Sender: TObject);
begin
       G_TcpMessage.SendTcpMessageToService('',2003);
       self.Invalidate;
       AniIndicator1.Visible:=true;
       AniIndicator1.Enabled:=true;
       waitting.Visible:=true;
       startGame.Visible:=false;
       cancelMatch.Visible := true;
end;

procedure TGameInterface.Timer1Timer(Sender: TObject);
begin
  if rm=nil then
  begin
    exit;
  end;
  timer1.Interval:=1000;
  rm.usedTime:=rm.usedTime+1;
  clocktext.Text:=(150-rm.usedTime).ToString;
  if 150-rm.usedTime=0 then
  if not rm.ifExcute then
   begin
    clock.Visible:=false;
    clock.Enabled:=false;
    exit;
   end
   else
  begin
    if rm.grabLandownerEnd then
    begin
       giveUpCardClick(sender);
    end
    else
    begin
        if rm.ifHavelandowenr then
        begin
          if rm.lastOutOfCardPlayer=ui.GetUserId then
          begin
          rm.AddOrRemoveChoiceCardsMap(rm.MyCards[High(rm.MyCards)],true);
          outOfCardClick(sender);
          end
          else
          begin
           giveupgrabclick(sender);
          end;
        end
        else
        begin
          giveupCallClick(sender);
        end;
    end;

  end;
end;

procedure TGameInterface.ClickCard(Sender: TObject);
begin
      if not rm.JudgeOutOfCardInMyCards(TImage(Sender).TagString) then
      begin
        exit;
      end;

      if rm.cardsClickCountMap[TImage(Sender).TagString] then
      begin
         TImage(Sender).Position.Y:=TImage(Sender).Position.Y - self.ClientHeight*0.057;
         rm.cardsClickCountMap[TImage(Sender).TagString] := false;
         rm.AddOrRemoveChoiceCardsMap(TImage(sender).TagString,true)
      end
      else
      begin
        TImage(Sender).Position.Y := TImage(Sender).Position.Y + self.ClientHeight*0.057;
        rm.cardsClickCountMap[TImage(Sender).TagString] := true;
        rm.AddOrRemoveChoiceCardsMap(TImage(sender).TagString,false)
      end;
end;

procedure TGameInterface.continueGameClick(Sender: TObject);
begin
   StartGameClick(Sender);
   gameEnd.Visible:=false;
   continueGame.Visible:=false;
   endGame.Visible:=false;
end;

procedure TGameInterface.cancelMatchClick(Sender: TObject);
begin
     G_TcpMessage.SendTcpMessageToService('',2008);
     self.Invalidate;
     AniIndicator1.Enabled:=false;
     AniIndicator1.Visible:=false;
     waitting.Visible:=false;
end;

procedure TGameInterface.ShowMyOutOfCards(cards : Tarray<string>);
var
 i : integer;
 totalLength : single;
 marginLeft : single;
begin

  marginLeft:=(self.ClientWidth-buchu.Width)/2;

  if length(cards)=0 then
  begin
      buchu.Position.X :=marginLeft;
      buchu.Position.Y :=self.ClientHeight-self.ClientHeight*0.453;
      buchu.WrapMode:=TImageWrapMode.Stretch;
      buchu.Visible := true;
      buchu.BringToFront;
    exit;
  end;

    totalLength :=(Length(cards)-1)*self.ClientWidth*0.031 + self.ClientWidth*0.052;

    marginLeft := (self.ClientWidth-totalLength) / 2;


  for i := 0 to High(cards) do
      begin
         CI.cardMap[cards[i]].Width :=  self.ClientWidth*0.052;
         CI.cardMap[cards[i]].Height := self.ClientHeight*0.129;
         CI.cardMap[cards[i]].Position.X := marginleft + i * self.ClientWidth*0.031;
         CI.cardMap[cards[i]].Position.Y :=self.ClientHeight-self.ClientHeight*0.453;
         CI.cardMap[cards[i]].WrapMode:=TImageWrapMode.Stretch;
         Ci.cardMap[cards[i]].Visible := true;
         CI.cardMap[cards[i]].BringToFront;
      end;

end;

procedure TGameInterface.ShowLeftOutOfCards(cards : Tarray<string>);
var
  i: integer;
begin
    if length(cards)=0 then
    begin
      buchu.Position.X :=cI.backCardArray[0].Position.X+cI.backCardArray[0].Width+ self.ClientWidth*0.052;
      buchu.Position.Y :=self.ClientHeight/2-CI.backCardArray[0].Height;
      buchu.WrapMode:=TImageWrapMode.Stretch;
      buchu.Visible := true;
      buchu.BringToFront;
      exit;
    end;
    for i := 0 to High(cards) do
      begin
        CI.cardMap[cards[i]].Width :=  self.ClientWidth*0.052;
        CI.cardMap[cards[i]].Height :=self.ClientHeight*0.129;
        CI.cardMap[cards[i]].Position.X:= cI.backCardArray[0].Position.X + self.ClientWidth*0.052
        +(i+1)*self.ClientWidth*0.021;
        CI.cardMap[cards[i]].Position.Y:=self.ClientHeight/2-CI.backCardArray[0].Height;
        CI.cardMap[cards[i]].WrapMode:=TImageWrapMode.Stretch;
        CI.cardMap[cards[i]].Visible:=true;
        CI.cardMap[cards[i]].BringToFront;
      end;
end;

procedure TGameInterface.ShowRightOutOfCards(cards : Tarray<string>);
var
  i: integer;
  margin: single;
begin
    if length(cards)=0 then
    begin
      buchu.Position.X :=CI.backCardArray[1].Position.X-buchu.Width-
      self.ClientWidth*0.052;
      buchu.Position.Y :=self.ClientHeight/2-CI.backCardArray[1].Height;
      buchu.WrapMode:=TImageWrapMode.Stretch;
      buchu.Visible := true;
      buchu.BringToFront;
      exit;
    end;
      margin:=(length(cards)-1)*self.ClientWidth*0.021+ self.ClientWidth*0.052;
       for i := 0 to High(cards) do
      begin
        CI.cardMap[cards[i]].Width :=  self.ClientWidth*0.052;
        CI.cardMap[cards[i]].Height :=self.ClientHeight*0.129;
        CI.cardMap[cards[i]].Position.X:= self.ClientWidth-38-CI.backCardArray[1].Width-
        self.ClientWidth*0.052-margin+(i+1)*self.ClientWidth*0.021;
        CI.cardMap[cards[i]].Position.Y:=self.ClientHeight/2-CI.backCardArray[1].Height;
        CI.cardMap[cards[i]].WrapMode:=TImageWrapMode.Stretch;
        CI.cardMap[cards[i]].Visible:=true;
        CI.cardMap[cards[i]].BringToFront;
      end;
end;

procedure  TGameInterface.showBackHoleCards() ;
var
 i : integer;
 totalCardsLength : single;
 marginLeft : single;
begin
  if length(rm.holeCards)=0 then
  begin
    exit;
  end;

    totalCardsLength :=(Length(rm.holeCards))*  CI.backCardArray[0].Width;

    marginLeft := (self.ClientWidth-totalCardsLength) / 2;

  for i := 2 to 2+High(rm.holeCards)  do
      begin
         CI.backCardArray[i].Position.X := marginleft + (i-2) * CI.backCardArray[0].Width;
         CI.backCardArray[i].Position.Y := 0;
         CI.backCardArray[i].WrapMode:=TImageWrapMode.Stretch;
         CI.backCardArray[i].Visible := true;
         CI.backCardArray[i].BringToFront;
      end;
//
end;

procedure TGameInterface.showFrontHoleCards();
var
 i : integer;
 totalCardsLength : single;
 marginLeft : single;
begin
  if length(rm.holeCards)=0 then
  begin
    exit;
  end;

    totalCardsLength :=(Length(rm.holeCards))* CI.backCardArray[0].Width;

    marginLeft := (self.ClientWidth-totalCardsLength) / 2;

  for i := 2 to 2+High(rm.holeCards)  do
      begin
         CI.backCardArray[i].Bitmap.Assign(ci.cardMap[rm.holeCards[i-2]].Bitmap);
         CI.backCardArray[i].Position.X := marginleft + (i-2) * CI.backCardArray[0].Width;
         CI.backCardArray[i].Position.Y := 0;
         CI.backCardArray[i].WrapMode:=TImageWrapMode.Stretch;
         CI.backCardArray[i].Visible := true;
         CI.backCardArray[i].BringToFront;
      end;

end;

procedure TGameInterface.showMyCards(cards : Tarray<string>);
var
 i : integer;
// cardslength : single;
 totalCardsLength : single;
 marginLeft : single;
begin
  if length(cards)=0 then
  begin
    exit;
  end;

    totalCardsLength :=(Length(cards)-1)* CI.cardMap[cards[0]].Width*0.375 +
     CI.cardMap[cards[0]].Width;

    marginLeft := (self.ClientWidth-totalCardsLength) / 2;

  for i := 0 to High(cards) do
      begin
         CI.cardMap[cards[i]].Position.X := marginleft + i * CI.cardMap[cards[i]].Width*0.375;
         CI.cardMap[cards[i]].Position.Y := layout1.Height-CI.cardMap[cards[i]].Height;
         CI.cardMap[cards[i]].WrapMode:=TImageWrapMode.Stretch;
         Ci.cardMap[cards[i]].Visible := true;
         CI.cardMap[cards[i]].BringToFront;
      end;
      rm.SetCardsClickCountMap(cards);
end;

procedure TGameInterface.ShowLeftPlayerCards(count : Integer; name :string);
  var
  cardCenterX : single;
begin

    cI.backCardArray[0].Position.X:=self.ClientWidth*0.039;
    CI.backCardArray[0].Position.Y := self.ClientHeight/2-CI.backCardArray[0].Height;
    CI.backCardArray[0].WrapMode:= TimageWrapMode.Stretch;
    CI.backCardArray[0].Visible := true;
    CI.backCardArray[0].BringToFront;

    cardCenterX:=cI.backCardArray[0].Position.X+(cI.backCardArray[0].Width/2);

    leftPlayerCardCount.Size.Height:=self.ClientHeight*0.043;
    leftPlayerCardCount.Size.Width:=self.ClientHeight*0.043;
    leftPlayerCardCount.Font.Size:=13;
    leftPlayerCardCount.Position.X:= cardCenterX-leftPlayerCardCount.Size.Width/2;
    leftPlayerCardCount.Position.Y := self.ClientHeight/2;
    leftPlayerCardCount.Text := count.ToString;
    leftPlayerCardCount.Visible := true;
    leftPlayerCardCount.BringToFront;

    LeftName.Position.X :=  cardCenterX-LeftName.Size.Width/2;
    LeftName.Position.Y :=self.ClientHeight/2-CI.backCardArray[0].Height-
    self.ClientHeight*0.071;
    LeftPlayerName.Text := name;
    LeftPlayerName.Visible := true;
    LeftName.Visible := true;
    LeftName.BringToFront;
end;

procedure TGameInterface.ShowRightPlayerCards(count : Integer;name :string);
var
  centerCardX : single;
begin
    cI.backCardArray[1].Position.X:=self.ClientWidth-self.ClientWidth*0.043-
    CI.backCardArray[1].Width;
    CI.backCardArray[1].Position.Y := self.ClientHeight/2-CI.backCardArray[1].Height;
    CI.backCardArray[1].WrapMode:= TimageWrapMode.Stretch;
    CI.backCardArray[1].Visible := true;
    CI.backCardArray[1].BringToFront;

    centerCardX:=cI.backCardArray[1].Position.X+cI.backCardArray[1].Width/2;

    rightPlayerCardCount.Size.Height:=self.ClientHeight*0.043;
    rightPlayerCardCount.Size.Width:=self.ClientHeight*0.043;
    rightPlayerCardCount.Position.X := centerCardX - rightPlayerCardCount.Width/2;
    rightPlayerCardCount.Position.Y := self.ClientHeight/2;
    rightPlayerCardCount.Font.Size:=13;
    rightPlayerCardCount.Text := count.ToString;
    rightPlayerCardCount.Visible := true;
    rightPlayerCardCount.BringToFront;

    rightName.Position.X := centerCardX - rightName.Width/2;
    rightName.Position.Y := self.ClientHeight/2-CI.backCardArray[1].Height-
    self.ClientHeight*0.071;
    rightPlayerName.Text := name;
    rightPlayerName.Visible := true;
    rightName.Visible := true;
    rightName.BringToFront;
end;

procedure TGameInterface.showMyBuQiangOrBujiao(ifcall : boolean);
var
  marginLeft : single;
begin
   marginLeft:=(self.ClientWidth-buqiang.Width)/2;
   if not ifcall then
  begin
      buqiang.Position.X :=marginLeft;
      buqiang.Position.Y :=self.ClientHeight-self.ClientHeight*0.453;
      buqiang.WrapMode:=TImageWrapMode.Stretch;
      buqiang.Visible := true;
      buqiang.BringToFront;
  end
  else
  begin
      bujiao.Position.X :=marginLeft;
      bujiao.Position.Y :=self.ClientHeight-self.ClientHeight*0.453;
      bujiao.WrapMode:=TImageWrapMode.Stretch;
      bujiao.Visible := true;
      bujiao.BringToFront;
  end;
end;

procedure TGameInterface.showLeftBuQiangOrBujiao(ifcall : boolean);
begin
  if not  ifcall then
  begin
      buqiang.Position.X :=cI.backCardArray[0].Position.X+cI.backCardArray[0].Width+self.ClientWidth*0.052;
      buqiang.Position.Y :=self.ClientHeight/2-CI.backCardArray[0].Height;
      buqiang.WrapMode:=TImageWrapMode.Stretch;
      buqiang.Visible := true;
      buqiang.BringToFront;
  end
  else
  begin
      bujiao.Position.X :=cI.backCardArray[0].Position.X+cI.backCardArray[0].Width+self.ClientWidth*0.052;
      bujiao.Position.Y :=self.ClientHeight/2-CI.backCardArray[0].Height;
      bujiao.WrapMode:=TImageWrapMode.Stretch;
      bujiao.Visible := true;
      bujiao.BringToFront;
  end;
end;

procedure TGameInterface.showRightBuQiangOrBujiao(ifcall : boolean);
begin
  if not ifcall then
  begin
      buqiang.Position.X :=CI.backCardArray[1].Position.X-buqiang.Width-self.ClientWidth*0.052;
      buqiang.Position.Y :=self.ClientHeight/2-CI.backCardArray[1].Height;
      buqiang.WrapMode:=TImageWrapMode.Stretch;
      buqiang.Visible := true;
      buqiang.BringToFront;
  end
  else
  begin
      bujiao.Position.X :=CI.backCardArray[1].Position.X-bujiao.Width-self.ClientWidth*0.052;
      bujiao.Position.Y :=self.ClientHeight/2-CI.backCardArray[1].Height;
      bujiao.WrapMode:=TImageWrapMode.Stretch;
      bujiao.Visible := true;
      bujiao.BringToFront;
  end;
end;

procedure TGameInterface.showMyQiangOrJiaoDiZhu(ifcall : boolean);
var
  marginLeft : single;
begin
   marginLeft:=(self.ClientWidth-qiangdizhu.Width)/2;
   if not ifcall then
  begin
      qiangdizhu.Position.X :=marginLeft;
      qiangdizhu.Position.Y :=self.ClientHeight-self.ClientHeight*0.453;
      qiangdizhu.WrapMode:=TImageWrapMode.Stretch;
      qiangdizhu.Visible := true;
      qiangdizhu.BringToFront;
  end
  else
  begin
      jiaodizhu.Position.X :=marginLeft;
      jiaodizhu.Position.Y :=self.ClientHeight-self.ClientHeight*0.453;
      jiaodizhu.WrapMode:=TImageWrapMode.Stretch;
      jiaodizhu.Visible := true;
      jiaodizhu.BringToFront;
  end;
end;

procedure TGameInterface.showLeftQiangOrJiaoDiZhu(ifcall : boolean);
begin
  if not ifcall then
  begin
      qiangdizhu.Position.X :=cI.backCardArray[0].Position.X+cI.backCardArray[0].Width+self.ClientWidth*0.052;
      qiangdizhu.Position.Y :=self.ClientHeight/2-CI.backCardArray[0].Height;
      qiangdizhu.WrapMode:=TImageWrapMode.Stretch;
      qiangdizhu.Visible := true;
      qiangdizhu.BringToFront;
  end
  else
  begin
      jiaodizhu.Position.X :=cI.backCardArray[0].Position.X+cI.backCardArray[0].Width+self.ClientWidth*0.052;
      jiaodizhu.Position.Y :=self.ClientHeight/2-CI.backCardArray[0].Height;
      jiaodizhu.WrapMode:=TImageWrapMode.Stretch;
      jiaodizhu.Visible := true;
      jiaodizhu.BringToFront;
  end;
end;

procedure TGameInterface.showRightQiangOrJiaoDiZhu(ifcall : boolean);
begin
  if not ifcall then
  begin
      qiangdizhu.Position.X :=CI.backCardArray[1].Position.X-qiangdizhu.Width-self.ClientWidth*0.052;
      qiangdizhu.Position.Y :=self.ClientHeight/2-CI.backCardArray[1].Height;
      qiangdizhu.WrapMode:=TImageWrapMode.Stretch;
      qiangdizhu.Visible := true;
      qiangdizhu.BringToFront;
  end
  else
  begin
      jiaodizhu.Position.X :=CI.backCardArray[1].Position.X-jiaodizhu.Width-self.ClientWidth*0.052;
      jiaodizhu.Position.Y :=self.ClientHeight/2-CI.backCardArray[1].Height;
      jiaodizhu.WrapMode:=TImageWrapMode.Stretch;
      jiaodizhu.Visible := true;
      jiaodizhu.BringToFront;
  end;
end;

procedure TGameInterface.CloseImage();
begin
  bujiao.Visible:=false;
  buqiang.Visible:=false;
  jiaodizhu.Visible:=false;
  qiangdizhu.Visible:=false;
end;

procedure TGameInterface.CloseButton();
begin
  giveupgrab.Visible:=false;
  giveupcall.Visible:=false;
  grablandowner.Visible:=false;
  calllandowner.Visible:=false;
end;

procedure TGameInterface.ShowMyClock();
var
  marginLeft: single;
begin
    rm.usedTime:=0;
    marginLeft:=(self.ClientWidth-clock.Width)/2;
    clock.Position.X := marginleft;
    clock.Position.Y :=self.ClientHeight-self.ClientHeight*0.453;//0.383
    clock.Visible:=true;
    clock.Enabled:=true;
    rm.ifExcute:=true;
end;

procedure TGameInterface.showLeftClock();
begin
    rm.usedTime:=0;
    clock.Position.X :=cI.backCardArray[0].Position.X+cI.backCardArray[0].Width+self.ClientWidth*0.052;
    clock.Position.Y :=self.ClientHeight/2-CI.backCardArray[0].Height;
    clock.Visible:=true;
    clock.Enabled:=true;
    rm.ifExcute:=false;
end;

procedure TGameInterface.showrightClock();
begin
      rm.usedTime:=0;
      clock.Position.X :=CI.backCardArray[1].Position.X-clock.Width-self.ClientWidth*0.052;
      clock.Position.Y :=self.ClientHeight/2-CI.backCardArray[1].Height;
      clock.Visible:=true;
      clock.Enabled:=true;
      rm.ifExcute:=false;
  //
end;

procedure TGameInterface.GameVictory();
begin
  gameEndText.Text:='胜利';
  gameEndText.Color:=TAlphaColorRec.Gold;
  gameEndText.Visible:=true;
  gameEnd.Visible:=true;
  giveUpCard.Visible:=false;
  outOfCard.Visible:=false;
  gameEnd.BringToFront;

  DoGameEnd();
end;

procedure TGameInterface.GameDefeat();
begin
  gameEndText.Text:='失败';
  gameEndText.Color:=TAlphaColorRec.Red;
  gameEndText.Visible:=true;
  gameEnd.Visible:=true;
  gameEnd.Visible:=true;
  giveUpCard.Visible:=false;
  outOfCard.Visible:=false;
  gameEnd.BringToFront;

  DoGameEnd();
end;

procedure TGameInterface.DoGameEnd();
begin
  CI.CloseCards();
  CloseRec();
  continueGame.Visible:=true;
  endGame.Visible:=true;
  rm.DisposeOf;
end;

procedure TGameInterface.endGameClick(Sender: TObject);
begin
   gameEnd.Visible:=false;
   endGame.Visible:=false;
   continueGame.Visible:=false;
   startGame.Visible:=true;
end;

procedure TGameInterface.SetButton();
begin
  StartGame.Position.X:=(self.ClientWidth-StartGame.Width)/2;
  StartGame.Position.Y:=self.ClientHeight-self.ClientHeight*0.289;
  StartGame.Visible:=true;

  cancelMatch.Position.X:=(self.ClientWidth-cancelMatch.Width)/2;
  cancelMatch.Position.Y:=self.ClientHeight-self.ClientHeight*0.289; //0.259

//  .Position.X:=(self.ClientWidth-waitting.Width)/2+self.ClientWidth*0.007;
//  waitRec.Position.Y:=self.ClientHeight-self.ClientHeight*0.309;

  AniIndicator1.Position.X:=(self.ClientWidth-AniIndicator1.Width)/2-self.ClientWidth*0.007;
  AniIndicator1.Position.Y:=self.ClientHeight-self.ClientHeight*0.455;  //0.395

  giveUpCard.Position.X:=(self.ClientWidth-giveUpCard.Width)/2 -self.ClientWidth*0.104;
  giveUpCard.Position.Y:=self.ClientHeight-self.ClientHeight*0.339;

  outOfCard.Position.X:=(self.ClientWidth-outOfCard.Width)/2 + self.ClientWidth*0.104;
  outOfCard.Position.Y:=self.ClientHeight-self.ClientHeight*0.339;

  ContinueGame.Position.X:=(self.ClientWidth-ContinueGame.Width)/2+self.ClientWidth*0.104;
  ContinueGame.Position.Y:=self.ClientHeight-self.ClientHeight*0.339;

  endGame.Position.X:=(self.ClientWidth-endGame.Width)/2-self.ClientWidth*0.104;
  endGame.Position.Y:=self.ClientHeight-self.ClientHeight*0.339;

  giveUpCall.Position.X:=(self.ClientWidth-giveUpCall.Width)/2 -self.ClientWidth*0.104;
  giveUpCall.Position.Y:=self.ClientHeight-self.ClientHeight*0.339;

  CallLandowner.Position.X:=(self.ClientWidth-CallLandowner.Width)/2 + self.ClientWidth*0.104;
  CallLandowner.Position.Y:=self.ClientHeight-self.ClientHeight*0.339;

  giveUpGrab.Position.X:=(self.ClientWidth-giveUpGrab.Width)/2 -self.ClientWidth*0.104;
  giveUpGrab.Position.Y:=self.ClientHeight-self.ClientHeight*0.339;

  grabLandowner.Position.X:=(self.ClientWidth-grabLandowner.Width)/2 + self.ClientWidth*0.104;
  grabLandowner.Position.Y:=self.ClientHeight-self.ClientHeight*0.339;

  clock.Width:= self.ClientWidth*0.093;
  clock.Height:=self.ClientWidth*0.093;

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

