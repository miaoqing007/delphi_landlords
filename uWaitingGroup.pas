unit uWaitingGroup;

interface

uses System.SyncObjs;

type TWaitGroup = class
  private
    FCount: Integer;
    FMutex: TMutex;
  public
    procedure WaitDone;
    procedure Add(ACount: Integer);
    procedure Done;
  public
    constructor Create;
    destructor Destroy; override;
end;

implementation


{ TWaitGroup }

procedure TWaitGroup.Add(ACount: Integer);
var
  I: Integer;
begin
  FMutex.Acquire;
  for I := 0 to ACount-1 do
  begin
    FCount := FCount + 1;
  end;
  FMutex.Release;
end;

constructor TWaitGroup.Create;
begin
  FCount := 0;
  FMutex := TMutex.Create;
end;

destructor TWaitGroup.Destroy;
begin
  FMutex.DisposeOf;
  inherited;
end;

procedure TWaitGroup.Done;
begin
  FMutex.Acquire;
  FCount := FCount - 1;
  FMutex.Release;
end;

procedure TWaitGroup.WaitDone;
begin
  while FCount > 0 do
  begin

  end;
end;

end.
