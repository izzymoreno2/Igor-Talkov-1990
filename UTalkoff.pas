unit UTalkoff;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

Const

//������������ �������� �������� ����� �������� ����� � ������ ��������������
MaxImageTalkoff = 3;
MaxImgTalkoffMoveLeft = 8;
MaxImgTalkoffMoveRight = 8;
//������������ �������� �������� ����� ������ ������� ����� � ������ ��������������
MaxImgTalkoffFistLeft = 2;
MaxImgTalkoffFistRight = 2;

//MaxImgFreddyMoveSitLeft = 1;
//MaxImgFreddyMoveSitRight = 1;


type
    TTalkoffDirection = (TalkoffdirectionLeft, TalkoffdirectionCenter, TalkoffdirectionRight, TalkoffdirectionFirstLeft, TalkoffdirectionFirstRight);

type

   TTalkoffSpritesArr = array[0..MaxImageTalkoff] of BitMap;
   pTalkoffSpritesArr = ^TTalkoffSpritesArr;

type

  TTalkoff = class (TObject)
  public
  Name: string;

  ImgMassTalkoffMoveLeft: TList;
  ImgMassTalkoffMoveRight: TList;
  ImgMassTalkoffMoveFistLeft: TList;
  ImgMassTalkoffMoveFistRight: TList;

  owner:TWinControl;
  shagx,shagy, sprleftindex, sprrightindex, sprindexshag, KickLeftindex, KickRightindex,
  KickLeftindexshag, KickRightindexshag :integer;
  XTalkoff,YTalkoff,sprindex:integer;
  //�����, ��� ����� ������� ����������� �������: ���� �� ������� ����� � � ������ Show �������� ��� ��������.
  TalkoffUseFist: boolean;
  //������� ������ �� ����� ��� �����
  TalkoffUseRun : boolean;

//������ ����������� �����
  ThereMove: TTalkoffDirection;
//������ ������ �������� ������ �����
  TimerAnimationWalk: TTimer;
  TimerAnimationFist: TTimer;
  procedure Show;
//  procedure Gravity;
  procedure OnTimerAnimationFist(Sender: TObject);


  procedure TimerAnimationProcessing(Sender: TObject);
  Constructor CreateTalkoff(X,Y: integer; ownerForm: TWinControl; var pTalkoffSpritesLeft, pTalkoffSpritesRight, pTalkoffSpritesKickLeft, pTalkoffSpritesKickRight
                             {pTalkoffSpritesMoveSitLeft, pTalkoffSpritesMoveSitRight}: TList);
  Destructor Destroy(); override;
  end;

implementation

Uses UMainProg, UWorld;

//����� ���������� ������ ������� ����� ��������, ��� �������� ������ ��������� � ������������� ��������� ����������
constructor TTalkoff.CreateTalkoff(X, Y:integer; ownerForm: TWinControl; var pTalkoffSpritesLeft, pTalkoffSpritesRight, pTalkoffSpritesKickLeft, pTalkoffSpritesKickRight
                             : TList);
var
i:integer;
begin
//�������� ������ �������� �����, ��� ����� �������
self.TimerAnimationWalk := TTimer.Create(nil);
self.TimerAnimationWalk.OnTimer := self.TimerAnimationProcessing;
self.TimerAnimationWalk.Interval := round(145);
self.TimerAnimationFist := TTimer.Create(nil);
self.TimerAnimationFist.Interval := round(150);
self.TimerAnimationFist.OnTimer := self.OnTimerAnimationFist;

//self.TimTimerAnimation.Interval:=round((Random*120)+(Random*60)+1);
//����������� �������� �����
ThereMove := TalkoffdirectionRight;
XTalkoff:=X;
YTalkoff:=Y;
//self.grad:=0;
self.owner:=ownerForm;
//����������� ������ �������� ��������� � ������� Unit ��� ������� �����

ImgMassTalkoffMoveLeft := pTalkoffSpritesLeft;
ImgMassTalkoffMoveRight := pTalkoffSpritesRight;
ImgMassTalkoffMoveFistLeft := pTalkoffSpritesKickLeft;
ImgMassTalkoffMoveFistRight := pTalkoffSpritesKickRight;

