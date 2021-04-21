unit room;

interface

uses System.Generics.Collections,FMX.Dialogs,system.JSON;

type roomPlayer = class
  uid : string;
  name : string;
  cards : Tarray<string>;
end;

type RmInfo = class

  roomId : string;
  playerMap : TDictionary<string,roomPlayer>;
  cardsClickCountMap : TDictionary<string,boolean>;
  holeCards : Tarray<string>;


  constructor Create;
  destructor Destory;

  public
  procedure SetOrUpdatePlayerMap(uid :string ;TJCards :TJsonArray);
  procedure SetHoleCards(roomId :string;HCards : TJsonArray);
  procedure SetCardsClickCountMap(cards : Tarray<string>);


end;

var RM :RmInfo;

implementation

uses game,common,user;

constructor RmInfo.Create;
begin
    playerMap :=  TDictionary<string,roomPlayer>.Create;
    cardsClickCountMap := TDictionary<string,boolean>.Create;
end;

destructor RmInfo.Destory;
begin
   playerMap.DisposeOf;
   cardsClickCountMap.DisposeOf;
   inherited;
end;

procedure RmInfo.SetHoleCards(roomId : string;HCards :TJsonArray);
begin
   rm.roomId := roomId;
   rm.holeCards:=  CM.TJosnArray2TArray(HCards);
end;

procedure RmInfo.SetCardsClickCountMap(cards : Tarray<string>);
var i : integer;
begin
    for i := 0 to High(cards) do
    begin
        cardsClickCountMap.TryAdd(cards[i],true);
    end;

end;


procedure RmInfo.SetOrUpdatePlayerMap(uid:string ; TJCards :TJsonArray);
var
  rp :roomPlayer;
begin
   rp:=roomplayer.Create;
   rp.cards:=CM.TJosnArray2TArray(TJCards);
   rp.uid := uid;
   playerMap.TryAdd(uid,rp);

   if (UI.GetUserId() = uid )then
   begin
      GameInterface.showMyCards(rp.cards);
      SetCardsClickCountMap(rp.cards);
   end;

end;

end.
