unit common;

interface

uses system.JSON;

type cmFunction = class

public
  function TJosnArray2TArray(Tja : TJsonArray):Tarray<string>;

end;

var
  CM:cmFunction;

implementation

function cmFunction.TJosnArray2TArray(Tja : TJsonArray):Tarray<string>;
var
  I:integer;
  TA:Tarray<string>;
begin
     for I := 0 to Tja.Count-1 do
   begin
        SetLength( TA, Length(TA)+1);
        TA[High(TA)] :=(Tja.Items[i] as TJsonString).Value;
   end;
   Result:=TA;
end;

end.
