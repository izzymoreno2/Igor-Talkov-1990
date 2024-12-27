unit UBorezkiy;

//Юнит с кодом Стаса Борецкого

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

Const

//Максимальное значение спрайтов Стаса Борецкого движения влево и вправо соответственно
MaxImageBorezkiy = 3;
MaxImgBorezkiyMoveLeft = 8;
MaxImgBorezkiyMoveRight = 8;
//Максимальное значение спрайтов Стаса Борецкого ударов кулаком влево и вправо соответственно
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
  //Думаю, что нужно сделать специальный триггер: бьёт ли кулаком Стас Борецкий а в методе Show выводить эту анимацию.
  BorezkiyUseFist: boolean;
  //Триггер бегает ли Стас Борецкий или ходит
  BorezkiyUseRun : boolean;

//Маркер направления Игоря
  ThereMove: TBorezkiyDirection;
//Таймер вывода анимации ходьбы Стаса Борецкого
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

//Здесь происходит сборка объекта Стаса Борецкого, где задаются нужные параметры и присваиваются начальные переменные
constructor TBorezkiy.CreateBorezkiy(X, Y:integer; ownerForm: TWinControl; var pBorezkiySpritesLeft, pBorezkiySpritesRight, pBorezkiySpritesKickLeft, pBorezkiySpritesKickRight
                             : TList);
var
i:integer;
begin
//Создаётся таймер анимации Игоря, его удара кулаком
self.TimerAnimationWalk := TTimer.Create(nil);
self.TimerAnimationWalk.OnTimer := self.TimerAnimationProcessing;
self.TimerAnimationWalk.Interval := round(145);
self.TimerAnimationFist := TTimer.Create(nil);
self.TimerAnimationFist.Interval := round(150);
self.TimerAnimationFist.OnTimer := self.OnTimerAnimationFist;

//self.TimTimerAnimation.Interval:=round((Random*120)+(Random*60)+1);
//Направление движения Стаса Борецкого
ThereMove := BorezkiydirectionRight;
XBorezkiy:=X;
YBorezkiy:=Y;
//self.grad:=0;
self.owner:=ownerForm;
//Присваеваем список спрайтов созданных в главном Unit все спрайты Стаса Борецкого

ImgMassBorezkiyMoveLeft := pBorezkiySpritesLeft;
ImgMassBorezkiyMoveRight := pBorezkiySpritesRight;
ImgMassBorezkiyMoveFistLeft := pBorezkiySpritesKickLeft;
ImgMassBorezkiyMoveFistRight := pBorezkiySpritesKickRight;

//Заводим переменные для анимации Стаса Борецкого
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
//Включаем таймер анимации Стаса Борецкого
self.TimerAnimationWalk.Enabled:=true;
end;

procedure TBorezkiy.OnTimerAnimationFist(Sender: TObject);
begin

//Если прибавлять индекс спрайта в Show(), то он будет дёргаться 170 раз в секунду.
//Поэтому создаём отдельный таймер, который будет прибавлять индекс спрайта 2 раза в секунду.



KickLeftindex := KickLeftindex + KickLeftindexshag;
            //Проверяем индекс массива на единицу
            if KickLeftindex >= MaxImgBorezkiyFistLeft then
              begin
              KickLeftindex := 0;
              BorezkiyUseFist := False;
              end;

        KickRightindex := KickRightindex + 1;
         //Проверяем индекс массива на единицу
         if KickRightindex >= MaxImgBorezkiyFistRight then
           begin
           KickRightindex := 0;
           BorezkiyUseFist := False;
           end;

end;

//Здесь реализован механизм смены спрайтов Стаса Борецкого, когда он идёт влево или вправо в зависимомти от маркера ThereMove
procedure TBorezkiy.TimerAnimationProcessing(Sender: TObject);
begin
//Проигрываем спрайты удара кулаком влево
//Здесь мы изменяем номер спрайта удара кулаком влево

//Здесь мы изменяем номер спрайта удара кулаком вправо

//If (ThereMove = TalkoffdirectionFirstRight) then
//  begin
//   KickRightindex := KickRightindex + KickRightindexshag;
//   if KickRightindexshag >= MaxImgTalkoffMoveLeft then
//      KickRightindexshag := 0;
//   end;

//Игорь идёт вправо
//If (ThereMove = TalkoffdirectionRight) then
//   begin
//   sprrightindex := sprrightindex + sprindexshag;
//   if sprrightindex >= MaxImgTalkoffMoveRight then
//     sprrightindex := 0;
//   end;

//Стаса Борецкого идёт влево
If (ThereMove = BorezkiydirectionLeft) then
  begin
   sprleftindex := sprleftindex + sprindexshag;
   if sprleftindex >= MaxImgBorezkiyMoveLeft then
      sprleftindex := 0;
   end;
