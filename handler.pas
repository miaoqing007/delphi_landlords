unit handler;

interface

uses uDSimpleTcpClient,System.Classes,System.SysUtils,System.Generics.Collections,
FMX.Dialogs,system.JSON,user,common,uToast;

type  executeFunction= procedure(LStr :TStringStream) of object;

type executeHandler = class

  private
  procedure AddCallBackDictionary;

  private
  procedure DoIngoreMsg(LStr:TStringStream);
  procedure DoLoginSuccess(LStr:TStringStream);
  procedure DoErrorAck(LStr:TStringStream);
  procedure DoStartGameSuccess(LStr:TStringStream);
  procedure DoUserRegisterSuccess(LStr:TStringStream);
  procedure DoPullUserDataSuccess(LStr:TStringStream);
  procedure DoPvpPlayerSuccess(LStr:TStringStream);
  procedure DoCancelPvpMatchSuccess(LStr:TStringStream);
  procedure DoOutOfCardSuccess(LStr:TStringStream);
  procedure DoOutOfCardFailed(LStr:TStringStream);
  procedure DoLoginFailed(LStr:TStringStream);
  procedure DoRegisterName(LStr:TStringStream);
  procedure DoGameOver(LStr:TStringStream);
  procedure DoResetCards(LStr:TStringStream);
  procedure DoReceiveGrabResult(LStr:TStringStream);
  procedure DoGetLandowner(LStr:TStringStream);
  procedure DoReceiveChatMsg(LStr:TStringStream);
  procedure OnSound(ifcall,ifgrab :boolean);
//  procedure AddCode;


  public
  CallBackDictionary: TDictionary<int16,executeFunction>;
//  Code : TDictionary<string,int16>;
  constructor Create;
  destructor Destroy; override;


end;


var ExHandler :executeHandler;

implementation

uses game,tcp,room,card,music,chat;

constructor executeHandler.Create;
begin
   CallBackDictionary:= TDictionary<int16,executeFunction>.Create;
//   Code := TDictionary<string,int16>.Create;
//   AddCode();
   AddCallBackDictionary();
end;

destructor executeHandler.Destroy;
begin
   CallBackDictionary.DisposeOf;
//   Code.DisposeOf;
   inherited;
end;

//procedure executeHandler.AddCode();
//begin
////  Code.Add();
//end;

procedure executeHandler.AddCallBackDictionary();
begin
   CallBackDictionary.Add(0,DoIngoreMsg);                    //??????????Ϣ
   CallBackDictionary.Add(2001,DoLoginSuccess);              //??½?ɹ?????????Ϸ????
   CallBackDictionary.Add(2002,DoErrorAck);                  //????ͳһ????
   CallBackDictionary.Add(2003,DoStartGameSuccess);          //??ʼ??Ϸ?ɹ????ȴ?ƥ??????
   CallBackDictionary.Add(2005,DoUserRegisterSuccess);       //???û?ע???ɹ?
   CallBackDictionary.Add(2006,DoPullUserDataSuccess);       //??ȡ?û???Ϣ?ɹ?
   CallBackDictionary.Add(2009,DoCancelPvpMatchSuccess);     //ȡ??ƥ???ɹ?
   CallBackDictionary.Add(2011,DoOutOfCardSuccess);          //???Ƴɹ?
   CallBackDictionary.Add(2010,DoOutOfCardFailed);           //????ʧ??
   CallBackDictionary.Add(2012,DoLoginFailed);               //??½ʧ??
   CallBackDictionary.Add(2014,DoRegisterName);              //????????????
   CallBackDictionary.Add(2017,DoGameOver);                  //??Ϸ????
   CallBackDictionary.Add(2019,DoGetLandowner);              //?õ?????id
   CallBackDictionary.Add(2020,DoResetCards);                //???·???
   CallBackDictionary.Add(2021,DoReceiveGrabResult);         //?յ????????ҵ???????????
   CallBackDictionary.Add(2022,DoReceiveChatMsg);            // ?յ???????Ϣ
   CallBackDictionary.Add(3000,DoPvpPlayerSuccess);          //ƥ???ɹ?
end;


procedure executeHandler.DoIngoreMsg(LStr:TStringStream);
begin

end;

procedure executeHandler.DoErrorAck(LStr:TStringStream);
 var
  JS: TJsonObject;
  msg: string;
begin
    JS:=TJsonObject.ParseJSONValue(Lstr.DataString) as TJsonObject;
    JS.TryGetValue('f_msg',msg);
    JS.DisposeOf;
    LFrame.Layout1.BringToFront;
    TToast.MakeText(LFrame.LAYOUT1, msg, TToastLength.Toast_LENGTH_LONG);
end;

procedure executeHandler.DoLoginSuccess(LStr:TStringStream);
begin
//      LFrame.Visible:=false;
//      GameInterface.AniIndicator1.Visible:=false;
      G_TcpMessage.SendTcpMessageToService('',2006);
