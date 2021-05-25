unit uDDesignListbox;

interface

uses
  System.Classes, System.SysUtils, System.Types, System.UITypes, FMX.InertialMovement,
  FMX.Types, FMX.Objects, FMX.Controls, fmx.StdCtrls, FMX.Graphics, System.Generics.Collections;

type TDDesignListboxType = (dltVert, dltHorz);


type IDDesignListBox = interface
  ['{5165D64E-86F3-4E37-9B0E-C09009A872F8}']
  procedure ResizeContent;
  procedure CalcItemsPosition;
  procedure SelectItem(AObj: TObject);
  function Updating: Boolean;
end;

const ScrollBarSize = 14;

type TDDesignListBoxItem = class
  private
    FPainting  : Boolean;
    FFontVAlign: TTextAlign;
    FFontHAlign: TTextAlign;
    FListBox   : IDDesignListBox;
    FCanvas    : TCanvas;
    FText      : string;
    FWidth     : Single;
    FHeight    : Single;
    FPosX      : Single;
    FPosY      : Single;
    FIcon      : TBitmap;
    FImage     : TBitmap;
    FDetail    : string;
    FDetail1   : string;
    FDetail2   : string;
    FDetail3   : string;
    FDetail4   : string;
    FDetail5   : string;
    FSelected  : Boolean;
  private
    procedure setText(const Value: string);
    procedure setHeight(const Value: Single);
    procedure setWidth(const Value: Single);
  private
    procedure Paint(ACanvas: TCanvas; AXOft: Single; AYOft: Single);
    procedure setX(const Value: Single);
    procedure setY(const Value: Single);
    procedure setSelected(const Value: Boolean);
  public
    Idx       : Integer;
    property Painting: Boolean read FPainting write FPainting;
  published
    property Text: string read FText write setText;
    property X: Single read FPosX write setX;
    property Y: Single read FPosY write setY;
    property Width: Single read FWidth write setWidth;
    property Height: Single read FHeight write setHeight;
    property Selected: Boolean read FSelected write setSelected;
    property Icon: TBitmap read FIcon write FIcon;
    property Image: TBitmap read FImage write FImage;
    property Detail: string read FDetail write FDetail;
    property Detail1: string read FDetail1 write FDetail1;
    property Detail2: string read FDetail2 write FDetail2;
    property Detail3: string read FDetail3 write FDetail3;
    property Detail4: string read FDetail4 write FDetail4;
    property Detail5: string read FDetail5 write FDetail5;
end;

