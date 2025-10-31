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

```pascal
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
```
...TO BE CONTINUED
