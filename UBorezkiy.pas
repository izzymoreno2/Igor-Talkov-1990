unit UBorezkiy;

//���� � ����� ����� ���������

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

Const

//������������ �������� �������� ����� ��������� �������� ����� � ������ ��������������
MaxImageBorezkiy = 3;
MaxImgBorezkiyMoveLeft = 8;
MaxImgBorezkiyMoveRight = 8;
//������������ �������� �������� ����� ��������� ������ ������� ����� � ������ ��������������
MaxImgBorezkiyFistLeft = 2;
MaxImgBorezkiyFistRight = 2;

//MaxImgFreddyMoveSitLeft = 1;
//MaxImgFreddyMoveSitRight = 1;


type
    TBorezkiyDirection = (BorezkiydirectionLeft, BorezkiydirectionCenter, BorezkiydirectionRight, BorezkiydirectionFirstLeft, BorezkiydirectionFirstRight);

type

   TBorezkiySpritesArr = array[0..MaxImageBorezkiy] of BitMap;
   pBorezkiySpritesArr = ^TBorezkiySpritesArr;

type

  TBorezkiy = class (TObject)
  public
  Name: string;

  ImgMassBorezkiyMoveLeft: TList;
  ImgMassBorezkiyMoveRight: TList;
  ImgMassBorezkiyMoveFistLeft: TList;
  ImgMassBorezkiyMoveFistRight: TList;

  owner:TWinControl;
  shagx,shagy, sprleftindex, sprrightindex, sprindexshag, KickLeftindex, KickRightindex,
  KickLeftindexshag, KickRightindexshag :integer;
  XBorezkiy,YBorezkiy,sprindex:integer;
  //�����, ��� ����� ������� ����������� �������: ���� �� ������� ���� �������� � � ������ Show �������� ��� ��������.
  BorezkiyUseFist: boolean;
  //������� ������ �� ���� �������� ��� �����
  BorezkiyUseRun : boolean;

//������ ����������� �����
  ThereMove: TBorezkiyDirection;
//������ ������ �������� ������ ����� ���������
  TimerAnimationWalk: TTimer;
  TimerAnimationFist: TTimer;
  procedure Show;
//  procedure Gravity;
  procedure OnTimerAnimationFist(Sender: TObject);


  procedure TimerAnimationProcessing(Sender: TObject);
  Constructor CreateBorezkiy(X,Y: integer; ownerForm: TWinControl; var pBorezkiySpritesLeft, pBorezkiySpritesRight, pBorezkiySpritesKickLeft, pBorezkiySpritesKickRight
                             {pBorezkiySpritesMoveSitLeft, pBorezkiySpritesMoveSitRight}: TList);
  Destructor Destroy(); override;
  end;

implementation

Uses UMainProg, UWorld;

//����� ���������� ������ ������� ����� ���������, ��� �������� ������ ��������� � ������������� ��������� ����������
constructor TBorezkiy.CreateBorezkiy(X, Y:integer; ownerForm: TWinControl; var pBorezkiySpritesLeft, pBorezkiySpritesRight, pBorezkiySpritesKickLeft, pBorezkiySpritesKickRight
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
//����������� �������� ����� ���������
ThereMove := BorezkiydirectionRight;
XBorezkiy:=X;
YBorezkiy:=Y;
//self.grad:=0;
self.owner:=ownerForm;
//����������� ������ �������� ��������� � ������� Unit ��� ������� ����� ���������

ImgMassBorezkiyMoveLeft := pBorezkiySpritesLeft;
ImgMassBorezkiyMoveRight := pBorezkiySpritesRight;
ImgMassBorezkiyMoveFistLeft := pBorezkiySpritesKickLeft;
ImgMassBorezkiyMoveFistRight := pBorezkiySpritesKickRight;

//������� ���������� ��� �������� ����� ���������
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
//�������� ������ �������� ����� ���������
self.TimerAnimationWalk.Enabled:=true;
end;

procedure TBorezkiy.OnTimerAnimationFist(Sender: TObject);
begin

//���� ���������� ������ ������� � Show(), �� �� ����� �������� 170 ��� � �������.
//������� ������ ��������� ������, ������� ����� ���������� ������ ������� 2 ���� � �������.



KickLeftindex := KickLeftindex + KickLeftindexshag;
            //��������� ������ ������� �� �������
            if KickLeftindex >= MaxImgBorezkiyFistLeft then
              begin
              KickLeftindex := 0;
              BorezkiyUseFist := False;
              end;

        KickRightindex := KickRightindex + 1;
         //��������� ������ ������� �� �������
         if KickRightindex >= MaxImgBorezkiyFistRight then
           begin
           KickRightindex := 0;
           BorezkiyUseFist := False;
           end;

end;

//����� ���������� �������� ����� �������� ����� ���������, ����� �� ��� ����� ��� ������ � ����������� �� ������� ThereMove
procedure TBorezkiy.TimerAnimationProcessing(Sender: TObject);
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

//����� ��������� ��� �����
If (ThereMove = BorezkiydirectionLeft) then
  begin
   sprleftindex := sprleftindex + sprindexshag;
   if sprleftindex >= MaxImgBorezkiyMoveLeft then
      sprleftindex := 0;
   end;
//����� ��������� ��� ������
If (ThereMove = BorezkiydirectionRight) then
   begin
   sprrightindex := sprrightindex + sprindexshag;
   if sprrightindex >= MaxImgBorezkiyMoveRight then
     sprrightindex := 0;
   end;
end;

//��������� ��������� ����� ���������
procedure TBorezkiy.Show;
begin

//Gravity;

//������������ ����� ���������, ���� �� ������ ���� ������� �����
if (BorezkiyUseFist = True) then
      begin
         If (ThereMove = BorezkiydirectionLeft) then
            begin
            VirtBitmap.Canvas.Draw(self.XBorezkiy, self.YBorezkiy, self.ImgMassBorezkiyMoveFistLeft.Items[KickLeftindex]);
            //����� ������ exit, ����� �� �������� ������ �������� �����.
            exit;
            end;
         end;
     //TalkoffUseFist := False;

//������������ ����� ���������, ���� �� ������ ���� ������� ������
if (BorezkiyUseFist = True) then
   begin
      If (ThereMove = BorezkiydirectionRight) then
         begin
         VirtBitmap.Canvas.Draw(self.XBorezkiy, self.YBorezkiy, self.ImgMassBorezkiyMoveFistRight.Items[KickRightindex]);
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

//���������� �������� ����� ��������� �����

   If (ThereMove = BorezkiydirectionLeft) then
     begin
     VirtBitmap.Canvas.Draw(self.XBorezkiy, self.YBorezkiy, self.ImgMassBorezkiyMoveLeft.Items[sprleftindex]);
     end;
//���������� �������� ����� ��������� ������
   If (ThereMove = BorezkiydirectionRight) then
     begin
     VirtBitmap.Canvas.Draw(self.XBorezkiy, self.YBorezkiy, self.ImgMassBorezkiyMoveRight.Items[sprrightindex]);
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
destructor TBorezkiy.Destroy;
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