type TDDesignListBox = class(TRectangle, IDDesignListBox)
  private
    FItems: TArray<TDDesignListBoxItem>;
    FListboxType: TDDesignListboxType;
    FAniCalc   : TAniCalculations;
    FVScrollBar : TScrollBar;
    FHScrollBar : TScrollBar;
    FSelected  : TDDesignListBoxItem;
    FOnClickItem: TNotifyEvent;
    FChanging: Boolean;
    FContentWidth: Single;
    FContentHeight: Single;
    FDesignControl: TControl;
    FDesignText: TText;
    FDesignImage: TImage;
    FDesignIcon: TImage;
    FDesignDetail: TText;
    FDesignDetail1: TText;
    FDesignDetail2: TText;
    FDesignDetail3: TText;
    FDesignDetail4: TText;
    FDesignDetail5: TText;
    FShowVertScrollBar: Boolean;
    FShowHorzScrollBar: Boolean;
    FOnPrepareDrawItem: TNotifyEvent;
    FDrawItemSelectedUIFunc: TNotifyEvent;
    FDrawItemUnSelectedUIFunc: TNotifyEvent;
    FOnChange: TNotifyEvent;
    FAutoCalcItemPos: Boolean;
    FUpdating: Boolean;
  private
    procedure OnAniCalcChanged(Sender: TObject);
    procedure OnVScrollBarChanged(Sender: TObject);
    procedure OnHScrollBarChanged(Sender: TObject);
    procedure SetTargets;
    function Updating: Boolean;
  private
    procedure SelectItem(AObj: TObject);
    function GetDesignControl: TControl;
    procedure SetDesignControl(const Value: TControl);
    procedure ResetDesignControlParamsByItem(AItem: TDDesignListBoxItem);
    procedure setShowHorzScrollBar(const Value: Boolean);
    procedure setShowVertScrollBar(const Value: Boolean);
    procedure FindTextControl(var AControl: TText; AParent: TFmxObject; AName: string);
    procedure FindImageControl(var AControl: TImage; AParent: TFmxObject; AName: string);
    procedure setListBoxType(const Value: TDDesignListboxType);
    function getItems(Index: Integer): TDDesignListBoxItem;
    procedure setSelected(const Value: TDDesignListBoxItem);
    procedure setAutoCalcItemPos(const Value: Boolean);
  protected
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean); override;
    procedure DoMouseLeave; override;
    procedure Resize; override;
    procedure OnScrollBarMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
  public
    procedure BeginUpdate;
    procedure EndUpdate;
    function AddItem: TDDesignListBoxItem;
    procedure ClearAll;
    procedure Scroll2Item(AItemIdx: Integer);
    function GetItemRect(AItem: TDDesignListBoxItem): TRectF;
    function Count: Integer;
    function FindItemByText(AText: string): TDDesignListBoxItem;
    function FindItemByDetail5(AText: string): TDDesignListBoxItem;
    procedure CalcItemsPosition;
    procedure ResizeContent;
    procedure ResizeScrollBar;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  public
    property Items[Index: Integer]: TDDesignListBoxItem read getItems;
  published
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Selected: TDDesignListBoxItem read FSelected write setSelected;
    property OnClickItem: TNotifyEvent read FOnClickItem write FOnClickItem;
    property DesignControl: TControl read GetDesignControl write SetDesignControl;
    property ListBoxType: TDDesignListboxType read FListboxType write setListBoxType;
    property ShowVertScrollBar: Boolean read FShowVertScrollBar write setShowVertScrollBar;
    property ShowHorzScrollBar: Boolean read FShowHorzScrollBar write setShowHorzScrollBar;
    property AutoCalcItemPos: Boolean read FAutoCalcItemPos write setAutoCalcItemPos;
    property OnPrepareDrawItem: TNotifyEvent read FOnPrepareDrawItem write FOnPrepareDrawItem;
    property DrawItemSelectedUIFunc: TNotifyEvent read FDrawItemSelectedUIFunc write FDrawItemSelectedUIFunc;
    property DrawItemUnSelectedUIFunc : TNotifyEvent read FDrawItemUnSelectedUIFunc write FDrawItemUnSelectedUIFunc;
    property _design_text: TText read FDesignText write FDesignText;
    property _design_image: TImage read FDesignImage write FDesignImage;
    property _design_icon: TImage read FDesignIcon write FDesignIcon;
    property _design_detail: TText read FDesignDetail write FDesignDetail;
    property _design_detail1: TText read FDesignDetail1 write FDesignDetail1;
    property _design_detail2: TText read FDesignDetail2 write FDesignDetail2;
    property _design_detail3: TText read FDesignDetail3 write FDesignDetail3;
    property _design_detail4: TText read FDesignDetail4 write FDesignDetail4;
    property _design_detail5: TText read FDesignDetail5 write FDesignDetail5;
end;

implementation

uses fmx.Forms;

{ TDDesignListBox }
function TDDesignListBox.AddItem: TDDesignListBoxItem;
var
  LX, LY: Single;
  LTarget1, LTarget2, LTarget3, LTarget4: TAniCalculations.TTarget;
  LMaxX, LMaxY: Single;
begin
  SetLength(FItems, Length(FItems)+1);
  FItems[High(FItems)] := TDDesignListBoxItem.Create;
  Result := FItems[High(FItems)];
  Result.Idx := High(FItems);
  Result.FListBox    := Self;
  Result.FCanvas     := Canvas;
  ResizeScrollBar;
end;

procedure TDDesignListBox.BeginUpdate;
begin
  FUpdating := True;
end;

procedure TDDesignListBox.CalcItemsPosition;
var
  I: Integer;
  LX, LY: Single;
begin
  if not FAutoCalcItemPos then
  Exit;

  if FListboxType = dltVert then
  begin
    LY := 0;
    for I := 0 to High(FItems) do
    begin
      FItems[I].FPosY := LY;
      LY := LY + FItems[I].Height;
    end;
  end else

  begin
    LX := 0;
    for I := 0 to High(FItems) do
    begin
      FItems[I].FPosX := LX;
      LX := LX + FItems[I].Width;
    end;
  end;

end;

procedure TDDesignListBox.ClearAll;
var
  I: Integer;
begin
  for I := High(FItems) downto 0 do
  begin
    FItems[I].DisposeOf;
  end;
  SetLength(FItems, 0);