end;

procedure executeHandler.DoStartGameSuccess(LStr:TStringStream);
begin

end;

procedure executeHandler.DoUserRegisterSuccess(LStr:TStringStream);
begin

end;

procedure executeHandler.DoPullUserDataSuccess(LStr:TStringStream);
var
  Js:TJsonObject;
  name:string;
  uid:string;
begin
  Js:=TJsonObject.ParseJSONValue(Lstr.DataString)as TJsonObject;
  Js.TryGetValue('name',name);
  Js.TryGetValue('uid',uid);

  SName.Visible:=false;
  LFrame.Visible:=false;
  GameInterface.AniIndicator1.Visible:=false;

  UI.SetUserName(name);
  UI.SetUserId(uid);

  bc.playbackgroundmusic('SRCWelcome','FILEWelcome','MusicEx_Welcome.mp3');

  Js.DisposeOf;
end;

procedure executeHandler.DoPvpPlayerSuccess(LStr:TStringStream);
var
  Js : TJsonObject;
  HoleCards :TjsonArray;
  LPlayers : TJsonArray;
  LPlayer : TJsonObject;
  LplayerIds : TJsonArray;
  roomId : string;
  I : integer;
  Id : string;
  name : string;
  cards : TjsonArray;
  pj : TJsonObject;

begin
   RM:=RmInfo.Create;
   Js:=TJsonObject.ParseJSONValue(Lstr.DataString) as TJsonObject;
   js.TryGetValue('players',LPlayers);
   js.TryGetValue('roomId',roomId);
   js.TryGetValue('hole_cards',HoleCards);
   js.TryGetValue('playerIds',LPlayerIds);

   Rm.SetHoleCards(roomId,HoleCards);

   Rm.SetLeftAndRigthPlayer(LPlayerIds);

   if (Lplayers<>nil)and (not LPlayers.Null) then
   begin
     for I:=0 to Lplayers.Count-1 do
       begin
           LPlayer:=LPlayers.Items[I] as TJsonObject;
           PJ:=TJsonOBject.ParseJSONValue(LPlayer.ToString) as TJsonObject;
           pJ.TryGetValue('id',Id);
           pj.TryGetValue('cards',cards);
           Pj.TryGetValue('name',name);
           RM.SetOrUpdatePlayerMap(id,name,cards);
           cc.outputChatMessage('????'+name+'??????????');
           pj.DisposeOf;
       end;
   end;
   js.DisposeOf;
   GameInterface.cancelMatch.Visible := false;
   GameInterface.AniIndicator1.Visible := false;
   GameInterface.AniIndicator1.Enabled := false;
   GameInterface.waitting.Visible:=false;

   if ui.GetUserId=rm.uids[0] then
   begin
   GameInterface.giveupCall.Visible:=true;
   GameInterface.CallLandowner.Visible:=true;
   end;

   bc.playbackgroundmusic('SRCExciting','FILEExciting','MusicEx_Exciting.mp3');

   GameInterface.setChatFrame;
   GameInterface.chaticon.Visible:=true;
   GameInterface.chathint.Visible:=false;

   ui.SetIfInGaming(true);
   rm.ShowWaitClock(rm.uids[0]);

end;

procedure executeHandler.DoCancelPvpMatchSuccess(LStr:TStringStream);
begin
   GameInterface.cancelMatch.Visible := false;
   GameInterface.StartGame.Visible := true;
end;

procedure executeHandler.DoOutOfCardSuccess(LStr:TStringStream);
var
  Js : TJsonObject;
  outofCards,cards : TJsonArray;
  id,nextId,randomNum : string;
  ty :integer;
begin
    Js:=TJsonObject.ParseJSONValue(Lstr.DataString) as TJsonObject;
    js.TryGetValue('id',id);
    js.TryGetValue('cards',cards);
    js.TryGetValue('outOfCards',outOfCards);
    js.TryGetValue('randomNum',randomNum);
    js.TryGetValue('ty',ty);

    rm.SetOutOfCards(id,outofCards);

    if outOfCards.Count<>0 then
    begin
      rm.lastOutOfCardPlayer := id;
    end;

    RM.SetOrUpdatePlayerMap(id,'',cards);

    if id =Ui.GetUserId then
    begin
       GameInterface.outOfCard.Visible := false;
       GameInterface.giveUpCard.Visible := false;
    end;

    if rm.nextPlayerId=UI.GetUserId then
    begin
        if rm.nextPlayerId<>rm.lastOutOfCardPlayer then
        begin
        GameInterface.giveUpCard.Visible := true;
        end;
       GameInterface.outOfCard.Visible := true;
    end;

    BC.readCardNumber(cm.TJosnArray2TArray(outofcards),randomNum,ty);

    js.DisposeOf;
end;

procedure executeHandler.DoOutOfCardFailed(LStr:TStringStream);
var
 Js : TJsonObject;
 msg : string;