//������� ���������� ��� �������� �����
//TalkoffSit := false;
shagx:=0;
shagy:=0;
sprleftindex := 0;
sprrightindex := 0;
sprindexshag := 0;
KickLeftindex := 0  ;
KickRightindex := 0 ;
KickLeftindexshag := 1;
KickRightindexshag := -1;

//ThereMove:=OwldirectionCenter;
//�������� ������ �������� �����
self.TimerAnimationWalk.Enabled:=true;
end;

procedure TTalkoff.OnTimerAnimationFist(Sender: TObject);
begin

//���� ���������� ������ ������� � Show(), �� �� ����� �������� 170 ��� � �������.
//������� ������ ��������� ������, ������� ����� ���������� ������ ������� 2 ���� � �������.



KickLeftindex := KickLeftindex + KickLeftindexshag;
            //��������� ������ ������� �� �������
            if KickLeftindex >= MaxImgTalkoffFistLeft then
              begin
              KickLeftindex := 0;
              TalkoffUseFist := False;
              end;

        KickRightindex := KickRightindex + 1;
         //��������� ������ ������� �� �������
         if KickRightindex >= MaxImgTalkoffFistRight then
           begin
           KickRightindex := 0;
           TalkoffUseFist := False;
           end;

end;

//����� ���������� �������� ����� �������� �����, ����� �� ��� ����� ��� ������ � ����������� �� ������� ThereMove
procedure TTalkoff.TimerAnimationProcessing(Sender: TObject);
begin
//����������� ������� ����� ������� �����
//����� �� �������� ����� ������� ����� ������� �����

//����� �� �������� ����� ������� ����� ������� ������

//If (ThereMove = TalkoffdirectionFirstRight) then
//  begin
//   KickRightindex := KickRightindex + KickRightindexshag;
//   if KickRightindexshag >= MaxImgTalkoffMoveLeft then
//      KickRightindexshag := 0;
//   end;

//����� ��� ������
//If (ThereMove = TalkoffdirectionRight) then
//   begin
//   sprrightindex := sprrightindex + sprindexshag;
//   if sprrightindex >= MaxImgTalkoffMoveRight then
//     sprrightindex := 0;
//   end;

//����� ��� �����
If (ThereMove = TalkoffdirectionLeft) then
  begin
   sprleftindex := sprleftindex + sprindexshag;
   if sprleftindex >= MaxImgTalkoffMoveLeft then
      sprleftindex := 0;
   end;
//����� ��� ������
If (ThereMove = TalkoffdirectionRight) then
   begin
   sprrightindex := sprrightindex + sprindexshag;
   if sprrightindex >= MaxImgTalkoffMoveRight then
     sprrightindex := 0;
   end;
end;

//��������� ��������� �����
procedure TTalkoff.Show;
begin

//Gravity;

//������������ �����, ���� �� ������ ���� ������� �����
if (TalkoffUseFist = True) then
      begin
         If (ThereMove = TalkoffdirectionLeft) then
            begin
            VirtBitmap.Canvas.Draw(self.XTalkoff, self.YTalkoff, self.ImgMassTalkoffMoveFistLeft.Items[KickLeftindex]);
            //����� ������ exit, ����� �� �������� ������ �������� �����.
            exit;
            end;
         end;
     //TalkoffUseFist := False;

//������������ �����, ���� �� ������ ���� ������� ������
if (TalkoffUseFist = True) then
   begin
      If (ThereMove = TalkoffdirectionRight) then
         begin
         VirtBitmap.Canvas.Draw(self.XTalkoff, self.YTalkoff, self.ImgMassTalkoffMoveFistRight.Items[KickRightindex]);
         //����� ������ exit, ����� �� �������� ������ �������� �����.
         exit;
         end;
      //  TalkoffUseFist := False;
     end;


//   If (ThereMove = TalkoffdirectionFirstLeft) then
//     begin
//     VirtBitmap.Canvas.Draw(self.XTalkoff, self.YTalkoff, self.ImgMassTalkoffMoveFistLeft.Items[KickLeftindex]);
//     end;
//������������ �����, ���� �� ������ ���� ������� ������

//   If (ThereMove = TalkoffdirectionFirstRight) then
//     begin
//     VirtBitmap.Canvas.Draw(self.XTalkoff, self.YTalkoff, self. ImgMassTalkoffMoveFistRight.Items[KickRightindex]);
//     end;

