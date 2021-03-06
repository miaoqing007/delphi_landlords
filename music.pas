unit music;

interface

uses FMX.Media,system.Classes,FMX.Dialogs,SysUtils,FMX.Forms,system.IOUtils,appfilepath;

type mc = class

    public

    procedure PlayMusic(ResName,ResType, filename: string);
    procedure SetMPlayerVolume(mp : TMediaPlayer;volume :single);
    procedure ExtractRes(ResName,ResType, ResNewName: string);
    procedure readCardNumber(cards :Tarray<string>;randomNum :string;ty :integer);
    procedure readsound(giveOrCall: integer);
    procedure playbackgroundmusic(ResName,ResType, filename: string);

    constructor Create();
    destructor Destory();
end;

var BC :mc;

implementation


uses game,goos;

constructor mc.Create();
begin
//  if (goos.currentSystem='Windows')and
//  not DirectoryExists(Tpath.GetDocumentsPath+PathDelim+'bgm')then
//  begin
//    CreateDir(Tpath.GetDocumentsPath+PathDelim+'bgm');
//  end;
end;

destructor mc.Destory();
begin

end;

procedure mc.PlayMusic(ResName,ResType, filename: string);
var
  pathfileName:string;
begin

  if goos.currentSystem='Windows' then
  begin
     pathfileName:= appfilepath.WinRootBgmDir+filename;
     if not fileExists(pathfileName) then
     begin
        ExtractRes(ResName,ResType,pathfileName);
     end;
  end
  else
  begin
    pathfileName:=appfilepath.AndriodRootDir+filename;
  end;

  if not fileExists(pathfileName) then
  begin
    exit;
  end;

  GameInterface.MediaPlayer1.FileName:=pathfileName;
  GameInterface.MediaPlayer1.Play;
end;


procedure mc.playbackgroundmusic(ResName,ResType, filename: string);
var
  pathfileName:string;
begin

  if goos.currentSystem='Windows' then
  begin
     pathfileName:= appfilepath.WinRootBgmDir+filename;
     if not fileExists(pathfileName) then
     begin
        ExtractRes(ResName,ResType,pathfileName);
     end;
  end
  else
  begin
    pathfileName:=appfilepath.AndriodRootDir+filename;
  end;

  if not fileExists(pathfileName) then
  begin
    exit;
  end;

//  GameInterface.MediaPlayer2.FileName:=pathfileName;
//  GameInterface.MediaPlayer2.Play;
end;

 procedure mc.ExtractRes(ResName,ResType, ResNewName: string);   //????????????
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
   1: //????
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
   2: //????
   begin
    delete(cards[0],1,1);
    if (cards[0]='14')or (cards[0]='15') then
      begin
        cards[0]:=(cards[0].ToInteger-13).ToString;
      end;
    temp:=(cards[0].ToInteger+15).ToString;
    playMusic('SRC'+temp,'FILE'+temp,'Woman_dui'+cards[0]+'.mp3');

   end;
   3: //??????
   begin
   delete(cards[0],1,1);

   if (cards[0]='14') or (cards[0]='15') then
    begin
     cards[0]:=(cards[0].ToInteger-13).ToString;
    end;

   temp2:=(cards[0].ToInteger+28).ToString;

   playMusic('SRC'+temp2,'FILE'+temp2,'Woman_tuple'+cards[0]+'.mp3');

   end;
   4: //??????
   begin
    playMusic('SRCsandaiyi','FILEsandaiyi','Woman_sandaiyi'+'.mp3');
   end;
   5: //????
   begin
     playMusic('SRCzhadan','FILEzhadan','Woman_zhadan'+'.mp3');
   end;
   6: //????
   begin
   playMusic('SRCliandui','FILEliandui','Woman_liandui'+'.mp3');
   end;
   7://????
   begin
     playMusic('SRCshunzi','FILEshunzi','Woman_shunzi'+'.mp3');
   end;
   8://????
   begin
     playMusic('SRCwangzha','FILEwangzha','Woman_wangzha'+'.mp3');
   end;
   9,10,11: //????
   begin
    playMusic('SRCfeiji','FILEfeiji','Woman_feiji'+'.mp3');
   end;
   12://??????
   begin
     playMusic('SRCsandaiyidui','FILEsandaiyidui','Woman_sandaiyidui'+'.mp3');
   end;
   13://??????
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