end;

function TDDesignListBox.Count: Integer;
begin
  Result := Length(FItems);
end;

constructor TDDesignListBox.Create(AOwner: TComponent);
begin
  inherited;
  FAutoCalcItemPos := True;
  FUpdating   := False;

  FAniCalc    := TAniCalculations.Create(nil);
  Stroke.Kind := TBrushKind.None;
  Fill.Kind   := TBrushKind.None;

  FVScrollBar := TScrollBar.Create(Self);
  FVScrollBar.Parent := Self;
  FVScrollBar.Align := TAlignLayout.MostRight;
  FVScrollBar.Orientation := TOrientation.Vertical;
  FVScrollBar.Width := ScrollbarSize;
  FVScrollBar.OnChange := OnVScrollBarChanged;
  FVScrollBar.OnMouseDown := OnScrollBarMouseDown;

  FHScrollBar := TScrollBar.Create(Self);
  FHScrollBar.Parent := Self;
  FHScrollBar.Align := TAlignLayout.MostBottom;
  FHScrollBar.Height := ScrollbarSize;
  FHScrollBar.OnChange := OnHScrollBarChanged;
  FHScrollBar.OnMouseDown := OnScrollBarMouseDown;

  ClipChildren := True;
  FAniCalc.OnChanged := OnAniCalcChanged;
  FAniCalc.Animation := True;
  FAniCalc.BoundsAnimation := False;

  FShowVertScrollBar  := False;
  FShowHorzScrollBar  := False;
  FVScrollBar.Visible := False;
  FHScrollBar.Visible := False;

  FDesignText := nil;
  FDesignImage:= nil;
  FDesignIcon := nil;
  FDesignDetail := nil;
  FDesignDetail1 := nil;
  FDesignDetail2 := nil;
  FDesignDetail3 := nil;
  FDesignDetail4 := nil;
  FDesignDetail5 := nil;
end;

destructor TDDesignListBox.Destroy;
begin
  ClearAll;
  FAniCalc.DisposeOf;
  inherited;
end;

procedure TDDesignListBox.DoMouseLeave;
begin
  inherited;
  FAniCalc.MouseLeave;
end;

procedure TDDesignListBox.EndUpdate;
begin
  FUpdating := False;
  ResizeContent;
  CalcItemsPosition;
  ResizeScrollBar;
end;

procedure TDDesignListBox.FindTextControl(var AControl: TText; AParent: TFmxObject; AName: string);
var
  I: Integer;
begin
  if AParent = nil then
  Exit;

  for I := 0 TO AParent.ChildrenCount - 1 do
  begin
    if AParent.Children[I].Name = AName then
    begin
      AControl := AParent.Children[I] as TText;
      Exit;
    end;

    FindTextControl(AControl, AParent.Children[I], AName);
  end;
end;

procedure TDDesignListBox.FindImageControl(var AControl: TImage;
  AParent: TFmxObject; AName: string);
var
  I: Integer;
begin
  if AParent = nil then
  Exit;

  for I := 0 TO AParent.ChildrenCount - 1 do
  begin
    if AParent.Children[I].Name = AName then
    begin
      AControl := AParent.Children[I] as TImage;
      Exit;
    end;

    FindImageControl(AControl, AParent.Children[I], AName);
  end;
end;

function TDDesignListBox.FindItemByDetail5(AText: string): TDDesignListBoxItem;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to High(FItems) do
  begin
    if FItems[I].Detail5 = AText then
    Exit(FItems[I]);
  end;
end;

function TDDesignListBox.FindItemByText(AText: string): TDDesignListBoxItem;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to High(FItems) do
  begin
    if FItems[I].Text = AText then
    Exit(FItems[I]);
  end;
end;

function TDDesignListBox.GetDesignControl: TControl;
begin
  Result := FDesignControl;
end;

function TDDesignListBox.GetItemRect(AItem: TDDesignListBoxItem): TRectF;
begin
  Result := TRectF.Create(TPointF.Create(AItem.X-FAniCalc.ViewportPosition.X, AItem.Y-FAniCalc.ViewportPosition.Y), AItem.Width, AItem.Height);
end;

function TDDesignListBox.getItems(Index: Integer): TDDesignListBoxItem;
begin
  Result := FItems[Index];
end;

procedure TDDesignListBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Single);
begin
  inherited;

  FAniCalc.MouseDown(X, Y);
end;

