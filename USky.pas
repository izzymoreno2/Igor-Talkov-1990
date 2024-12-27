unit USky;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, UWorld, JPEG;

  Const
//������������ ����� �������� ����
ImgSkyMax = 8;
// ����� ������� � ���� ����� �������� ����������� 16 ��� 10
  TextureWidth = 108;
// ����� �������� �����, �������� ����������
  GameSkyMaxX = 18;
//������ �������� ������������
  GameSkyConst: array[0..GameSkyMaxX - 1] of byte = (0, 1, 2, 3, 4, 5, 6, 7, 8,
  0, 1, 2, 3, 4, 5, 6, 7, 8);
//                                                     0, 1, 2, 3, 4, 5, 6, 7, 8);
//                                                     0, 1, 2, 3, 4, 5, 6, 7, 8,
//                                                     0, 1, 2, 3, 4, 5, 6, 7, 8,
//                                                     0, 1, 2, 3, 4, 5, 6, 7, 8,
//                                                     0, 1, 2, 3, 4, 5, 6, 7, 8,
//                                                     0, 1, 2, 3, 4, 5, 6, 7, 8,
//                                                     0, 1, 2, 3, 4, 5, 6, 7, 8,
//                                                     0, 1, 2, 3, 4, 5, 6, 7, 8);

type

  TGameSky = class (TObject)
  public
  //TimerAnimation: TTimer;
  //������ �������� �������� ������������
  SkyX, SkyY: integer;
  ImgGameSky: array[0..ImgSkyMax] of TJPEGImage;
  //����� ������� ����
  GameSkyArr: array[0..GameSkyMaxX - 1] of integer;
  //procedure TimerAnimationProccessing(Sender: TObject);
  procedure Show;
  Constructor CreateGameSky(ownerForm: TWinControl);
  Destructor Destroy(); override;
  end;

implementation

Uses UMainProg, UStar;

constructor TGameSky.CreateGameSky(ownerForm: TWinControl);
var
i:integer;
begin
//����������� �������� ���������� �������� ������������ �� X � Y
SkyX := 0;//40
SkyY := 120;

for i := 0 to length(GameSkyArr) - 1 Do
  begin
  GameSkyArr[i] := GameSkyConst[i];
  end;

   For i := 0 to length(ImgGameSky) - 1  Do
   begin
   ImgGameSky[i]:=TJPEGImage.Create;
//   ImgGameSky[i].LoadFromFile(ExePath + 'Graphics\SkyJpeg\ + '.jpg');
   ImgGameSky[i].LoadFromFile(ExePath + 'Graphics\SkyJpeg\Sky'+IntToStr(i)+'.jpg');
   ImgGameSky[i].Transparent:=True;
//   ImgGameSky[0].TransparentMode:=tmFixed;
//   ImgGameSky[0].TransparentColor:=clBlack;
   //ImgMassStar[i].Canvas.Brush.Color:=clPurple;
   end;
//�������� ������ ����
//self.TimerAnimation := TTimer.Create(nil);
//self.TimerAnimation.OnTimer:=self.TimerAnimationProccessing;
//self.TimerAnimation.Interval:=round((Random*200)+500);
//TimerAnimation.Enabled:=true;
end;

procedure TGameSky.Show();
var
i, Xscreen: integer;
sprindex: byte;
FirstBrick: integer;
LastBrick : integer;
begin
xScreen := 0;

//�� ������ ������� ���������� XWorld ����������� � ������ ������, � �������� �� ������ ������ �������� ������� ������������.
FirstBrick := round(SkyX div TextureWidth);
LastBrick := FirstBrick + round(VirtBitmap.Width div TextureWidth * TextureWidth/TextureWidth);
if FirstBrick <= 0 then
  begin
  FirstBrick := 0;
  if SkyX < 0 then SkyX:= 0;
  end;
if LastBrick >= Length(GameSkyArr) then
  begin
  LastBrick := Length(GameSkyArr);
  if SkyX > (((LastBrick + 1) * TextureWidth) - VirtBitmap.Width) then SkyX := ((LastBrick + 1) * TextureWidth) - VirtBitmap.Width;
  end;
xScreen := -round(SkyX - SkyX div TextureWidth * TextureWidth);
for i := FirstBrick to LastBrick do
  begin
   //������ �� ������� �������� ������������ ����� �������
  sprindex := self.GameSkyArr[i];
  //���������� ����������� Xscreen � ���������� ������������ ������.
  VirtBitmap.Canvas.Draw(xScreen, self.SkyY, self.ImgGameSky[sprindex]);
  // ���������� 10. 10 - ������ �������� �� 10 ��������, ���� ���
  xScreen:= xScreen + TextureWidth;
  end;

VirtBitmap.Canvas.Font.Size := 8;
VirtBitmap.Canvas.Font.Color := clWhite;
VirtBitmap.Canvas.TextOut( 300, 10, 'USkyX=' + inttostr(SkyX));
VirtBitmap.Canvas.TextOut( 300, 30, 'FirstBrickStars=' + inttostr(FirstBrick));
VirtBitmap.Canvas.TextOut( 300, 50, 'LastBrickStars=' + inttostr(LastBrick));

end;


//��� ���������� �������� �������� ������������
destructor TGameSky.Destroy;
var
i:byte;
begin
//����� �� ������� �� ������ �����
For i:=0 to length(ImgGameSky) - 1  Do
   begin
   ImgGameSky[i].Free;
   //ImgMassStar[i].Canvas.Brush.Color:=clPurple;
   end;
//������� ������
//TimerAnimation.free;
//����� ����������� ������������� ������
inherited;
end;

end.
