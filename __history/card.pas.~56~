unit card;

interface

uses System.Generics.Collections,FMX.Objects,fmx.Dialogs,System.SysUtils;

type CardInfo = class

  cardMap : TDictionary<string,TImage>;

  backCardArray : Tarray<TImage>;

  public
  procedure initCardMap();
  procedure initBackCard();
  procedure CloseCards();
  procedure ReSetBackCards();

  constructor Create;
  destructor Destory;
end;

var CI : CardInfo;

 implementation

uses game;

constructor Cardinfo.Create;
begin
   cardMap:=TDictionary<string,TImage>.Create;

   initCardMap();

   initBackCard();

end;

destructor CardInfo.Destory;
begin
  cardMap.DisposeOf;
  inherited;
end;

procedure CardInfo.initCardMap();
begin
    cardMap.TryAdd('K99',GameInterface.dawang);    //大王
    cardMap.TryAdd('Q88',GameInterface.xiaowang);    //小王

    cardMap.TryAdd('A3',GameInterface.three_1);     //3
    cardMap.TryAdd('B3',GameInterface.three_2);
    cardMap.TryAdd('C3',GameInterface.three_3);
    cardMap.TryAdd('D3',GameInterface.three_4);

    cardMap.TryAdd('A4',GameInterface.four_1);     //4
    cardMap.TryAdd('B4',GameInterface.four_2);
    cardMap.TryAdd('C4',GameInterface.four_3);
    cardMap.TryAdd('D4',GameInterface.four_4);

    cardMap.TryAdd('A5',GameInterface.five_1);     //5
    cardMap.TryAdd('B5',GameInterface.five_2);
    cardMap.TryAdd('C5',GameInterface.five_3);
    cardMap.TryAdd('D5',GameInterface.five_4);

    cardMap.TryAdd('A6',GameInterface.six_1);     //6
    cardMap.TryAdd('B6',GameInterface.six_2);
    cardMap.TryAdd('C6',GameInterface.six_3);
    cardMap.TryAdd('D6',GameInterface.six_4);

    cardMap.TryAdd('A7',GameInterface.seven_1);      //7
    cardMap.TryAdd('B7',GameInterface.seven_2);
    cardMap.TryAdd('C7',GameInterface.seven_3);
    cardMap.TryAdd('D7',GameInterface.seven_4);

    cardMap.TryAdd('A8',GameInterface.eight_1);      //8
    cardMap.TryAdd('B8',GameInterface.eight_2);
    cardMap.TryAdd('C8',GameInterface.eight_3);
    cardMap.TryAdd('D8',GameInterface.eight_4);

    cardMap.TryAdd('A9',GameInterface.nine_1);      //9
    cardMap.TryAdd('B9',GameInterface.nine_2);
    cardMap.TryAdd('C9',GameInterface.nine_3);
    cardMap.TryAdd('D9',GameInterface.nine_4);

    cardMap.TryAdd('A10',GameInterface.ten_1);     //10
    cardMap.TryAdd('B10',GameInterface.ten_2);
    cardMap.TryAdd('C10',GameInterface.ten_3);
    cardMap.TryAdd('D10',GameInterface.ten_4);

    cardMap.TryAdd('A11',GameInterface.J_1);     //J
    cardMap.TryAdd('B11',GameInterface.J_2);
    cardMap.TryAdd('C11',GameInterface.J_3);
    cardMap.TryAdd('D11',GameInterface.J_4);

    cardMap.TryAdd('A12',GameInterface.Q_1);     //Q
    cardMap.TryAdd('B12',GameInterface.Q_2);
    cardMap.TryAdd('C12',GameInterface.Q_3);
    cardMap.TryAdd('D12',GameInterface.Q_4);

    cardMap.TryAdd('A13',GameInterface.K_1);      //K
    cardMap.TryAdd('B13',GameInterface.K_2);
    cardMap.TryAdd('C13',GameInterface.K_3);
    cardMap.TryAdd('D13',GameInterface.K_4);

    cardMap.TryAdd('A14',GameInterface.A_1);      //A
    cardMap.TryAdd('B14',GameInterface.A_2);
    cardMap.TryAdd('C14',GameInterface.A_3);
    cardMap.TryAdd('D14',GameInterface.A_4);

    cardMap.TryAdd('A15',GameInterface.two_1);      //2
    cardMap.TryAdd('B15',GameInterface.two_2);
    cardMap.TryAdd('C15',GameInterface.two_3);
    cardMap.TryAdd('D15',GameInterface.two_4);
end;


procedure CardInfo.initBackCard();
var
  im : TImage;
  im2: Timage;
  i : integer;
begin
  for i := 0 to 6 do
  begin
        im := TImage.Create(GameInterface);
        im.Parent := GameInterface;
        im.Bitmap.Assign(GameInterface.Image1.Bitmap);
        im.Height := GameInterface.TempHeight*0.143;
        im.Width :=  GameInterface.TempWidth*0.062;
        im.Visible := false;
        SetLength(backCardArray, Length(backCardArray)+1);
        backCardArray[High(backCardArray)] := im;
  end;

  for im2 in cardMap.Values do
  begin
    im2.Width := GameInterface.TempWidth*0.083;
    im2.Height:=GameInterface.TempHeight*0.215;;
  end;

end;

procedure CardInfo.CloseCards();
var
   im : TImage;
   i : integer;
begin
  for im in cardMap.Values do
  begin
    im.Visible:=false;
  end;

  ReSetBackCards();
end;

procedure CardInfo.ReSetBackCards();
var
   i : integer;
begin
  for I := 0 to High(backCardArray) do
  begin
    backCardArray[i].Visible:=false;
    backCardArray[i].Bitmap.Assign(GameInterface.Image1.Bitmap);
  end;

end;

end.


