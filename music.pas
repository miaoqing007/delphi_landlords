unit music;

interface
//
//uses FMX.Media,system.Classes,FMX.Dialogs,SysUtils;
//
//type mc = class
//
//    public
//
//    procedure PlayMusic(ResName,ResType, ResNewName: string);
//    procedure SetMPlayerVolume(mp : TMediaPlayer;volume :single);
//    procedure ExtractRes(ResName,ResType, ResNewName: string);
//    procedure readCardNumber(cards :Tarray<string>;ty :integer);
//
//    constructor Create();
//    destructor Destory();
//end;
//
//var BC :mc;
//
implementation
//
//
//uses game;
//
//procedure mc.PlayMusic(ResName,ResType, ResNewName: string);
//begin
//
// if not fileExists(ResNewName) then
//  begin
//      ExtractRes(ResName,ResType,ResNewName);
//  end;
//  GameInterface.MediaPlayer1.FileName:=ResNewName;
//  GameInterface.MediaPlayer1.Play;
//
//end;
//
//
//constructor mc.Create();
//begin
//
//end;
//
//destructor mc.Destory();
//begin
//
//end;
//
//
//
//{$R myMusic.Res}
//
// procedure mc.ExtractRes(ResName,ResType, ResNewName: string);   //释放资源文件
//var
//    Res: TResourceStream;
//begin
//
//  Res := TResourceStream.Create(Hinstance, Resname, Pchar(ResType));
//  Res.SaveToFile(ResNewName);
//  Res.Free;
//
//end;
//
//
//procedure mc.readCardNumber(cards : Tarray<string>;ty :integer);
////var
//// str : string;
//begin
// case length(cards) of
//   0:
//   begin
//
//   end;
//   1:
//   begin
//   delete(cards[0],1,1);
//    playMusic('SRC'+cards[0],'FILE'+cards[0],cards[0]+'.mp3');
////    playMusic('cards[0]'+'.mp3');
//   end;
// end;
//
//end;
//
//
//
//procedure mc.SetMPlayerVolume(mp :TMediaPlayer;volume : single);
//begin
//    mp.Volume:=volume;
//end;

end.

