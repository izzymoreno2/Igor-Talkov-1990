# Igor-Talkov-1990 Last Version 1.12.0; 18/02/2025 by Fox Soft Inc.
Last version Project and repository

Пожалуйста ! Не видоизменяйте файловую структуру каталога Graphics, его содержимого и прочее, корневых файлов проекта. Если это сделать, весь проект будет работать с ошибками и не корректно !
$$$

Далее следует ТЗ и ТТ.

Технические требования:

Обявить модули Главных персонажей:

```
uses
Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
ExtCtrls, Math, Igor Talkoff, Yriy Shewchuk, Slava Ivankoff, Sergey Dorenko, Nikita Djigurda, Irina Ponarowskaya, Viktor Coy, Egor Letov, Stas Barezkiy, Boris Eltsin, Gennadiy Zuganov, Djohar Dudaev, Ahmad Kadyrov, Vladimir Putin;
```
Компьютерная игра должна быть в виде 32/64-разрядного приложения откомпилирована в Cреде разработки Embarcadero RAD Studio 2013 XE3.

Основная Идея Игры «КУМИР-1990»: сделать 3 или более независимых сюжетных линий для Главных героев: Игоря Владимировича Талькова, Стаса Валерьевича Барецкого и Ирины Витальевны Понаровской, Никиты Джигурда, Сергея Доренко.

**Нашему коллективу требуются**:

- Сценарист игры[Уже есть], 
- HR-Менеджер[Знание кадров и умение разбираться в найме специалистов, начисление з/п, премии и проведение треннинго памяти по Японской системе], 
- Ведущие Программисты, 
- Программисты, 
- Ведущие Тестировщики, 
- Тестировщики, 
- Менеджеры по Рекламе и СМИ.
- Администратор группы/PR-менеджер.
- Различные программисты. Спецэффектов, графического движка, демонстрации. Умение работать в графических и анимационных пакетах, желательно имевшие и имеющие опыт программирования под Windows 7/8/8.1/10/11 В средах Embarcadero/Delphi/С++, Assembler x86. Владение ООП - О Б Я З А Т Е Л Ь Н О !!! Желательно демонстрировать своё портфолио. Различные специалисты готовые биться над задачей до её окончательного решения неделями, а то и месяцами. Владение Github приветствуется. Работа с VCL-компонентами тоже, работа с файлами. Оплата сдельная, берём толковых студентов тоже со смежных специальностей.

- Beta - Тесторы. Сразу оговорюсь; опытные, дотошные и умеющие грамотно описывать «bug». С ведением документации и оформлениями по Компьютерным ГОСТ'ам.

Да. Ещё. Мы будем знакомить с игрой и своими специалистами наших коллег по Торговому Союзу «BRICS» из разных стран в том числе: Бразилии, Индии, Китая, ЮАР,Сингапура, и др. Будем ещё делать обмен опытом специалистов.

**Наш девиз:**

*… Молодо-зелено; не умеете - научим ! Не хотите - покажем как и … заставим работать как мотор после сборки на заводе или капитального ремонта.*

—————

Не забыть объявить различные модули Героев игры вот так:

—————

<Не Реализовано>

По поводу графики. Она должна соблюдать стандарт и быть вся в графических форматах *.png или *.tiff

Связано это с удобством вывода и наслоения различных графических спрайтов видеоигры.

</Не Реализовано>

—————

Было бы ещё Ноу-хау сделать чтобы постепенно День менялся с Ночью.

<Текущее Проектирование>

Создать Новый персонаж Валерию Новодворскую с оружием в виде огромной дубины. Так же ещё Александра Кальянова с Михаилом Шуфутинским с Аккордеоном «Киров».

</Текущее Проектирование>

<Реализовано>

ТЗ: Экран должен скроллироваться с правого окончания экрана до левого. Игорь должен идти плавно с анимацией спрайтов ходьбы/бега. В Demo-версии уже есть.

</Реализовано>

Механика смены изображений для Главного героя и врагов Игоря Талькова:

```pascal
unit UIgorTalkoff;

interface

uses

Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,

Dialogs, ExtCtrls;

Const

//Системные переменные для Механеки смены спрайтов Игоря Талькова.

MaxImageTalkoff = 3;

MaxImgTalkoffMoveLeft = 8;

MaxImgTalkoffMoveRight = 8;

//Для смены спрайтов

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

//Переменные отрисовки Игоря.

TalkoffUseFist: boolean;

//Маркер удара ногой Игорем.

TalkoffUseRun : boolean;

//Маркер Бега Игоря, тип включить/выключить

ThereMove: TTalkoffDirection;

//Триггер направления движения Игоря

TimerAnimationWalk: TTimer;

TimerAnimationFist: TTimer;

procedure Show;

// procedure Gravity;

procedure OnTimerAnimationFist(Sender: TObject);

procedure TimerAnimationProcessing(Sender: TObject);

Constructor CreateTalkoff(X,Y: integer; ownerForm: TWinControl; var pTalkoffSpritesLeft, pTalkoffSpritesRight, pTalkoffSpritesKickLeft, pTalkoffSpritesKickRight

{pTalkoffSpritesMoveSitLeft, pTalkoffSpritesMoveSitRight}: TList);

Destructor Destroy(); override;

end;

implementation

Uses UMainProg, UWorld;

//Подготавливаем Конструктор Игоря.

constructor TTalkoff.CreateTalkoff(X, Y:integer; ownerForm: TWinControl; var pTalkoffSpritesLeft, pTalkoffSpritesRight, pTalkoffSpritesKickLeft, pTalkoffSpritesKickRight

: TList);

var

i:integer;

begin

self.TimerAnimationWalk := TTimer.Create(nil);

self.TimerAnimationWalk.OnTimer := self.TimerAnimationProcessing;

self.TimerAnimationWalk.Interval := round(145);

self.TimerAnimationFist := TTimer.Create(nil);

self.TimerAnimationFist.Interval := round(150);

self.TimerAnimationFist.OnTimer := self.OnTimerAnimationFist;

//self.TimTimerAnimation.Interval:=round((Random*120)+(Random*60)+1);

//Это триггер направления Игоря

ThereMove := TalkoffdirectionRight;

XTalkoff:=X;

YTalkoff:=Y;

//self.grad:=0;

self.owner:=ownerForm;

//Выделяем память под изображения Игоря

ImgMassTalkoffMoveLeft := pTalkoffSpritesLeft;

ImgMassTalkoffMoveRight := pTalkoffSpritesRight;

ImgMassTalkoffMoveFistLeft := pTalkoffSpritesKickLeft;

ImgMassTalkoffMoveFistRight := pTalkoffSpritesKickRight;

//Маркер присидания Игоря

//TalkoffSit := false;

shagx:=0;

shagy:=0;

sprleftindex := 0;

sprrightindex := 0;

sprindexshag := 0;

KickLeftindex := 0 ;

KickRightindex := 0 ;

KickLeftindexshag := 1;

KickRightindexshag := -1;

//ThereMove:=OwldirectionCenter;

//Âêëþ÷àåì òàéìåð àíèìàöèè Èãîðÿ

self.TimerAnimationWalk.Enabled:=true;

end;

procedure TTalkoff.OnTimerAnimationFist(Sender: TObject);

begin

//Åñëè ïðèáàâëÿòü èíäåêñ ñïðàéòà â Show(), òî îí áóäåò ä¸ðãàòüñÿ 170 ðàç â ñåêóíäó.

//Ïîýòîìó ñîçäà¸ì îòäåëüíûé òàéìåð, êîòîðûé áóäåò ïðèáàâëÿòü èíäåêñ ñïðàéòà 2 ðàçà â ñåêóíäó.

KickLeftindex := KickLeftindex + KickLeftindexshag;

//Ïðîâåðÿåì èíäåêñ ìàññèâà íà åäèíèöó

if KickLeftindex >= MaxImgTalkoffFistLeft then

begin

KickLeftindex := 0;

TalkoffUseFist := False;

end;

KickRightindex := KickRightindex + 1;

//Ïðîâåðÿåì èíäåêñ ìàññèâà íà åäèíèöó

if KickRightindex >= MaxImgTalkoffFistRight then

begin

KickRightindex := 0;

TalkoffUseFist := False;

end;

end;

//Çäåñü ðåàëèçîâàí ìåõàíèçì ñìåíû ñïðàéòîâ Èãîðÿ, êîãäà îí èä¸ò âëåâî èëè âïðàâî â çàâèñèìîìòè îò ìàðêåðà ThereMove

procedure TTalkoff.TimerAnimationProcessing(Sender: TObject);

begin

//Ïðîèãðûâàåì ñïðàéòû óäàðà êóëàêîì âëåâî

//Çäåñü ìû èçìåíÿåì íîìåð ñïðàéòà óäàðà êóëàêîì âëåâî

//Çäåñü ìû èçìåíÿåì íîìåð ñïðàéòà óäàðà êóëàêîì âïðàâî

//If (ThereMove = TalkoffdirectionFirstRight) then

// begin

// KickRightindex := KickRightindex + KickRightindexshag;

// if KickRightindexshag >= MaxImgTalkoffMoveLeft then

// KickRightindexshag := 0;

// end;

//Èãîðü èä¸ò âïðàâî

//If (ThereMove = TalkoffdirectionRight) then

// begin

// sprrightindex := sprrightindex + sprindexshag;

// if sprrightindex >= MaxImgTalkoffMoveRight then

// sprrightindex := 0;

// end;

//Èãîðü èä¸ò âëåâî

If (ThereMove = TalkoffdirectionLeft) then

begin

sprleftindex := sprleftindex + sprindexshag;

if sprleftindex >= MaxImgTalkoffMoveLeft then

sprleftindex := 0;

end;

//Èãîðü èä¸ò âïðàâî

If (ThereMove = TalkoffdirectionRight) then

begin

sprrightindex := sprrightindex + sprindexshag;

if sprrightindex >= MaxImgTalkoffMoveRight then

sprrightindex := 0;

end;

end;

//Ïðîöåäóðà îòðèñîâêè Èãîðÿ

procedure TTalkoff.Show;

begin

//Gravity;

//Îòðèñîâûâàåì Èãîðÿ, åñëè îí äåëàåò óäàð êóëàêîì âëåâî

if (TalkoffUseFist = True) then

begin

If (ThereMove = TalkoffdirectionLeft) then

begin

VirtBitmap.Canvas.Draw(self.XTalkoff, self.YTalkoff, self.ImgMassTalkoffMoveFistLeft.Items[KickLeftindex]);

//Çäåñü äåëàåì exit, ÷òîáû íå âûâîäèòü ñïðàéò àíèìàöèè øàãîâ.

exit;

end;

end;

//TalkoffUseFist := False;

//Îòðèñîâûâàåì Èãîðÿ, åñëè îí äåëàåò óäàð êóëàêîì âïðàâî

if (TalkoffUseFist = True) then

begin

If (ThereMove = TalkoffdirectionRight) then

begin

VirtBitmap.Canvas.Draw(self.XTalkoff, self.YTalkoff, self.ImgMassTalkoffMoveFistRight.Items[KickRightindex]);

//Çäåñü äåëàåì exit, ÷òîáû íå âûâîäèòü ñïðàéò àíèìàöèè øàãîâ.

exit;

end;

// TalkoffUseFist := False;

end;

// If (ThereMove = TalkoffdirectionFirstLeft) then

// begin

// VirtBitmap.Canvas.Draw(self.XTalkoff, self.YTalkoff, self.ImgMassTalkoffMoveFistLeft.Items[KickLeftindex]);

// end;

//Îòðèñîâûâàåì Èãîðÿ, åñëè îí äåëàåò óäàð êóëàêîì âïðàâî

// If (ThereMove = TalkoffdirectionFirstRight) then

// begin

// VirtBitmap.Canvas.Draw(self.XTalkoff, self.YTalkoff, self. ImgMassTalkoffMoveFistRight.Items[KickRightindex]);

// end;

//Îòîáðàæàåì äâèæåíèÿ Èãîðÿ âëåâî

If (ThereMove = TalkoffdirectionLeft) then

begin

VirtBitmap.Canvas.Draw(self.XTalkoff, self.YTalkoff, self.ImgMassTalkoffMoveLeft.Items[sprleftindex]);

end;

//Îòîáðàæàåì äâèæåíèÿ Èãîðÿ âïðàâî

If (ThereMove = TalkoffdirectionRight) then

begin

VirtBitmap.Canvas.Draw(self.XTalkoff, self.YTalkoff, self.ImgMassTalkoffMoveRight.Items[sprrightindex]);

end;

//Çäåñü Èãîðü äîëæåí ïðèñåäàòü

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

//Áåð¸ì â öèêëå ïåðå÷ñëÿåì âñå ñïðàéòû çåìëè è ñðàâíèâàåì ïðÿìîóãîëüíèê ñïðàéòà çåìëè ñ ïðÿìîóãîëüíèêîì Ôðåääè.

//Ïðîâåðÿåì, åñëè ïîä íîãàìè Ôðåääè ãðóíò

for i := FirstBrick to LastBrick do

begin

//×èòàåì èç ìàññèâà èãðîâîãî ïðîñòðàíñòâà íîìåð ñïðàéòà

sprindex := GameWorld.GameWorldArr[i];

//Íåîáõîäèìî ïåðåñ÷èòàòü Xscreen â êîîðäèíàòû âèðòóàëüíîãî ýêðàíà.

Form1.OverlapRects(R1, R2: TRect): Boolean;

//VirtBitmap.Canvas.Draw(xScreen, GameWorld.WorldY, GameWorld.ImgGameWorld[sprindex]);

// Ïðèáàâëÿåì 10. 10 - ðàçìåð ñïðàéòîâ ïî 10 ïèêñåëåé, ó÷ò¸ì ýòî

xScreen:= xScreen + TextureWidth;

end;

if YFreddy<= 310 then

begin

self.YFreddy := YFreddy + 1;

end;

end;}

//Ýòî äåñòðóêòîð îáúåêòà Èãîðÿ

destructor TTalkoff.Destroy;

var

i:byte;

begin

//Çäåñü ìû óäàëÿåì èç ïàìÿòè Èãîðÿ

(*For i:=0 to MaxImgTalkoffMoveLeft - 1 Do

begin

//Åñëè îáúåêò ñóùåñòâóåò â ïàìÿòè, òî ìû åãî óäàëÿåì

if MaxImgTalkoffMoveLeft[i]<>nil then ImgMassFreddyMoveLeft[i].free;

end;

For i:=0 to MaxImgFreddyMoveRight-1 Do

begin

//Åñëè îáúåêò ñóùåñòâóåò â ïàìÿòè, òî ìû åãî óäàëÿåì

if ImgMassFreddyMoveRight[i]<>nil then ImgMassFreddyMoveRight[i].free;

end;

For i:=0 to MaxImgFreddyMoveSitLeft-1 Do

begin

//Åñëè îáúåêò ñóùåñòâóåò â ïàìÿòè, òî ìû åãî óäàëÿåì

if ImgMassFreddyMoveSitLeft[i]<>nil then ImgMassFreddyMoveSitLeft[i].free;

end;

For i:=0 to MaxImgFreddyMoveSitRight-1 Do

begin

//Åñëè îáúåêò ñóùåñòâóåò â ïàìÿòè, òî ìû åãî óäàëÿåì

if ImgMassFreddyMoveSitRight[i]<>nil then ImgMassFreddyMoveSitRight[i].free;

end;} *)

//Óäàëÿåì òàéìåð àíèìàöèè

TimerAnimationWalk.Free;

TimerAnimationFist.Free;

//Âûçîâ äåñòðóêòîðà ðîäèòåëüñêîãî êëàññà

inherited;

end;

end.
```

