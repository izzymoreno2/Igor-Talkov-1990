# Igor-Talkov-1990 Last Version 1.12.0; 18/02/2025 by Fox Soft Inc.
Last version Project and repository
Пожалуйста ! Не видоизменяйте файловую структуру каталога Graphics, его содержимого и прочее, корневых файлов проекта. Если это сделать, весь проект будет работать с ошибками и не корректно !
$$$

Далее следует ТЗ и ТТ.

Технические требования:

Обявить модули Главных персонажей:

uses
Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
ExtCtrls, Math, Igor Talkoff, Yriy Shewchuk, Slava Ivankoff, Sergey Dorenko, Nikita Djigurda, Irina Ponarowskaya, Viktor Coy, Egor Letov, Stas Barezkiy, Boris Eltsin, Gennadiy Zuganov, Djohar Dudaev, Ahmad Kadyrov, Vladimir Putin;

Компьютерная игра должна быть в виде 32/64-разрядного приложения откомпилирована в Cреде разработки Embarcadero RAD Studio 2013 XE3.

Основная Идея Игры «КУМИР-1990»: сделать 3 или более независимых сюжетных линий для Главных героев: Игоря Владимировича Талькова, Стаса Валерьевича Барецкого и Ирины Витальевны Понаровской, Никиты Джигурда, Сергея Доренко.

Нашему коллективу требуются:

Сценарист игры[Уже есть], HR-Менеджер[Знание кадров и умение разбираться в найме специалистов, начисление з/п, премии и проведение треннинго памяти по Японской системе], Ведущие-программисты, Программитсы, Ведущие-Тестировщики, Тестировщики, Менеджеры по Рекламе и СМИ.

Администратор группы/PR-менеджер.

Различные программисты. Спецэффектов, графического движка, демонстрации. Умение работать в графических и анимационных пакетах, желательно имевшие и имеющие опыт программирования под Windows 7/8/8.1/10/11 В средах Embarcadero/Delphi/С++, Assembler x86. Владение ООП - О Б Я З А Т Е Л Ь Н О !!! Желательно демонстрировать своё портфолио. Различные специалисты готовые биться над задачей до её окончательного решения неделями, а то и месяцами. Владение Github приветствуется. Работа с VCL-компонентами тоже, работа с файлами. Оплата сдельная, берём толковых студентов тоже со смежных специальностей.

Beta - Тесторы. Сразу оговорюсь; опытные, дотошные и умеющие грамотно описывать «bug». С ведением документации и оформлениями по Компьютерным ГОСТ'ам.

Да. Ещё. Мы будем знакомить с игрой и своими специалистами наших коллег по Торговому Союзу «BRICS» из разных стран в том числе: Бразилии, Индии, Китая, ЮАР,Сингапура, и др. Будем ещё делать обмен опытом специалистов.

Наш девиз:

… Молодо-зелено; не умеете - научим ! Не хотите - покажем как и … заставим работать как мотор после сборки на заводе или капитального ремонта.

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

СЮЖЕТНАЯ ЛИНИЯ ЗА ПЕРСОНАЖА ИГОРЯ ТАЛЬКОВА.

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

СЮЖЕТНАЯ ЛИНИЯ ЗА СТАНИСЛАВА ВАЛЕРЬЕВИЧА БАРЕЦКОГО.

0) Уровень Ленинград. Собрать Деньги разбросанные по дорожкам в Ленинградском Парке Победы и Купить Запчасти для Мотоцикла ИЖ-Планета-3. Купить в киоске журнал за 5р. и за 3р. выпить большую кружку Кваса у продавщицы из Жёлтой Бочки-Прицепа. Собрать по чертежам в журнале Сварочный Аппарат и мотоцикл в Таксопарке на Бухарестской улице в городе Ленинграде.

СЮЖЕТНАЯ ЛИНИЯ ЗА ИРИНУ ВАЛЕРЬЕВНУ ПОНАРОВСКУЮ.

[В стадии разработке].

СЮЖЕТНАЯ ЛИНИЯ ЗА ВЯЧЕСЛАВА КИРИЛЛОВИЧА ИВАНЬКОВА

0) Вячеслав Кириллович покупает Белорусский Компьютер «РАДИО-86РК» в Юном Технике в Ленинграде.

