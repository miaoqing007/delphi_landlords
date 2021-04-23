unit uToast;

interface

uses
  FMX.Types, FMX.Ani, FMX.Controls, FMX.Objects, FMX.Forms, FMX.Effects, System.UITypes, System.Math,
  FMX.Graphics;

const
  Rect_Padding_Hor = 30;  //水平（左右）向内缩进大小
  Rect_Padding_Ver = 10;   //垂直（上下）向内缩进大小

var
  Visble: Boolean;

type
  TToastLengthValue = type Single;

  TToastLength = record
  const
    Toast_LENGTH_VERYSHORT = 1;
    Toast_LENGTH_SHORT = 2;
    Toast_LENGTH_LONG = 3.5;
    Toast_LENGTH_VREY_LONG = 10;
  end;

  TToast = class(TFmxObject)
  private
    retToast: TRectangle;
    txtToast: TText;
    aniToast: TFloatAnimation;
    sdeToast: TShadowEffect;
  public
    constructor Create(AOwner: TControl);
    destructor Destroy;

    procedure ToastAnimationFinish(Sender: TObject);
    procedure ToastProcess(Sender: TObject);

    class procedure MakeText(AParentForm: TControl; const AMsg: String;
      AShowTimeLong: TToastLengthValue;iscenter:Boolean=True);
  end;

implementation

{ TToast }

constructor TToast.Create(AOwner: TControl);
begin
  //inherited;

  //显示的背景框
  retToast := TRectangle.Create(AOwner);
  retToast.Padding.Left := Rect_Padding_Hor;
  retToast.Padding.Right := Rect_Padding_Hor;
  retToast.Padding.Top := Rect_Padding_Ver;
  retToast.Padding.Bottom := Rect_Padding_Ver;
  retToast.Fill.Color := TAlphaColorRec.Black;
  retToast.Parent := AOwner;
  retToast.YRadius := 10;
  retToast.XRadius := 10;
  retToast.Fill.Kind := TBrushKind.Solid;

  //显示动画，显示一定时间后消失
  aniToast := TFloatAnimation.Create(AOwner);
  aniToast.Parent := retToast;
  aniToast.AnimationType := TAnimationType.InOut;

  aniToast.PropertyName := 'Opacity';
  aniToast.StartValue := 1;
  aniToast.StopValue := 0;
  aniToast.Trigger := 'IsVisible=true';

  aniToast.Loop := false;

  //retToast.ApplyTriggerEffect(retToast, 'IsVisible');

  aniToast.OnFinish := ToastAnimationFinish;
  aniToast.OnProcess := ToastProcess;

  //阴影
  sdeToast := TShadowEffect.Create(AOwner);
  sdeToast.Parent := retToast;
  sdeToast.Direction := 45;
  sdeToast.Distance := 2;
  sdeToast.Opacity := 0.6;
  sdeToast.ShadowColor := TAlphaColorRec.Black;
  sdeToast.Softness := 0.2;
end;

destructor TToast.Destroy;
begin
  retToast.DISPOSEOF;
  txtToast.DISPOSEOF;
  aniToast.DISPOSEOF;
  sdeToast.DISPOSEOF;
end;

class procedure TToast.MakeText(AParentForm: TControl; const AMsg: String;
  AShowTimeLong: TToastLengthValue;iscenter:Boolean=True);
var
  toast: TToast;
begin
  if Visble then
  Exit;

  Visble := True;
  toast := TToast.Create(AParentForm);
  try
  //显示的文本框
    toast.txtToast := TText.Create(nil);
    //计算文本的宽度和高度
    toast.txtToast.Text := '';
    toast.txtToast.Color := TAlphaColorRec.White;
    toast.txtToast.Font.Size := 11;
    toast.txtToast.Font.Style := [TFontStyle.fsBold];

    toast.txtToast.Text := AMsg;
    toast.txtToast.Align := TAlignLayout.alNone;
    toast.txtToast.HorzTextAlign := TTextAlign.taLeading;
    toast.txtToast.VertTextAlign := TTextAlign.taLeading;
    toast.txtToast.Width := max(0, AParentForm.Width - (50 + Rect_Padding_Hor) * 2);
    toast.txtToast.Height := max(0, AParentForm.Height - (20 + Rect_Padding_Ver) * 2);
    toast.txtToast.WordWrap := true;
    toast.txtToast.AutoSize := true;

    toast.retToast.Width := toast.txtToast.Width + Rect_Padding_Hor * 2 ;
    toast.retToast.Height := toast.txtToast.Height + Rect_Padding_Ver * 2;

    toast.txtToast.Parent := toast.retToast;
    toast.txtToast.Align := TAlignLayout.alClient;

    toast.retToast.Position.X := (AParentForm.Width - toast.txtToast.Width) / 2;
    if iscenter then

    toast.retToast.Position.Y := (AParentForm.Height - 20 - toast.txtToast.Height - Rect_Padding_Ver * 2)/2 //距离窗体底部20
    else
    toast.retToast.Position.Y := (AParentForm.Height - 20 - toast.txtToast.Height - Rect_Padding_Ver * 2) ;
    toast.aniToast.Duration := AShowTimeLong;

    toast.aniToast.Enabled := true;

    toast.retToast.Visible := true;
    toast.txtToast.Visible := true;
    toast.retToast.Align := TAlignLayout.Center;
    //toast.retToast.BringToFront;

//    toast.retToast.StartTriggerAnimation(toast.retToast, 'IsVisible');
  finally
    //toast.Free;
  end;
end;


procedure TToast.ToastAnimationFinish(Sender: TObject);
begin
  retToast.Visible := false;
  Visble := False;
  self.Free;
end;

procedure TToast.ToastProcess(Sender: TObject);
begin
  //retToast.BringToFront;
end;

end.