<Частично Реализовано>

Требуется создать три плана пейзажа; статический, статически-динамический и динамический.

</Частично Реализовано>

<Реализовано>

Игорь бьёт кулаком по ходу движения вправо.

Таймер задержки анимации работает. Серия ударов получается на 5+.

Игорь бьёт кулаком по ходу движения влево.

</Не Реализовано>

Игорь бьёт правой ногой.

<Частично Реализовано>

Игорь бегает туда-сюда. Переход на бег с помощью клавиши Caps-Lock.

</Не Реализовано>

<Частично Реализовано>

Создать персонаж Валерию Ильиничну Новодворскую и Егора Летова с электрогитарой, Виктора Цоя, Владимира Вольфовича Жириновского, Александра Друзя, Стаса Барецкого, Ирину Понаровскую, Вячеслава Иванькова, Бориса Березовского, Бадри Патаркацишвили, Бориса Ельцина, Михаила Горбачёва, Майкла Джексона, Джохара Дудаева, Александра Лебедя, Ахмада Кадырова, Сергея Степашина, Владимира Путина, Дмитрия Медведева, Арнольда Шварцнейггера, Шэрон Стоун.

</ Частично Реализовано>

Создан персонаж Девушки с плёткой.

</Частично Реализовано>

<Частично Реализовано>

