unit UMainProg;

interface

//����� ������������ �������� ������ � ������, ������� ������ �����������
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Math, StdCtrls, UStar, UWorld, UTalkoff, UBorezkiy, USky, uWriteThread, SyncObjs;

Const
//�������� ���������
//������������ ���������� ����
MaxStars = 100;
//������ ������
xmax = 1080;
ymax = 980;
xmin = 0;
ymin = 0;
XScreenMax = 1080;
YScreenMax = 980;


type
  TForm1 = class(TForm)
    Image1: TImage;

//������ �������� ��������
    TimerFPS: TTimer;
    Timer1: TTimer;
    //�������� ���������, ������� ������ ����������
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    //�������� ������ �����
    procedure TimerFPSTimer(Sender: TObject);
    procedure DrawFrame();
    //��������� ������� �� �������
    function OverlapRects(R1, R2: TRect): boolean;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    //��������� ���������� �������
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  procedure InitGame();
  end;

var
  //�������� ����� �������� ������������
  Form1: TForm1;
  //�������� ���� � exe-�����
  ExePath: string;
  //������ ����
  //������ �������� ����
  Stars: array[0..MaxStars - 1] of TMyStar;
  //������ �����
  Talkoff: TTalkoff;
  //������� ������������
  //���
  GameWorld: TGameWorld;
  //����
  GameSky: TGameSky;
  //������� ������
  WriteThread : TWriteThread;
  CriticalSection: TCriticalSection;
  Tick, FPS: integer;
  //������ �������� �����
  TalkoffSpritesArrLeft: TList;
  TalkoffSpritesArrRight: TList;
  TalkoffSpritesArrKickFistLeft: TList;
  TalkoffSpritesArrKickFistRight: TList;

//������ �������� ����� ���������
  BorezkiySpritesArrLeft: TList;
  BorezkiypritesArrRight: TList;
  BorezkiySpritesArrKickFistLeft: TList;
  BorezkiySpritesArrKickFistRight: TList;


//������� ����������� Canvas
VirtBitmap: TBitmap;

//����
implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
var
i:integer;
SX,SY:integer;
begin
Tick := gettickcount();
ExePath := ExtractFilePath(Application.ExeName);
//��������� Canvas ������ ������
//�������� ������ ��������
self.TimerFPS.Enabled:=false;
self.TimerFPS.Interval:=20;
//��������� ������� ������������ ������ ������
Form1.Image1.Canvas.Brush.Color:=clBlack;
//������ ������� ��������������
Form1.Image1.Canvas.FillRect(Rect(xmin,ymin,XScreenMax,YScreenMax));
//������ ������
Form1.Image1.Width:=XScreenMax;
//������ ������
Form1.Image1.Height:=YScreenMax;
//������ ����������� Bitmap
VirtBitmap:=TBitmap.Create;
VirtBitmap.Width:=Image1.Width;
VirtBitmap.Height:=Image1.Height;
VirtBitmap.Canvas.Brush.Color:=clBlack;
VirtBitmap.Canvas.FillRect(Rect(xmin,ymin,XScreenMax,YScreenMax));
InitGame();
//������ �����
for i := 0 to MaxStars-1 do
   begin
   //������ ����� � ������������� ������������ ���������� �� X � ��������� �� Y
//�� X
   SX:=round(Random*xmax);
//
   SY:=round(Random*105);
//�� Y
   Stars[i]:= TMyStar.CreateStar(SX,SY, 'left', Form1);
   end;
//������ ������� ������������
//���
GameWorld := TGameWorld.CreateGameWorld(Form1);
//����
GameSky :=  TGameSky.CreateGameSky(Form1);

//������ ����� � ��� ������������
Talkoff := TTalkoff.CreateTalkoff(305, 505, Form1, TalkoffSpritesArrLeft, TalkoffSpritesArrRight, TalkoffSpritesArrKickFistLeft, TalkoffSpritesArrKickFistRight
                             {TalkoffSpritesArrSitLeft, TalkoffSpritesArrSitRight});

//�������� ������ ���������
self.TimerFPS.Enabled:=true;
//������� ����� �����
WriteThread := TWriteThread.Create(False);
CriticalSection := TCriticalSection.Create;
WriteThread.Priority := tpNormal;//Highest;//tpHighest;
WriteThread.Priority := tpHigher;//tpHighest;
WriteThread.Priority := tpTimeCritical;
//InitializeCriticalSection(CS);
end;

//������������� ����
procedure TForm1.InitGame;
var
i:integer;
tmpBitmap: TBitmap;
begin
//��������� � ������� ����� ���������� �����
TalkoffSpritesArrLeft := TList.Create;
For i:=0 to MaxImgTalkoffMoveLeft - 1 Do
   begin
   tmpBitmap :=TBitmap.Create;
   //�������� ����
   tmpBitmap.LoadFromFile(ExePath+'Graphics\Talkoff\TalkoffMoveLeft\moving_tallf'+IntToStr(i)+'.bmp');
   tmpBitmap.Transparent:=True;
   tmpBitmap.TransparentMode:=tmFixed;
   tmpBitmap.TransparentColor:=clBlack;
   //��������� � ������
   TalkoffSpritesArrLeft.Add(tmpBitmap);
   end;
//��������� � ������� ����� ���������� ������
TalkoffSpritesArrRight := TList.Create;
For i:=0 to MaxImgTalkoffMoveRight - 1 Do
   begin
   tmpBitmap :=TBitMap.Create;
   tmpBitmap.LoadFromFile(ExePath+'Graphics\Talkoff\TalkoffMoveRight\moving_tallf'+IntToStr(i)+'.bmp');
   tmpBitmap.Transparent:=True;
   tmpBitmap.TransparentMode:=tmFixed;
   tmpBitmap.TransparentColor:=clBlack;
   TalkoffSpritesArrRight.Add(tmpBitmap);
   end;
