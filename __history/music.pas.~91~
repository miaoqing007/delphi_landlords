unit music;

interface

uses FMX.Media,system.Classes,FMX.Dialogs,SysUtils,FMX.Forms,system.IOUtils;

type mc = class

    public

    procedure PlayMusic(ResName,ResType, ResNewName: string);
    procedure SetMPlayerVolume(mp : TMediaPlayer;volume :single);
    procedure ExtractRes(ResName,ResType, ResNewName: string);
    procedure readCardNumber(cards :Tarray<string>;randomNum :string;ty :integer);
    procedure readsound(giveOrCall: integer);

    constructor Create();
    destructor Destory();
end;

var BC :mc;

implementation


uses game,goos;

constructor mc.Create();
begin
  if (goos.currentSystem='Windows')and
  not DirectoryExists(Tpath.GetDocumentsPath+PathDelim+'bgm')then
  begin
    CreateDir(Tpath.GetDocumentsPath+PathDelim+'bgm');
  end;

end;

destructor mc.Destory();
begin

end;

procedure mc.PlayMusic(ResName,ResType, ResNewName: string);
var
  fileName:string;
begin

  if goos.currentSystem='Windows' then
  begin
     fileName:= Tpath.GetDocumentsPath+PathDelim+'bgm'+PathDelim+ResNewName;
     if not fileExists(fileName) then
     begin
        ExtractRes(ResName,ResType,fileName);
     end;
  end
  else
  begin
    fileName:=Tpath.GetDocumentsPath+PathDelim+ResNewName;
  end;

  if not fileExists(filename) then
  begin
    exit;
  end;

  GameInterface.MediaPlayer1.FileName:=fileName;
  GameInterface.MediaPlayer1.Play;
end;


 procedure mc.ExtractRes(ResName,ResType, ResNewName: string);   //释放资源文件
var
    Res: TResourceStream;
begin
  Res := TResourceStream.Create(Hinstance, Resname, Pchar(ResType));
  Res.SaveToFile(ResNewName);
  Res.DisposeOf;
end;


procedure mc.readCardNumber(cards : Tarray<string>;randomNum :string;ty :integer);
var
temp,temp2 : string;
begin
  if length(cards)=0 then
  begin
    randomNum:=(randomNum.ToInteger+1).ToString;
    playMusic('SRCbuyao'+randomNum,'FILEbuyao'+randomNum,'Woman_buyao'+randomNum+'.mp3');
    exit;
  end;

 case ty of
   1: //单张
   begin
    delete(cards[0],1,1);
    if cards[0]='88' then
    begin
     playMusic('SRC'+cards[0],'FILE'+cards[0],'Woman_14'+'.mp3');
     exit;
    end;
    if cards[0]='99' then
    begin
     playMusic('SRC'+cards[0],'FILE'+cards[0],'Woman_15'+'.mp3');
     exit;
    end;
    if (cards[0]='14')or (cards[0]='15') then
    begin
      cards[0]:=(cards[0].ToInteger-13).ToString;
    end;
    playMusic('SRC'+cards[0],'FILE'+cards[0],'Woman_'+cards[0]+'.mp3');
   end;
   2: //对子
   begin
    delete(cards[0],1,1);
    if (cards[0]='14')or (cards[0]='15') then
      begin
        cards[0]:=(cards[0].ToInteger-13).ToString;
      end;
    temp:=(cards[0].ToInteger+15).ToString;
    playMusic('SRC'+temp,'FILE'+temp,'Woman_dui'+cards[0]+'.mp3');

   end;
   3: //三不带
   begin
   delete(cards[0],1,1);

   if (cards[0]='14') or (cards[0]='15') then
    begin
     cards[0]:=(cards[0].ToInteger-13).ToString;
    end;

   temp2:=(cards[0].ToInteger+28).ToString;

   playMusic('SRC'+temp2,'FILE'+temp2,'Woman_tuple'+cards[0]+'.mp3');

   end;
   4: //三带一
   begin
    playMusic('SRCsandaiyi','FILEsandaiyi','Woman_sandaiyi'+'.mp3');
   end;
   5: //炸弹
   begin
     playMusic('SRCzhadan','FILEzhadan','Woman_zhadan'+'.mp3');
   end;
   6: //连对
   begin
   playMusic('SRCliandui','FILEliandui','Woman_liandui'+'.mp3');
   end;
   7://顺子
   begin
     playMusic('SRCshunzi','FILEshunzi','Woman_shunzi'+'.mp3');
   end;
   8://王炸
   begin
     playMusic('SRCwangzha','FILEwangzha','Woman_wangzha'+'.mp3');
   end;
   9,10,11: //飞机
   begin
    playMusic('SRCfeiji','FILEfeiji','Woman_feiji'+'.mp3');
   end;
   12://三带二
   begin
     playMusic('SRCsandaiyidui','FILEsandaiyidui','Woman_sandaiyidui'+'.mp3');
   end;
   13://四带二
   begin
     playMusic('SRCsidaier','FILEsidaier','Woman_sidaier'+'.mp3');
   end;
 end;
end;


procedure mc.readsound(giveOrCall:integer);
begin
  case (giveOrCall) of
  1:
  begin
    playMusic('SRCOrder','FILEOrder','Woman_Order'+'.mp3'); //jiaodizhu
  end;
  2:
  begin
    playMusic('SRCNoOrder','FILENoOrder','Woman_NoOrder'+'.mp3'); //bujiao
  end;
  3:
  begin
    playMusic('SRCRob1','FILERob1','Woman_Rob1'+'.mp3'); //qiangdizhu
  end;
  4:
  begin
    playMusic('SRCNoRob','FILENoRob','Woman_NoRob'+'.mp3');//buqiang
  end;

  end;
end;

procedure mc.SetMPlayerVolume(mp :TMediaPlayer;volume : single);
begin
    mp.Volume:=volume;
end;

end.

