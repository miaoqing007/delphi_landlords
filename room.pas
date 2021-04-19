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

  constructor Create;
  destructor Destory;

  public
  procedure SetOrUpdatePlayerMap(uid :string ;TJCards :TJsonArray);

end;

var RM :RmInfo;

implementation

uses game;

constructor RmInfo.Create;
begin
    playerMap:=TDictionary<string,roomPlayer>.Create;
end;

destructor RmInfo.Destory;
begin
   playerMap.DisposeOf;
end;

procedure RmInfo.SetOrUpdatePlayerMap(uid:string ; TJCards :TJsonArray);
var
  rp :roomPlayer;
  I:integer;
begin
  rp:=roomplayer.Create;
     for I := 0 to TJCards.Count-1 do
   begin
        SetLength( rp.cards, Length( rp.cards)+1);
        rp.cards[High(rp.cards)] :=(TJCards.Items[i] as TJsonString).Value;
   end;

   rp.uid := uid;
   playerMap.TryAdd(uid,rp);
   GameInterface.MySelf.Lines.Clear;
   GameInterface.MySelf.Lines.Add(TJcards.ToString);
end;

end.