//��������� � ������� ����� ������� ������� �����
TalkoffSpritesArrKickFistLeft := TList.Create;
For i:=0 to MaxImgTalkoffFistLeft - 1 Do
   begin
   tmpBitmap :=TBitmap.Create;
   //�������� ����
   tmpBitmap.LoadFromFile(ExePath+'Graphics\Talkoff\TalkoffKickFistLeft\Hand_left'+IntToStr(i)+'.bmp');
   tmpBitmap.Transparent:=True;
   tmpBitmap.TransparentMode:=tmFixed;
   tmpBitmap.TransparentColor:=clBlack;
   //��������� � ������
   TalkoffSpritesArrKickFistLeft.Add(tmpBitmap);
   end;

//��������� � ������� ����� ������� ������� ������
TalkoffSpritesArrKickFistRight := TList.Create;
For i:=0 to MaxImgTalkoffFistRight - 1 Do
   begin
   tmpBitmap :=TBitmap.Create;
   //�������� ����
   tmpBitmap.LoadFromFile(ExePath+'Graphics\Talkoff\TalkoffKickFistRight\Hand_right'+IntToStr(i)+'.bmp');
   tmpBitmap.Transparent:=True;
   tmpBitmap.TransparentMode:=tmFixed;
   tmpBitmap.TransparentColor:=clBlack;
   //��������� � ������
   TalkoffSpritesArrKickFistRight.Add(tmpBitmap);
   end;
end;

function TForm1.OverlapRects(R1, R2: TRect): Boolean;
var
  Temp: TRect;
begin
  Result := False;
  if not UnionRect(Temp, R1, R2) then
    Exit;
  if (Temp.Right - Temp.Left <= R1.Right - R1.Left + R2.Right - R2.Left) and
    (Temp.Bottom - Temp.Top <= R1.Bottom - R1.Top + R2.Bottom - R2.Top) then
    Result := True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
i:integer;
begin
//��������� ������ ���������
self.TimerFPS.Enabled:=false;
//������� �� ������ ������ ����
for i := 0 to MaxStars-1 do
   begin
   Stars[i].free;
   end;
//������� �� ������ ������� ������������
//���
GameWorld.Free;
//����
GameSky.Free;
//������� �� ������ �����
Talkoff.Free;
//������� �� ������ ����������� Canvas
VirtBitmap.Free;
WriteThread.Terminate;
CriticalSection.free;
end;

//����� ����������. ������� ������������ ������������ ������� � ������� ��������� DirectX
procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   Form1.Caption := IntToStr(Key);
   case key of
   vk_space:
         begin
         //����� ������ ��������������� ������, ��� ����� ���� �������.
         Talkoff.TalkoffUseFist := True;
         if Talkoff.ThereMove = TalkoffdirectionLeft then
            begin
            //�������� ��������� �������� ����� �����
            Talkoff.KickLeftindex := 1;

            end;
         if Talkoff.ThereMove = TalkoffdirectionRight then
            begin
            //�������� ��������� �������� ����� ������
            Talkoff.KickRightindex := 1;

            end;

         end;

   vk_left:
         begin
//����������� ������� ������������ �� ��� �����
//         If Talkoff.TalkoffSit = false then
           begin
           GameWorld.WorldX := GameWorld.WorldX - 3;
           GameSky.SkyX := GameSky.SkyX - 1;
           end;
//�������� �����
         Talkoff.sprindexshag := 1;
//������������� ���
         Talkoff.shagx := -1;
//����� ��������������� �����
         Talkoff.ThereMove := TalkoffdirectionLeft;
         end;
   vk_right:
         begin
//����������� ������� ������������ �� ��� ������
//         If Talkoff.TalkoffSit = false then
           begin
           GameWorld.WorldX := GameWorld.WorldX + 3;
           GameSky.SkyX := GameSky.SkyX + 1;
           end;
//�������� �����
         Talkoff.sprindexshag := 1;
//������������� ���
         Talkoff.shagx := 1;
//����� ��������������� ������
         Talkoff.ThereMove := TalkoffdirectionRight;
         end;
   vk_down:
           begin
//           Talkoff.TalkoffSit := true;
//           Talkoff.sprindexshag := 0;
           end;
   vk_up:
        begin
//        Talkoff.TalkoffSit := false;
        Talkoff.sprindexshag := 0;
        end;
     end;
end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
//����� ���������������
Talkoff.sprindexshag := 0;
end;

//������������� ������
procedure TForm1.TimerFPSTimer(Sender: TObject);
begin
DrawFrame();
end;

procedure TForm1.DrawFrame();
var
i:integer;
begin
if (Tick + 1000) < gettickcount() then
  begin
  Tick := gettickcount();
  if WriteThread.Count > 0 then
    begin
    FPS := round(WriteThread.Count);
    WriteThread.Count := 0;
    end;
  end;

//�������������� Canvas
VirtBitmap.Canvas.FillRect(Rect(0,0,VirtBitmap.Width,VirtBitmap.Height));
//������� ������� ������������
GameWorld.Show;
//������� ����
GameSky.Show;
//������� �����
Talkoff.Show;
//������ ������ ������������ �� ����������� ������
//������������ �����
for i := 0 to MaxStars - 1 do
   begin
   If Stars[i] <> nil then
      begin
      Stars[i].Show();
      end;
   end;

VirtBitmap.Canvas.TextOut(10, 100, 'FPS=' + inttostr(FPS));
//�������� ����������� ������
Form1.Image1.Canvas.Draw(10, 10, VirtBitmap);
application.ProcessMessages;
end;

end.
