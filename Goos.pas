unit Goos;

interface

//{$IFDEF LINUX}
//const
//  LIBNAME = 'newrsa.so';
//  _PU = '';
//{$ENDIF}

{$IFDEF MSWINDOWS}
const
  currentSystem='Windows';
  {$R myMusic.Res}
{$ENDIF}

//{$IFDEF MACOS}
//const
//  LIBNAME = 'newrsa.dylib';
//{$ENDIF}

{$IFDEF ANDROID}
const
  currentSystem='Android';
{$ENDIF}

implementation



end.