1) Вячеслав Кириллович в Цирке Шапито в Ленинграде. Убить кулаками всех Клоунов, Циркачей, Арлекинов, Собачек, Львов, Медведей на мотоциклах. В конце уровня «замочить» Директора Цирка и завладеть кейсом в 120 000 рублей, зайти в БАНК «МЕНАТЕП» Михаила Борисовича Ходороковского и обменять всю сумму кейса на Американские Доллары.

2) Идти до упора влево отбиваясь от Хулиганов и Панков. Дойти до кафе Механа на ст.м. Парк Победы. Зайти в кафе. Найти там Никиту Джигурду, купить у него Волгу-Газ 24-02. Поклониться и передать кейс ему в руки.

[В стадии разработке].

Мы на github.com: https://github.com/izzymoreno2/Igor-Talkov-1990

Game scriptwriter, HR manager [Knowledge of personnel and the ability to understand the hiring of specialists], Programmers, Testers. Group administrator/PR manager. Various programmers. Special effects, graphics engine, demonstration. Ability to work in graphics and animation packages, preferably those who have had and have experience programming under Windows 7/8/8.1/10/11 in Embarcadero/Delphi/C++, Assembler x86 environments. Knowledge of OOP is a MUST!!! It is advisable to demonstrate your portfolio. Various specialists are ready to struggle with the task until its final solution for weeks or even months. Knowledge of Github is welcome. Work with VCL components too, work with files. Piecework payment, we also take smart students from related specialties. Beta - Testers. I will immediately make a reservation; experienced, meticulous and able to competently describe the "bug". With documentation and registration according to Computer GOSTs. Yes. More. We will introduce the game and our specialists to our colleagues in the Trade Union "BRICS" from different countries, including: Brazil, India, China, South Africa, etc. We will also do an exchange of experience of specialists. Our motto: ... Young and green; if you don't know how - we will teach you! If you don't want - we will show you how and ... we will make it work like a motor after assembly at the factory or major repairs. ————— <Not Implemented> About the graphics. It must comply with the standard and be all in graphic formats *.png This is due to the convenience of displaying and layering various graphic sprites of the video game. </Not Implemented> ————— It would also be a Know-how to make the Day gradually change with the Night. <Current Design> Create a new character Valeria Novodvorskaya with a weapon in the form of a huge club. </Current Design> <Implemented> Requirements: The screen should scroll from the right end of the screen to the left. Igor should walk smoothly with animation of walking/running sprites. The Demo version already has this. </Implemented> <Partially Implemented> It is necessary to create three landscape plans: static, static-dynamic and dynamic. </Partially Implemented> <Implemented> Igor punches as he moves to the right. The animation delay timer is working. The series of punches is 5+. Igor punches as he moves to the left. </Not Implemented> Igor punches with his right foot. Create a character Valeria Ilyinichna Novodvorskaya and Yegor Letov with an electric guitar, Viktor Tsoi, Vladimir Volfovich Zhirinovsky, Alexander Friends. Igor runs back and forth. Switch to running using the Caps-Lock key. </Not Implemented> </Implemented> <Partially Implemented> The "Main Menu" of the Video Game has been designed. </Partially Implemented> ————— The entire game and style should be an imitation of the Konami corporation, Sega, Nintendo and the ZX-Renegade -128K and ZX-Target Renegade-128K games. 0) Level. Sochi cafe. Protect Tatyana Talkova, the future wife of the protagonist Igor, from hooligans. 1) Moscow level "Chistye Prudy" Chistye Prudy against the background of the park. Fight with hooligans. Find a secret place in the old chapel and take a huge Cross from there. 2) Moscow level "Moscow Metro" 3) Moscow level "Defenders of the White House" Idea! At the end of the level Coup - 1991, make a huge tank on which a tricolor flag will flutter. Boris Yeltsin with General Alexander Lebed and others should be standing there. 4) Level "Coup - 1991" Leningrad, St. Petersburg, Background; a huge crowd of people, a rally, a mess of people ... Igor must go to the stage of Palace Square to the microphone. 5) Moscow level "Sheremetyevo-2" Il - 62M Igor must deal with all the hooligans and fly to New York. [There is an idea that Vyacheslav Ivankov should give him a case with money]. The plane leaves at the end of the level. 6) Level New York Queens John F. Kennedy Airport. Igor must get his luggage and go to Brighton Beach. 7) Level Brighton Beach. Find the seller of the White Ferrari Don Johnson and buy this car from him. 8) In the chase through the state of Miami, ram the black BMW of Boris Abramovich Berezovsky. Take away from him the Golden Minoru, which Boris Abramovich bought in the St. Petersburg Synagogue. Then drive to the Airport and fly back to Russia. Create hooligans on motorcycles "Izh-planet 5", enemies from the bohemian pop music. Create punks, metalheads. We are on github.com: https://github.com/izzymoreno2/Igor-Talkov-1990