begin
    js := TJsonobject.ParseJSONValue(Lstr.DataString) as TJsonObject;
    js.TryGetValue('msg',msg);

    GameInterface.LAYOUT1.BringToFront;
    TToast.MakeText(GameInterface.LAYOUT1, msg, TToastLength.Toast_LENGTH_LONG);
    js.DisposeOf;
end;

procedure executeHandler.DoLoginFailed(LStr:TStringStream);
var
 Js : TJsonObject;
 msg : string;

begin
    js := TJsonobject.ParseJSONValue(Lstr.DataString) as TJsonObject;
    js.TryGetValue('msg',msg);

    LFrame.LoginFailed(msg);
    js.DisposeOf;
end;

procedure executeHandler.DoRegisterName(LStr:TStringStream);
begin
    lFrame.Visible:=false;
end;

procedure executeHandler.DoGameOver(LStr:TStringStream);
var
  js : TjsonObject;
  winIds : TJsonArray;
  i : integer;
begin
   js:=TjsonObject.ParseJSONValue(Lstr.DataString) as TJsonObject;
   js.TryGetValue('winId',winIds);

   for I := 0 to winIds.Count-1 do
   begin
     if (winIds.Items[i] as TJsonString).Value=ui.GetUserId then
     begin
         GameInterface.GameVictory();
     end
     else
     begin
         GameInterface.GameDefeat();
     end;

   end;

   ui.SetIfInGaming(false);
   js.DisposeOf;
end;

procedure executeHandler.DoResetCards(LStr:TStringStream);
begin
    GameInterface.CloseImage();
    GameInterface.CloseButton();
    rm.DisposeOf;
//    GameInterface.LAYOUT1.BringToFront;
//    TToast.MakeText(GameInterface.LAYOUT1, '???·?????', TToastLength.Toast_LENGTH_LONG);
//    sleep(2000);
    DoPvpPlayerSuccess(LStr);
end;

procedure executeHandler.DoReceiveGrabResult(LStr:TStringStream);
var
  playerId : string;
  ifHaveLandowner,ifcall,ifGrab : boolean;
  js : TJsonObject;
begin
   js:=TJsonObject.ParseJSONValue(Lstr.DataString)as TJsonObject;
   js.TryGetValue('uid',playerId);
   js.TryGetValue('ifGrab',ifgrab);
   js.TryGetValue('ifhavelandowner',ifHaveLandowner);
   js.TryGetValue('ifcall',ifcall);

   rm.ifHavelandowenr:=ifHaveLandowner;


   if rm.findNextId(playerId)=ui.GetUserId then
   begin
   if ifHaveLandowner then
   begin
    GameInterface.giveupGrab.Visible:=true;
    GameInterface.GrabLandowner.Visible:=true;
   end
   else
   begin
    GameInterface.giveupCall.Visible:=true;
    GameInterface.CallLandowner.Visible:=true;
   end;
   end;

   rm.ShowGrabResult(playerId,ifGrab,ifcall);

   OnSound(ifcall,ifgrab);

   rm.ShowWaitClock(rm.findNextId(playerId));

   js.DisposeOf;
end;

procedure executeHandler.DoGetLandowner(LStr:TStringStream);
var
  landownerId : string;
  cards : TJsonArray;
  js : TJsonObject;
begin
  js := TJsonObject.ParseJSONValue(Lstr.DataString) as TJsonObject;
  js.TryGetValue('id',landownerId);
  js.TryGetValue('cards',cards);

   if landownerId=ui.GetUserId then
    begin
    rm.SetOrUpdatePlayerMap(landownerId,'',cards);
    rm.ifHavelandowenr := true;
    GameInterface.outOfCard.Visible := true;
    end;

    rm.lastOutOfCardPlayer:=landownerid;

    rm.grabLandownerEnd:=true;

    GameInterface.CloseButton();

    GameInterface.CloseImage();

    rm.ShowDiZhuIcon(landownerid);

    rm.ShowWaitClock(landownerId);

    GameInterface.showFrontHoleCards();


  js.DisposeOf;
end;

procedure executeHandler.DoReceiveChatMsg(LStr:TStringStream);
var
  js : TJsonObject;
  name,timeStr,msg :string;
begin
  js := TJsonObject.ParseJSONValue(Lstr.DataString) as TJsonObject;
  js.TryGetValue('name',name);
  js.TryGetValue('timeStr',timeStr);
  js.TryGetValue('msg',msg);
  cc.outputChatMessage(timeStr+':'+name+':'+msg);
  js.DisposeOf;
end;

procedure executeHandler.OnSound(ifcall,ifgrab :boolean);
begin
      if ifgrab then
   begin
    if ifcall then
   begin
     bc.readsound(1);
   end
   else
   begin
     bc.readsound(3)
   end;
   end
   else
   begin
    if ifcall then
   begin
     bc.readsound(2);
   end
   else
   begin
     bc.readsound(4);
   end;
   end;
end;

end.