//���������� �������� ����� �����

   If (ThereMove = TalkoffdirectionLeft) then
     begin
     VirtBitmap.Canvas.Draw(self.XTalkoff, self.YTalkoff, self.ImgMassTalkoffMoveLeft.Items[sprleftindex]);
     end;
//���������� �������� ����� ������
   If (ThereMove = TalkoffdirectionRight) then
     begin
     VirtBitmap.Canvas.Draw(self.XTalkoff, self.YTalkoff, self.ImgMassTalkoffMoveRight.Items[sprrightindex]);
     end;
//����� ����� ������ ���������
   {if (Freddy.FreddySit = false) then
     if (ThereMove = FreddydirectionLeft) then
       begin
       VirtBitmap.Canvas.Draw(self.XFreddy, self.YFreddy, self.ImgMassFreddyMoveLeft.Items[sprleftindex]);
       exit;
       end
         else
           if (ThereMove = FreddydirectionRight) then
           begin
           VirtBitmap.Canvas.Draw(self.XFreddy, self.YFreddy, self.ImgMassFreddyMoveRight.Items[0]);
           exit;
           end;

   if Freddy.FreddySit = true then
     begin
      if (ThereMove = FreddydirectionLeft) then
        begin
        VirtBitmap.Canvas.Draw(self.XFreddy-8, self.YFreddy+10, self.ImgMassFreddyMoveSitLeft.Items[0]);
        exit;
        end
          else
          if (ThereMove = FreddydirectionRight) then
            begin
            VirtBitmap.Canvas.Draw(self.XFreddy, self.YFreddy+10, self.ImgMassFreddyMoveSitRight.Items[sprrightindex]);
            exit;
            end;
     end;}
end;

{procedure TFreddy.Gravity;
var
i, Xscreen: integer;
sprindex: byte;
FirstBrick: integer;
LastBrick : integer;
begin
//���� � ����� ���������� ��� ������� ����� � ���������� ������������� ������� ����� � ��������������� ������.
//���������, ���� ��� ������ ������ �����
for i := FirstBrick to LastBrick do
  begin
   //������ �� ������� �������� ������������ ����� �������
  sprindex := GameWorld.GameWorldArr[i];
  //���������� ����������� Xscreen � ���������� ������������ ������.

  Form1.OverlapRects(R1, R2: TRect): Boolean;

  //VirtBitmap.Canvas.Draw(xScreen, GameWorld.WorldY, GameWorld.ImgGameWorld[sprindex]);
  // ���������� 10. 10 - ������ �������� �� 10 ��������, ���� ���
  xScreen:= xScreen + TextureWidth;
  end;

if YFreddy<= 310 then
  begin
  self.YFreddy := YFreddy + 1;
  end;
end;}

//��� ���������� ������� �����
destructor TTalkoff.Destroy;
var
i:byte;
begin
//����� �� ������� �� ������ �����
(*For i:=0 to MaxImgTalkoffMoveLeft - 1 Do
   begin
   //���� ������ ���������� � ������, �� �� ��� �������
   if MaxImgTalkoffMoveLeft[i]<>nil then ImgMassFreddyMoveLeft[i].free;
   end;
For i:=0 to  MaxImgFreddyMoveRight-1 Do
   begin
   //���� ������ ���������� � ������, �� �� ��� �������
   if ImgMassFreddyMoveRight[i]<>nil then ImgMassFreddyMoveRight[i].free;
   end;
For i:=0 to  MaxImgFreddyMoveSitLeft-1 Do
   begin
   //���� ������ ���������� � ������, �� �� ��� �������
   if ImgMassFreddyMoveSitLeft[i]<>nil then ImgMassFreddyMoveSitLeft[i].free;
   end;
For i:=0 to  MaxImgFreddyMoveSitRight-1 Do
   begin
   //���� ������ ���������� � ������, �� �� ��� �������
   if ImgMassFreddyMoveSitRight[i]<>nil then ImgMassFreddyMoveSitRight[i].free;
   end;} *)
//������� ������ ��������
TimerAnimationWalk.Free;
TimerAnimationFist.Free;
//����� ����������� ������������� ������
inherited;
end;

end.
