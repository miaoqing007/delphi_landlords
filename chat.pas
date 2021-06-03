unit chat;

interface

uses game,System.SysUtils;

type ChatClass = class

   public
   procedure  outputChatMessage(msg : string);

   constructor Create;
   destructor Destroy;

end;

var CC :ChatClass;

implementation

uses room;

constructor ChatClass.Create;
begin

end;

destructor ChatClass.Destroy;
begin

end;

procedure ChatClass.outputChatMessage(msg : string);
begin
  GameInterface.chatframe.Lines.Add(msg);
  if GameInterface.chaticon.Visible then
  begin
    rm.roomMsgNum:=rm.roomMsgNum+1;
    GameInterface.chathintNum.Text:=rm.roomMsgNum.ToString;
    GameInterface.chathint.Visible:=true;
  end;

end;

end.