//Стаса Борецкого идёт вправо
If (ThereMove = BorezkiydirectionRight) then
   begin
   sprrightindex := sprrightindex + sprindexshag;
   if sprrightindex >= MaxImgBorezkiyMoveRight then
     sprrightindex := 0;
   end;
end;

//Процедура отрисовки Стаса Борецкого
procedure TBorezkiy.Show;
begin

//Gravity;

//Отрисовываем Стаса Борецкого, если он делает удар кулаком влево
if (BorezkiyUseFist = True) then
      begin
         If (ThereMove = BorezkiydirectionLeft) then
            begin
            VirtBitmap.Canvas.Draw(self.XBorezkiy, self.YBorezkiy, self.ImgMassBorezkiyMoveFistLeft.Items[KickLeftindex]);
            //Здесь делаем exit, чтобы не выводить спрайт анимации шагов.
            exit;
            end;
         end;
     //TalkoffUseFist := False;

//Отрисовываем Стаса Борецкого, если он делает удар кулаком вправо
if (BorezkiyUseFist = True) then
   begin
      If (ThereMove = BorezkiydirectionRight) then
         begin
         VirtBitmap.Canvas.Draw(self.XBorezkiy, self.YBorezkiy, self.ImgMassBorezkiyMoveFistRight.Items[KickRightindex]);
         //Здесь делаем exit, чтобы не выводить спрайт анимации шагов.
         exit;
         end;
      //  TalkoffUseFist := False;
     end;


//   If (ThereMove = TalkoffdirectionFirstLeft) then
//     begin
//     VirtBitmap.Canvas.Draw(self.XTalkoff, self.YTalkoff, self.ImgMassTalkoffMoveFistLeft.Items[KickLeftindex]);
//     end;
//Отрисовываем Игоря, если он делает удар кулаком вправо

//   If (ThereMove = TalkoffdirectionFirstRight) then
//     begin
//     VirtBitmap.Canvas.Draw(self.XTalkoff, self.YTalkoff, self. ImgMassTalkoffMoveFistRight.Items[KickRightindex]);
//     end;

//Отображаем движения Стаса Борецкого влево

   If (ThereMove = BorezkiydirectionLeft) then
     begin
     VirtBitmap.Canvas.Draw(self.XBorezkiy, self.YBorezkiy, self.ImgMassBorezkiyMoveLeft.Items[sprleftindex]);
     end;
//Отображаем движения Стаса Борецкого вправо
   If (ThereMove = BorezkiydirectionRight) then
     begin
     VirtBitmap.Canvas.Draw(self.XBorezkiy, self.YBorezkiy, self.ImgMassBorezkiyMoveRight.Items[sprrightindex]);
     end;
//Здесь Игорь должен приседать
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
//Берём в цикле перечсляем все спрайты земли и сравниваем прямоугольник спрайта земли с прямоугольником Фредди.
//Проверяем, если под ногами Фредди грунт
for i := FirstBrick to LastBrick do
  begin
   //Читаем из массива игрового пространства номер спрайта
  sprindex := GameWorld.GameWorldArr[i];
  //Необходимо пересчитать Xscreen в координаты виртуального экрана.

  Form1.OverlapRects(R1, R2: TRect): Boolean;

  //VirtBitmap.Canvas.Draw(xScreen, GameWorld.WorldY, GameWorld.ImgGameWorld[sprindex]);
  // Прибавляем 10. 10 - размер спрайтов по 10 пикселей, учтём это
  xScreen:= xScreen + TextureWidth;
  end;

if YFreddy<= 310 then
  begin
  self.YFreddy := YFreddy + 1;
  end;
end;}

//Это деструктор объекта Игоря
destructor TBorezkiy.Destroy;
var
i:byte;
begin
//Здесь мы удаляем из памяти Игоря
(*For i:=0 to MaxImgTalkoffMoveLeft - 1 Do
   begin
   //Если объект существует в памяти, то мы его удаляем
   if MaxImgTalkoffMoveLeft[i]<>nil then ImgMassFreddyMoveLeft[i].free;
   end;
For i:=0 to  MaxImgFreddyMoveRight-1 Do
   begin
   //Если объект существует в памяти, то мы его удаляем
   if ImgMassFreddyMoveRight[i]<>nil then ImgMassFreddyMoveRight[i].free;
   end;
For i:=0 to  MaxImgFreddyMoveSitLeft-1 Do
   begin
   //Если объект существует в памяти, то мы его удаляем
   if ImgMassFreddyMoveSitLeft[i]<>nil then ImgMassFreddyMoveSitLeft[i].free;
   end;
For i:=0 to  MaxImgFreddyMoveSitRight-1 Do
   begin
   //Если объект существует в памяти, то мы его удаляем
   if ImgMassFreddyMoveSitRight[i]<>nil then ImgMassFreddyMoveSitRight[i].free;
   end;} *)
//Удаляем таймер анимации
TimerAnimationWalk.Free;
TimerAnimationFist.Free;
//Вызов деструктора родительского класса
inherited;
end;

end.