procedure TDDesignListBox.MouseMove(Shift: TShiftState; X, Y: Single);
begin
  inherited;
  FAniCalc.MouseMove(X, Y);
end;

procedure TDDesignListBox.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Single);
var
  I: Integer;
  LAbsPt: TPointF;
  LItem: TDDesignListBoxItem;
  LDrawRect: TRectF;
begin
  inherited;
  FAniCalc.MouseUp(X, Y);
  if FAniCalc.Moved then
  Exit;
  for I := 0 to High(FItems) do
  begin
    LItem := FItems[I];
    LDrawRect := TRectF.Create(TPointF.Create(LItem.X, LItem.Y), LItem.Width, LItem.Height);
    LAbsPt := TPointF.Create(X+FAniCalc.ViewportPosition.X, Y + FAniCalc.ViewportPosition.Y);
    //fixme
    if LDrawRect.Contains(LAbsPt) then
    begin
      SelectItem(LItem);
      if Assigned(FOnClickItem) then
      begin
        FOnClickItem(FSelected);
      end;
    end else

    begin
      //TODO
      if LItem <> FSelected then
        LItem.FSelected := False;
    end;
  end;
  InvalidateRect(ClipRect);
end;

procedure TDDesignListBox.MouseWheel(Shift: TShiftState; WheelDelta: Integer;
  var Handled: Boolean);
begin
  inherited;
  FAniCalc.MouseWheel(0, -WheelDelta/10);
end;

procedure TDDesignListBox.OnAniCalcChanged(Sender: TObject);
begin
  InvalidateRect(ClipRect);

  if FChanging then
  Exit;

  FChanging := True;
  FVScrollBar.Value := FAniCalc.ViewportPosition.Y / FContentHeight * FVScrollBar.Max;
  FHScrollBar.Value := FAniCalc.ViewportPosition.X / FContentWidth * FHScrollBar.Max;

  FChanging := False;

  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TDDesignListBox.OnHScrollBarChanged(Sender: TObject);
begin
  if FChanging then
  Exit;

  FChanging := True;

  FAniCalc.ViewportPosition := TPointD.Create(FHScrollBar.Value/FHScrollBar.Max * FContentWidth, FAniCalc.ViewportPosition.Y);
  FChanging := False;

  if Assigned(FOnChange) then
   FOnChange(Self);
end;

procedure TDDesignListBox.OnScrollBarMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Single);
begin

end;

procedure TDDesignListBox.OnVScrollBarChanged(Sender: TObject);
begin
  if FChanging then
  Exit;

  FChanging := True;

  if FVScrollBar.Max = 0 then
  Exit;

  FAniCalc.ViewportPosition := TPointD.Create(FAniCalc.ViewportPosition.X, FVScrollBar.Value/FVScrollBar.Max*FContentHeight);
  FChanging := False;

  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TDDesignListBox.Paint;
var
  LOffsetX : Single;
  LOffsetY : Single;
  LDrawRect: TRectF;
  I        : Integer;
  LState   : TCanvasSaveState;
  LItem    : TDDesignListBoxItem;
  LItemDrawRect: TRectF;
  LBmp: TBitmap;
  LAbsPos: TPointF;
  LPaintCount: Integer;
begin
  inherited;
  LState := Canvas.SaveState;
  LPaintCount := 0;

  LAbsPos := LocalToAbsolute(TPointF.Zero);

  try
    LOffsetX := FAniCalc.ViewportPosition.X;
    LOffsetY := FAniCalc.ViewportPosition.Y;
    LDrawRect := LocalRect;
    LDrawRect.Offset(LOffsetX, LOffsetY);
    for I := 0 to High(FItems) do
    begin
      LItem := FItems[I];
      LItemDrawRect := TRectF.Create(TPointF.Create(LItem.X, LItem.Y), LItem.Width, LItem.Height);
      if LDrawRect.IntersectsWith(LItemDrawRect) or
        LDrawRect.Contains(LItemDrawRect) then
      begin
        Inc(LPaintCount);
        LItem.FPainting := True;
        if Assigned(FOnPrepareDrawItem) then
          FOnPrepareDrawItem(LItem);

        if LItem.Selected then
        begin
          if Assigned(FDrawItemSelectedUIFunc) then
            FDrawItemSelectedUIFunc(LItem);
        end else

        begin
          if Assigned(FDrawItemUnSelectedUIFunc) then
            FDrawItemUnSelectedUIFunc(LItem);
        end;


        ResetDesignControlParamsByItem(LItem);
        //LBmp := FDesignControl.MakeScreenshot;
        //Canvas.DrawBitmap(LBmp, TRectF.Create(TPointF.Zero, LBmp.Width, LBmp.Height), TRectF.Create(TPointF.Create(LItemDrawRect.Left-LOffsetX, LItemDrawRect.Top-LOffsetY), LItem.Width, LItem.Height), 1, False);
        //FDesignControl.Height := LItem.Height;
        FDesignControl.PaintTo(Canvas, TRectF.Create(TPointF.Create(LItemDrawRect.Left-LOffsetX+LAbsPos.X, LItemDrawRect.Top-LOffsetY+LAbsPos.Y), LItem.Width, LItem.Height));

        //LBmp.DisposeOf;
      end else

      begin
        LItem.FPainting := False;
      end;
    end;
  finally
    Canvas.RestoreState(LState);
  end;

