program landlords;

uses
  System.StartUpCopy,
  FMX.Forms,
  game in 'game.pas' {GameInterface},
  uDSimpleTcpClient in 'uDSimpleTcpClient.pas',
  tcp in 'tcp.pas',
  login in 'login.pas' {LoginFrame: TFrame};

{$R *.res}

begin
  Application.Initialize;
  //Application.CreateForm(TLoginInterface, LoginInterface);
  Application.CreateForm(TGameInterface, GameInterface);
  Application.Run;
end.
