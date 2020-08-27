unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  BinPacking.MaxRectsBinPack,
  System.Generics.Collections, Math;

type
  TMainForm = class(TForm)
    Button1: TButton;
    imgSource: TImage;
    imgDest: TImage;
    procedure Button1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    procedure Calculate;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.Button1Click(Sender: TObject);
begin
  Calculate;
end;

function GenerateRandomColor(const Mix: TColor = clWhite): TColor;
var
  Red, Green, Blue: Integer;
begin
  Red := Random(256);
  Green := Random(256);
  Blue := Random(256);

  Red := (Red + GetRValue(ColorToRGB(Mix))) div 2;
  Green := (Green + GetGValue(ColorToRGB(Mix))) div 2;
  Blue := (Blue + GetBValue(ColorToRGB(Mix))) div 2;
  Result := RGB(Red, Green, Blue);
end;

procedure TMainForm.Calculate;
var
  FMaxRectsBinPack: TMaxRectsBinPack;

  allowFlip: Boolean;
  height: Integer;
  width: Integer;

  method: TFreeRectChoiceHeuristic;
  dst: TList<TRect>;
  rects: TList<TRect>;
  expectedOccupancy: Single;

  colors: TList<TColor>;
  I,y,w,h: Integer;

  sourceBMP, destBMP: TBitmap;
  rct:TRect;
begin
  colors := TList<TColor>.create;

  sourceBMP := TBitmap.create;
  destBMP := TBitmap.create;

  try
    Randomize;
    for I := 0 to 100 do
    begin
      colors.Add(GenerateRandomColor());
    end;

    FMaxRectsBinPack := TMaxRectsBinPack.create;

    width := 600;
    height := 1200;
    allowFlip := False;

    FMaxRectsBinPack.Init(width, height, allowFlip);
    destBMP.Width := width;
    destBMP.Height:= height;

    Assert(FMaxRectsBinPack.Occupancy = 0, 'Area is not free');
    Assert(FMaxRectsBinPack.height = height);
    Assert(FMaxRectsBinPack.width = width);

    method := frchRectBestAreaFit;
    dst := TList<TRect>.create;
    rects := TList<TRect>.create;
    rects.Add(Rect(0, 0, 100, 100));
    rects.Add(Rect(0, 0, 100, 100));
    rects.Add(Rect(0, 0, 100, 100));
    rects.Add(Rect(0, 0, 100, 100));
    rects.Add(Rect(0, 0, 100, 100));
    rects.Add(Rect(0, 0, 1000, 1000));
    rects.Add(Rect(0, 0, 200, 130));
    rects.Add(Rect(0, 0, 100, 1250));
    rects.Add(Rect(0, 0, 340, 600));
    rects.Add(Rect(0, 0, 100, 900));
    rects.Add(Rect(0, 0, 120, 700));
    rects.Add(Rect(0, 0, 500, 900));

    w:=0;
    h:=0;
    for I := 0 to rects.Count -1 do begin
      rct := rects[i];
      w := w + rects[i].Width;
      h := h + rects[i].Height;
    end;

    sourceBMP.Width := w;
    sourceBMP.Height:= h;


    y:=0;
    for I := 0 to rects.Count -1 do begin
      rct := rects[i];
      rct.Offset(0,y);
      sourceBMP.Canvas.Brush.Color := colors[i];
      sourceBMP.Canvas.Rectangle(rct);
      y := y + rects[i].Height;
    end;

    FMaxRectsBinPack.Insert(rects, dst, method);

    //Assert(dst.Count = 5, Format('Count: %d', [dst.Count]));

//    expectedOccupancy := 0.20;
//    Assert(SameValue(FMaxRectsBinPack.Occupancy, expectedOccupancy));

    for I := 0 to dst.Count -1 do begin
      rct := dst[i];
      destBMP.Canvas.Brush.Color := colors[i];
      destBMP.Canvas.Rectangle(rct);
    end;

    imgSource.Picture.Assign(sourceBMP);
    imgDest.Picture.Assign(destBMP);

  finally
    FMaxRectsBinPack.Free;
    sourceBMP.Free;
    destBMP.Free;
    colors.Free;

  end;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  imgSource.Width := (ClientWidth - 30) div 2;
  imgDest.Left := imgSource.Width + 10;
  imgDest.Width := (ClientWidth - 30) div 2;
end;

end.
