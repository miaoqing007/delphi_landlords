unit card;

interface

uses System.Generics.Collections,FMX.Objects;

type CardInfo = class
  cardMap : TDictionary<string,TImage>;

  public
  procedure initCardMap();

  constructor Create;
  destructor Destory;
end;

implementation

constructor Cardinfo.Create;
begin
   cardMap:=TDictionary<string,TImage>.Create;
end;

destructor CardInfo.Destory;
begin
  cardMap.DisposeOf;
end;

procedure CardInfo.initCardMap();
begin

end;

end.