Спроектировано «Главное меню» Видеоигры.

</Частично Реализовано>

—————

Вся игра и стиль должны быть подражанием корпорации Konami, Sega, Nintendo и игры ZX-Renegade -128K и ZX-Target Renegade-128K.

### СЮЖЕТНАЯ ЛИНИЯ ЗА ПЕРСОНАЖА ИГОРЯ ТАЛЬКОВА.

0) Уровень. Сочинское кафе. Защитить от хулиганов Татьяну Талькову, будущую жену Игоря главного героя.

1) Уровень Москва «Чистые пруды»

Чистые пруды на фоне парка. Драка с хулиганами. Найти потайное место в старой часовне и взять оттуда огромный Крест.

2) Уровень Москва «Московский метрополитен»

3) Уровень Москва «Защитники Белого дома»

Идея ! В конце уровня Путч - 1991 сделать огромный танк, на котором будет развиваться трёхцветный флаг. Там должны стоять Борис Ельцин с Генералом Александром Лебедем и др.

4) Москва. Красная Площадь. Включить режим бега и догнать Автобус - Икарус. Когда он остановится избить всех Депутатов, которые в нём будут находится из Совета Народных Депутатов.

Уровень «Путч - 1991» Ленинград, Санкт-Петербург, Фоновый план; огромное стечение народа, митинг, каша из народа … Игорь должен пройти до сцены Дворцовой площади до микрофона.