게임 시나리오 작가, 인사 관리자 [인사에 대한 지식과 전문가 채용에 대한 이해 능력], 프로그래머, 테스터. 그룹 관리자/홍보 관리자. 다양한 프로그래머. 특수효과, 그래픽 엔진, 데모. 그래픽 및 애니메이션 패키지 작업 능력이 필요하며, Windows 7/8/8.1/10/11에서 Embarcadero/Delphi/C++, Assembler x86 환경에서 프로그래밍 경험이 있는 사람이 선호됩니다. OOP에 대한 지식은 꼭 필요합니다!!! 포트폴리오를 보여주는 것이 좋습니다. 다양한 전문가들은 최종 해결책이 나올 때까지 몇 주, 심지어 몇 달 동안 이 문제와 씨름할 준비가 되어 있습니다. Github 소유권을 장려합니다. VCL 컴포넌트도 다루고, 파일도 다루고요. 급여는 일당제이며, 우리는 관련 전문 분야에서 똑똑한 학생들을 모집합니다. 베타 - 테스터. 지금 당장 예약하겠습니다. 경험이 풍부하고 꼼꼼하며 "버그"를 유능하게 설명할 수 있는 능력이 있습니다. 컴퓨터 GOST에 따라 문서화하고 등록합니다. 예. 더. 우리는 브라질, 인도, 중국, 남아프리카 공화국 등 다양한 국가의 BRICS 노동조합 동료들에게 게임과 전문가를 소개할 것입니다. 또한 전문가의 경험도 교환할 것입니다. 우리의 모토: …젊고 녹색이며, 방법을 모르시면, 우리가 가르쳐 드리겠습니다! 원치 않으시면 방법을 알려드리고... 공장에서 조립하거나 대대적인 수리를 거친 후 모터처럼 작동하도록 만들어드리겠습니다. ————— <구현되지 않음> 그래픽에 관하여. 표준을 준수해야 하며 모두 그래픽 형식(*.png)이어야 합니다. 이는 비디오 게임의 다양한 그래픽 스프라이트를 표시하고 레이어링하는 편의성 때문입니다. </구현되지 않음> ————— 또한 낮을 점차 밤으로 바꾸는 방법도 알아두는 것이 좋습니다. <현재 디자인> 거대한 곤봉 형태의 무기를 장착한 새로운 캐릭터 발레리아 노보드보르스카야를 만들어보세요. </현재 디자인> <구현됨> TZ: 화면은 오른쪽 끝에서 왼쪽 끝으로 스크롤되어야 합니다. 이고르는 걷기/달리기 스프라이트 애니메이션으로 부드럽게 걸어야 합니다. 데모 버전에 이미 나와 있습니다. </구현됨> <일부 구현됨> 3가지 조경 계획을 작성해야 합니다. 정적, 정적-동적, 동적. </부분적으로 구현됨> <구현됨> 이고르는 운전사를 오른쪽으로 밀쳐낸다. 애니메이션 지연 타이머가 작동 중입니다. 히트 시리즈는 5개 이상입니다. 이고르는 운전자를 왼쪽으로 때린다. </구현되지 않음> 이고르는 오른발로 차기를 한다. 일렉트릭 기타, Viktor Tsoi, Vladimir Volfovich Zhirinovsky, Alexander Druzya를 사용하여 Valeria Ilyinichna Novodvorskaya 및 Yegor Letov의 캐릭터를 만듭니다. 이고르는 앞뒤로 뛰어다닌다. Caps-Lock 키를 사용하여 실행으로 전환합니다. </구현되지 않음> </구현됨> <일부 구현됨> 비디오 게임의 "메인 메뉴"를 디자인했습니다. </부분적으로 구현됨> ————— 게임 전체와 스타일은 코나미, 세가, 닌텐도의 게임 ZX-Renegade-128K와 ZX-Target Renegade-128K를 모방한 것입니다. 0) 레벨. 소치 카페. 주인공 이고르의 미래의 아내인 타티아나 탈코바를 훌리건으로부터 보호하세요. 1) 레벨 모스크바 "Chistye Prudy" 공원을 배경으로 깨끗한 연못을 감상하세요. 훌리건과의 싸움. 오래된 예배당에서 비밀 장소를 찾아 거기에서 거대한 십자가를 가져오세요. 2) 레벨 모스크바 "모스크바 지하철" 3) 레벨 모스크바 "백악관 수호자들" 아이디어 ! Putsch - 1991 레벨의 마지막 부분에서 삼색기가 게양될 거대한 탱크를 만드세요. 보리스 옐친은 알렉산더 레베드 장군과 다른 사람들과 함께 서 있어야 합니다. 4) 레벨 "푸치 - 1991&quot; 레닌그라드, 상트페테르부르크, 배경; 사람들이 엄청나게 많이 모인 군중, 집회, 사람들이 난무하는 곳... 이고르는 궁전 광장 무대로 가서 마이크를 잡아야 합니다. 5) 레벨 모스크바 "셰레메티예보-2" Il - 62M 이고르는 모든 훌리건을 처리하고 뉴욕으로 날아가야 합니다. [뱌체슬라프 이반코프가 그에게 돈이 든 케이스를 주어야 한다는 생각이 있습니다]. 레벨이 끝나면 비행기가 날아갑니다. 6) 레벨 뉴욕 퀸즈 공항. 조나 케네디. 이고르는 자신의 짐을 챙겨 브라이튼 비치로 향해야 합니다. 7) 브라이튼 비치 수준. 흰색 페라리 돈 존슨의 판매자를 찾아서 그에게서 이 차를 사세요. 8) 마이애미에서 추격전을 벌이던 중 보리스 아브라모비치 베레조프스키의 검은색 BMW를 들이받았습니다. 보리스 아브라모비치가 상트페테르부르크 시나고그에서 구입한 황금 미노라를 그에게서 빼앗아 가세요. 그런 다음 공항으로 가서 러시아로 돌아갑니다. 이즈-플래닛 5 오토바이에서 훌리건을 만들고, 팝 음악 보헤미아의 적을 만들어 보세요. 펑크와 메탈헤드를 만들어내세요. 저희는 github.com에 있습니다:

###
Please! Do not modify the file structure of the Graphics directory, its contents, etc., the root files of the project. If you do this, the entire project will work with errors and incorrectly!
###
最新バージョンのプロジェクトとリポジトリ プロジェクトのルートファイルである Graphics ディレクトリのファイル構造やその内容などは変更しないでください。変更すると、プロジェクト全体がエラーを起こし、正しく動作しなくなります。$$$

以下は TOR と TT です。

技術要件:

メインキャラクターのモジュールを宣言してください:

Windows、Messages、SysUtils、Classes、Graphics、Controls、Forms、Dialogs、ExtCtrls、Math、Igor Talkoff、Yriy Shewchuk、Slava Ivankoff、Sergey Dorenko、Nikita Djigurda、Irina Ponarowskaya、Viktor Coy、Egor Letov、Stas Barezkiy、Boris Eltsin、Gennadiy Zuganov、Djohar Dudaev、Ahmad Kadyrov、Vladimir Putin を使用します。

コンピュータゲームは、Embarcadero RAD Studio 2013 XE3 開発環境でコンパイルされた32/64ビットアプリケーションである必要があります。

ゲーム「KUMIR-1990」の主なアイデア：メインキャラクター（Igor Vladimirovich Talkov、Stas Valerievich Baretsky、Irina Vitalievna Ponarovskaya、Nikita Dzhigurda、Sergey Dorenko）それぞれについて、3つ以上の独立したストーリーラインを作成すること。

チームに必要な人材：

ゲームスクリプトライター（既に募集中）、人事マネージャー（人事に関する知識、専門家の採用、給与・ボーナスの計算、日本のシステムに基づいた記憶力トレーニングの実施方法を理解できる能力）、リードプログラマー、リードテスター、テスター、広告・メディアマネージャー。

