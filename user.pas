unit user;

interface

type UserInfo = class
  private
  UserId:string;
  Name:string;
  Cards : array of string;

  public
  ifInGamimg :boolean;

  public
  procedure SetUserId(uid :string);
  procedure SetUserName(name:string);
  procedure SetIfInGaming(result : boolean);
  function GetUserId():string;
  function GetUserName():string;

  constructor Create;
  destructor Destroy; override;
end;

var UI:UserInfo;

implementation

constructor UserInfo.Create;
begin
//  Userinfo.Create;
end;


destructor UserInfo.Destroy;
begin

end;

procedure UserInfo.SetUserName(name :string);
begin
  Name := name;
end;

procedure  UserInfo.SetUserId(uid:string);
begin
  UserId := uid;
end;

procedure UserInfo.SetIfInGaming(result : boolean);
begin
  ifInGamimg:=result;
end;

function UserInfo.GetUserId():string;
begin
  Result:=UserId;
end;

function UserInfo.GetUserName():string;
begin
  Result:=Name;
end;

end.