5) Уровень Москва «Шереметьево-2» Ил - 62М Игорь должен расправиться со всеми хулиганами и улететь в Нью-Йорк. [Есть идея, что ему Вячеслав Иваньков должен передать кейс с деньгами]. Самолёт улетает в конце уровня.

6) Уровень Нью-Йорк Куинс Аэропорт им. Джонна Кеннеди. Игорь должен получить багаж и отправиться на Брайтон Бич.

7) Уровень Брайтон - Бич. Найти продавца Белой Феррари Дон Джонсона и купить у него этот автомобиль.

8) В погоне по штату Майями протаранить чёрный BMW Бориса Абрамовича Березовского. Отнять у него Золотую Минору, которую Борис Абрамович купил в Петербургской Синагоге. Далее доехать до Аэропорта в Далласе штат Техас и прилететь обратно в Россию и вернуть трофей в Синагогу расположенную на Лермонтовском проспекте, перед этим купить билет на ИЛ-96-300М.

9) Фейерверки на экране с Изображением Игоря Талькова под фоновое звучание его музыкальной композиции «Звезда» либо «Я Вернусь».

Создать хулиганов на мотоциклах «Иж-планета 5», врагов из богемы поп-музыки. Создать панков, металлистов.

### СЮЖЕТНАЯ ЛИНИЯ ЗА СТАНИСЛАВА ВАЛЕРЬЕВИЧА БАРЕЦКОГО.

0) Уровень Ленинград. Собрать Деньги разбросанные по дорожкам в Ленинградском Парке Победы и Купить Запчасти для Мотоцикла ИЖ-Планета-3. Купить в киоске журнал за 5р. и за 3р. выпить большую кружку Кваса у продавщицы из Жёлтой Бочки-Прицепа. Собрать по чертежам в журнале Сварочный Аппарат и мотоцикл в Таксопарке на Бухарестской улице в городе Ленинграде.

### СЮЖЕТНАЯ ЛИНИЯ ЗА ИРИНУ ВАЛЕРЬЕВНУ ПОНАРОВСКУЮ.

[В стадии разработки].

### СЮЖЕТНАЯ ЛИНИЯ ЗА ВЯЧЕСЛАВА КИРИЛЛОВИЧА ИВАНЬКОВА

0) Вячеслав Кириллович покупает Белорусский Компьютер «РАДИО-86РК» в Юном Технике в Ленинграде.

1) Вячеслав Кириллович в Цирке Шапито в Ленинграде. Убить кулаками всех Клоунов, Циркачей, Арлекинов, Собачек, Львов, Медведей на мотоциклах. В конце уровня «замочить» Директора Цирка и завладеть кейсом в 120 000 рублей, зайти в БАНК «МЕНАТЕП» Михаила Борисовича Ходороковского и обменять всю сумму кейса на Американские Доллары.

2) Идти до упора влево отбиваясь от Хулиганов и Панков. Дойти до кафе Механа на ст.м. Парк Победы. Зайти в кафе. Найти там Никиту Джигурду, купить у него Волгу-Газ 24-02. Поклониться и передать кейс ему в руки.

[В стадии разработки].

Мы на (github.com)[https://github.com/izzymoreno2/Igor-Talkov-1990]
