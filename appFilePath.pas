unit appFilePath;

interface

uses system.IOUtils,SysUtils,goos;


var WinRootLandlordsDir,AndriodRootDir,WinRootBgmDir :string;

implementation

procedure InitPath;
begin
  WinRootLandlordsDir:=tpath.GetDocumentsPath+PathDelim+'landlords'+PathDelim;
  AndriodRootDir:=tpath.GetDocumentsPath+PathDelim;
  WinRootBgmDir:=WinRootLandlordsDir+'bgm'+PathDelim;

  if goos.currentSystem='Windows' then
  begin
    if not DirectoryExists(WinRootLandlordsDir) then
    begin
      CreateDir(WinRootLandlordsDir);
    end;
    if not DirectoryExists(WinRootBgmDir) then
    begin
      CreateDir(WinRootBgmDir);
    end;
  end;

end;

initialization
InitPath;

end.