end;

procedure TDDesignListBox.ResetDesignControlParamsByItem(
  AItem: TDDesignListBoxItem);
begin
  if FDesignText <> nil then
    FDesignText.Text := AItem.Text;

  if FDesignIcon <> nil then
    FDesignIcon.Bitmap.Assign(AItem.Icon);

  if FDesignImage <> nil then
    FDesignImage.Bitmap.Assign(AItem.Image);

  if FDesignDetail <> nil then
    FDesignDetail.Text := AItem.Detail;

  if FDesignDetail1 <> nil then
    FDesignDetail1.Text := AItem.Detail1;

  if FDesignDetail2 <> nil then
    FDesignDetail2.Text := AItem.Detail2;

  if FDesignDetail3 <> nil then
    FDesignDetail3.Text := AItem.Detail3;

  if FDesignDetail4 <> nil then
    FDesignDetail4.Text := AItem.Detail4;

   if FDesignDetail5 <> nil then
    FDesignDetail5.Text := AItem.Detail5;
end;

procedure TDDesignListBox.Resize;
begin
  inherited;

  //Added
  //ResizeContent;

  ResizeScrollBar;
end;


procedure TDDesignListBox.ResizeContent;
var
  I: Integer;
  LHeight, LWidth: Single;
  LHScrollBarHeight, LVScrollBarWidth: Single;
begin
  FContentWidth := 0;
  FContentHeight := 0;
  LHeight := 0;
  LWidth := 0;

  for I := 0 to High(FItems) do
  begin

    if FListboxType = dltVert then
    begin
      LHeight := LHeight + FItems[I].Height;
      if FContentWidth < FItems[I].Width then
        FContentWidth := FItems[I].Width;
    end else

    begin
      LWidth := LWidth + FItems[I].Width;
      if FContentHeight < FItems[I].Height then
        FContentHeight := FItems[I].Height;
    end;

    if LHeight > FContentHeight then
    begin
      FContentHeight := LHeight;
    end;

    if LWidth > FContentWidth then
    begin
      FContentWidth := LWidth;
    end;
  end;

  //FIXME BEGIN
  LVScrollBarWidth := 0;
  LHScrollBarHeight := 0;
  if FShowVertScrollBar and FVScrollBar.Visible then
  begin
    LVScrollBarWidth := ScrollBarSize;
  end;

  if FShowHorzScrollBar and FHScrollBar.Visible then
  begin
    LVScrollBarWidth := ScrollBarSize;
  end;
  //FIXME END

  //if FContentHeight > Height then
    FContentHeight := FContentHeight - Height + LHScrollBarHeight;

  //if FContentWidth > Width then
    FContentWidth := FContentWidth - Width + LVScrollBarWidth;



  SetTargets;
end;

procedure TDDesignListBox.ResizeScrollBar;
begin
  if FShowVertScrollBar then
  begin
    FVScrollBar.Max := FContentHeight;
    if FContentHeight <= 0 then
    begin
      FVScrollBar.Visible := False;
    end else FVScrollBar.Visible := True;
  end;

  if FShowHorzScrollBar then
  begin
    FHScrollBar.Max := FContentWidth;
    if FContentWidth <= 0 then
    begin
      FHScrollBar.Visible := False;
    end else FHScrollBar.Visible := True;
  end;
end;

procedure TDDesignListBox.Scroll2Item(AItemIdx: Integer);
var
  LItem: TDDesignListBoxItem;
begin
  if AItemIdx > High(FItems) then
  Exit;

  LItem := FItems[AItemIdx];
  FAniCalc.ViewportPosition := TPointF.Create(LItem.X, LItem.Y);