グループ管理者／広報マネージャー。

各種プログラマー。特殊効果、グラフィックエンジン、デモンストレーション。グラフィックおよびアニメーションパッケージの操作が可能で、Windows 7/8/8.1/10/11でEmbarcadero/Delphi/C++、Assembler x86環境でプログラミング経験のある方を歓迎します。OOPの知識は必須です！ポートフォリオをご提示いただければ幸いです。様々なスペシャリストが、数週間、あるいは数ヶ月かけて最終的な解決策を導き出すまで、共に課題に取り組む準備ができています。Githubの知識があれば歓迎します。VCLコンポーネントやファイルの使用も可能です。報酬は出来高払いで、関連分野の優秀な学生も歓迎します。

ベータテスター。経験豊富で、細心の注意を払い、「バグ」を適切に説明できる方をすぐにお申し込みします。コンピュータGOSTに準拠した書類作成と登録が必要です。

はい。さらに募集しています。ブラジル、インド、中国、南アフリカ、シンガポールなど、様々な国のBRICS労働組合の同僚に、ゲームと当社のスペシャリストを紹介します。また、スペシャリスト間の経験交流も行います。

私たちのモットー：

…若くて環境に優しい。やり方がわからない場合は、私たちがお教えします！ やりたくない場合は、工場での組み立て後や大規模な修理後、モーターのようにスムーズに動くようにお見せします。

————

ゲームのヒーローの様々なモジュールを、以下のように宣言することを忘れないでください。

——————

<未実装>

グラフィックについて。グラフィックはすべて標準に準拠し、*.png または *.tiff のグラフィック形式である必要があります。

これは、ビデオゲームの様々なグラフィックスプライトを表示およびレイヤー化する際の利便性のためです。

</未実装>

——————

昼と夜が徐々に変化するようにするのもノウハウの一つです。

<現在のデザイン>

巨大な棍棒の形をした武器を持つヴァレリア・ノヴォドヴォルスカヤという新しいキャラクターを作成します。また、ミハイル・シュフチンスキーとキーロフ・アコーディオンを持つアレクサンドラ・カリャノワも作成します。

</現在のデザイン>

<実装済み>

TOR: 画面は右端から左へスクロールします。イゴールは歩行/走行スプライトのアニメーションとともに滑らかに歩きます。デモ版には既に実装されています。

</実装済み>

主人公とイゴール・タルコフの敵キャラクターの画像変更メカニズム:

unit UIgorTalkoff;

interface

uses

Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,

Dialogs, ExtCtrls;

Const

//イゴール・タルコフのスプライト変更メカニズム用のシステム変数。

MaxImageTalkoff = 3;

MaxImgTalkoffMoveLeft = 8;

MaxImgTalkoffMoveRight = 8;

//スプライト変更用

MaxImgTalkoffFistLeft = 2;

MaxImgTalkoffFistRight = 2;

//MaxImgFreddyMoveSitLeft = 1;

//MaxImgFreddyMoveSitRight = 1;

type

TTalkoffDirection = (TalkoffdirectionLeft, TalkoffdirectionCenter, TalkoffdirectionRight, TalkoffdirectionFirstLeft, TalkoffdirectionFirstRight);

type

TTalkoffSpritesArr = BitMapの配列[0..MaxImageTalkoff];

pTalkoffSpritesArr = ^TTalkoffSpritesArr;

type

TTalkoff = class(TObject)

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

//Igorのレンダリング変数。

TalkoffUseFist: boolean;

//Igorのキックマーカー。

TalkoffUseRun : boolean;

//Igorのランマーカー、有効/無効タイプ。

ThereMove: TTalkoffDirection;

//Igorの移動方向トリガー。

TimerAnimationWalk: TTimer;

TimerAnimationFist: TTimer;

procedure Show;

//procedure Gravity;

プロシージャ OnTimerAnimationFist(送信元: TObject);

プロシージャ TimerAnimationProcessing(送信元: TObject);

コンストラクタ CreateTalkoff(X,Y: integer; ownerForm: TWinControl; var pTalkoffSpritesLeft, pTalkoffSpritesRight, pTalkoffSpritesKickLeft, pTalkoffSpritesKickRight

{pTalkoffSpritesMoveSitLeft, pTalkoffSprit