end;

procedure TDDesignListBox.SelectItem(AObj: TObject);
var
  I: Integer;
begin
  for I := 0 to High(FItems) do
  begin
    if AObj = FItems[I] then
    begin
      FItems[I].FSelected := True;
      FSelected := FItems[I];
      Continue;
    end;

    FItems[I].FSelected := False;
  end;
end;

procedure TDDesignListBox.setAutoCalcItemPos(const Value: Boolean);
begin
  FAutoCalcItemPos := Value;
  CalcItemsPosition;
end;

procedure TDDesignListBox.SetDesignControl(const Value: TControl);
begin
  FDesignControl := Value;
  if FDesignControl = nil then
  Exit;

  FDesignControl.Visible := False;

//   FindImageControl(FDesignImage, FDesignControl, '_design_image');
//   FindTextControl(FDesignText, FDesignControl, '_design_text');
//   FindImageControl(FDesignIcon, FDesignControl, '_design_icon');
//   FindTextControl(FDesignDetail, FDesignControl, '_design_detail');
//   FindTextControl(FDesignDetail1, FDesignControl, '_design_detail1');
//   FindTextControl(FDesignDetail2, FDesignControl, '_design_detail2');
//   FindTextControl(FDesignDetail3, FDesignControl, '_design_detail3');
//   FindTextControl(FDesignDetail4, FDesignControl, '_design_detail4');
//   FindTextControl(FDesignDetail5, FDesignControl, '_design_detail5');
end;

procedure TDDesignListBox.setListBoxType(const Value: TDDesignListboxType);
begin
  FListboxType := Value;
  InvalidateRect(ClipRect);
end;

procedure TDDesignListBox.setSelected(const Value: TDDesignListBoxItem);
begin
  FSelected := Value;
  SelectItem(Value);
end;

procedure TDDesignListBox.setShowHorzScrollBar(const Value: Boolean);
begin
  FShowHorzScrollBar := Value;
  FHScrollBar.Visible := Value;
end;

procedure TDDesignListBox.setShowVertScrollBar(const Value: Boolean);
begin
  FShowVertScrollBar := Value;
  FVScrollBar.Visible := Value;
end;

procedure TDDesignListBox.SetTargets;
var
  LTarget1,LTarget2: TAniCalculations.TTarget;
  LMaxX, LMaxY: Single;
begin
  LTarget1.Point := TPointF.Zero;
  LTarget1.TargetType := TAniCalculations.TTargetType.Min;

  if FContentWidth <= 0 then
  begin
    LMaxX := 0;
  end else LMaxX := FContentWidth;

  if FContentHeight <= 0 then
  begin
    LMaxY := 0;
  end else LMaxY := FContentHeight;

  LTarget2.Point := TPointF.Create(LMaxX, LMaxY);

  LTarget2.TargetType := TAniCalculations.TTargetType.Max;
  FAniCalc.SetTargets ([LTarget1, LTarget2]);
end;

function TDDesignListBox.Updating: Boolean;
begin
  Result := FUpdating;
end;

{ TDDesignListBoxItem }

procedure TDDesignListBoxItem.Paint(ACanvas: TCanvas; AXOft: Single; AYOft: Single);
begin

end;

procedure TDDesignListBoxItem.setHeight(const Value: Single);
begin
  FHeight := Value;

  if FListBox.Updating then
  Exit;

   //todo
  FListBox.CalcItemsPosition;
  FListBox.ResizeContent;
end;

procedure TDDesignListBoxItem.setSelected(const Value: Boolean);
begin
  FSelected := Value;
  if Value then
    FListBox.SelectItem(Self);
end;

procedure TDDesignListBoxItem.setText(const Value: string);
var
  LFontWidth: Single;
begin
  FText := Value;
end;

procedure TDDesignListBoxItem.setWidth(const Value: Single);
begin
  FWidth := Value;
  //todo

  if FListBox.Updating then
  Exit;

  FListBox.ResizeContent;
  FListBox.CalcItemsPosition;
end;

procedure TDDesignListBoxItem.setX(const Value: Single);
begin
  FPosX := Value;
  if FListBox.Updating then
  Exit;

  FListBox.ResizeContent;
end;

procedure TDDesignListBoxItem.setY(const Value: Single);
begin
  FPosY := Value;
  if FListBox.Updating then
  Exit;

  FListBox.ResizeContent;
end;

end.
