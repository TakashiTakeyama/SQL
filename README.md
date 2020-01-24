## SQLについて(標準SQL)
* SQLではキーワードの大文字小文字は区別されない。
* 文字列と日付の定数はシングルクォーテーションで囲む
* 標準SQLが書ければRDMSが違っても動作させることができる。

### テーブル作成
```
CREATE TABLE Shohin
(shohin_id CHAR(4) NOT NULL,
 shohin_mei VARCHAR(100) NOT NULL,  
 shohin_bunrui VARCHAR(32) NOT NULL,  
 hanbai_tanka INTEGER,  
 shiire_tanka INTEGER,  
 torokubi DATE,  
 PRIMARY KEY (shohin_id));
 ```
* CHAR型のデータ型は固定長文字列と言う形で文字列が格納される。
文字列が最大長に満たない場合は代わりに半角スペースが入る。
* VARCHAR型は可変長文字列になるので例え足りなくても

### テーブル削除
```
DROP TABLE Shohin;
```

### テーブル定義の変更
```
ALTER TABLE Shohin ADD COLUMN
ALTER TABLE Shohin ADD COLUMN Shohin_mei_kana VARCHAR(100);
ALTER TABLE Shohin ADD (Shohin_mei_kana VARCHAR2(100));
ALTER TABLE Shohin ADD shohin_mei_kana VARCHAR(100);
```

### テーブルの列の削除
```
ALTER TABLE Shohin DROP COLUMN <列名>
```

### Shohinテーブルにデータを登録するSQL文
```
-- DMLデータ登録
BEGIN TRANSACTION;

INSERT INTO shohin VALUES ('0001', 'Tシャツ', '衣服', 1000, 500, '2009-09-20');
INSERT INTO SHOHIN VALUES ('0002', '穴あけパンチ', '事務用品', 500, 320, '2009-09-11');
INSERT INTO SHOHIN VALUES ('0003', 'カッターシャツ', '衣服', 4000,
2800, NULL);
INSERT INTO SHOHIN VALUES ('0004', '包丁', 'キッチン用品', 3000, 2800, '2009-09-20');
INSERT INTO SHOHIN VALUES ('0005', '圧力鍋', 'キッチン用品', 6800, 5000, '2009-01-15');
INSERT INTO SHOHIN VALUES ('0006', 'フォーク', 'キッチン用品', 500, NULL, '2009-09-20');
INSERT INTO SHOHIN VALUES ('0007', 'おろしがね', 'キッチン用品', 880, 790, '2008-04-28');
INSERT INTO SHOHIN VALUES ('0008', 'ボールペン', '事務用品', 100, NULL, '2009-11-11');
COMMIT;
```

### テーブル名変更
```
ALTER TABLE Sohin RENAME TO Shohin;(posgresql)
RENAME TABLE Sohin to Shohin;(MySQL)
```
### 練習問題1
```
CREATE TABLE Jyushoroku
(
  toroku_bango INTEGER NOT NULL,
  name VARCHAR(128) NOT NULL,
  jyusho VARCHAR(256) NOT NULL,
  tel_no CHAR(10),
  mail_address CHAR(20),
  PRIMARY KEY(toroku_bango)
);
```
```
ALTER TABLE Jyushoroku ADD COLUMN yubin_bango CHAR(8) NOT NULL;
```
```
DROP TABLE Jyushoroku;
```

### SELECT文の基本
* SELECT文をマスターすることはSQLをマスターする事に直接つながる。
```
SELECT <別名>,
FROM <テーブル名>;
改行でもSQLは大丈夫。
```
```
SELECT句と同じ順番で並ぶ。
SELECT shohin_id, shohin_mei, shiire_tanka FROM Shohin;
SELECT *
FROM shohin;
アスタリスクは全列を意味する。ただしそうするとSELECT句の順番を指定することはできない。
```
```
列に別名をつけることもできる。
SELECT shohin_id AS id,
shohin_mei AS namae,
shiire_tanka AS tanka
別名には日本語も使うことができる。
shohin_id AS "商品ID",
shohin_mei AS "商品名"
FROM Shohin;
```
```
SELECT '商品' AS mojiretsu, 38 AS kazu, '2009-02-24' AS hizuke,
shohin_id, shohin_mei
FROM shohin;
SQL文の中に文字列や日付の定数を書く場合には、必ずシングルクウォーテーションで囲む。
```
### 重複するデータを省く時DISTINCTを使う。
```
SELECT DISTINCT shohin_bunrui
FROM shohin;
DISTINCTを使ったときはNULLも一種類のデータとして扱われる。
複数の行にある場合はやはり一種類として扱われる。
先頭の列名の前にしか書けない。
```
### where句による行の選択
```
SELECT <列名>
FORM <テーブル名>
WHERE <条件式>;
SELECT shohin_mei, shohin_bunrui
FROM shohin
WHERE shohin_bunrui = '衣服';
where句で条件にあう行をまず選択し、その後にselect句で指定された列を実行する。
where句は必ずFROM句の直後に書く。
-- 一行コメントの書き方
/*複数行のコメントの書き方*/
```
### SQL文には計算式もかける
```
SELECT shohin_mei, hanbai_tanka,
hanbai_tanka * 2 AS "hanbai_tanka_x2"
FROM Shohin;
NULLを含んだ演算子は問答無用でNULLになる。
SELECT shohin_mei, shohin_bunrui
FROM Shohin
WHERE hanbai_tanka = 500;
-- hanbai_tanka列が500ではない行
WHERE hanbai_tanka <> 500,;
WHERE torokubi < '2009-09-27';
必ず不等号が右側イコールが左側
WHERE hanbai_tanka - shiire_tanka >= 500;
```

```
-- DDL: テーブル作成
CREATE TABLE Chars
(chr CHAR(3) NOT NULL,
PRIMARY KEY (chr));

-- DML: データ登録
INSERT INTO Chars VALUES ('1');
INSERT INTO Chars VALUES ('2');
INSERT INTO Chars VALUES ('3');
INSERT INTO Chars VALUES ('10');
INSERT INTO Chars VALUES ('11');
INSERT INTO Chars VALUES ('222');
これを辞書式順序で並べると
1
10
11
2
222
3
になるよって結果が222, 3しかデータを取れなかった。
文字列型の順序の原則は辞書式、数値の大小と混同してはいけない。
COMMIT;
SQLにはNULLかどうかを判別するための専用の演算子IS NULLが用意されている。
SELECT shohin_mei, shiire_tanka
FROM Shohin
WHERE shiire_tanka IS NULL;
NULL以外を選択したい場合
WHERE shiire_tanka IS NOT NULL;
条件を否定するのがNOT演算子だが無理に否定することはない。
```
### AND演算子OR演算子
```
SELECT shohin_mei, shiire_tanka
FROM shohin
WHERE shohin_bunrui = 'キッチン用品'
AND hanbai_tanka >= 3000;
OR hanbai_tanka >= 3000;
OR演算子よりAND演算子の方が優先される
条件に優劣を付けない場合は()をつける。
SELECT shohin_mei, shiire_tanka
FROM shohin
WHERE shohin_bunrui = '事務用品'
AND (torokubi = '2009-09-11'
OR torokubi = '2009-09-20');
AND演算子が行う論理演算は論理積、OR演算子が行う論理演算は論理和と言う。
SQLは3値論理と呼ばれる真でも偽でもない不明(Unkown)がある。
NULLが存在する場合条件判定は複雑になり見通しも悪くなるので
なるべくNOT NULL制約をつけることが共通認識となっている。
```
### 練習問題2
```
SELECT shohin_mei, torokubi
FROM Shohin
WHERE torokubi > '2009-04-28'; 
SELECT *
FROM Shohin
WHERE Shiire_tanka = NULL;
SELECT *
FROM Shohin
WHERE Shiire_tanka <> NULL;
SELECT *
FROM Shohin
WHERE Shiire_tanka > NULL;
-- NULLに対して論理演算子は使えない。
SELECT shohin_mei, hanbai_tanka, shiire_tanka 
FROM Shohin
WHERE (hanbai_tanka - shiire_tanka) >= 500;
SELECT shohin_mei, hanbai_tanka, shiire_tanka
FROM Shohin
WHERE (shiire_tanka + 500) <= hanbai_tanka;
SELECT shohin_mei, shohin_bunrui, (hanbai_tanka * 0.9) - shiire_tanka AS rieki
FROM Shohin
WHERE (hanbai_tanka * 0.9) - shiire_tanka > 100;
```
```
-- 集計用の関数を集約関数、集合関数と呼ぶ
SELECT COUNT(*)
FROM shohin;
SELECT COUNT(shiire_tanka)
FROM Shohin;
-- NULLの行はカウントされない
SELECT COUNT(*), COUNT(shohin_mei)
FROM Shohin;
SELECT SUM(hanbai_tanka)
FROM shohin;
SELECT SUM(hanbai_tanka), SUM(shiire_tanka)
FROM shohin;
-- 集約関数はNULLを除外する、しかしCOUNT(*)は例外的にNULLを除外しない。SELECT AVG(hanbai_tanka)
FROM shohin;
SELECT MAX(hanbai_tanka), MIN(shiire_tanka)
FROM shohin;
SELECT MAX(torokubi), MIN(torokubi)
FROM shohin;
-- MAX/MIN関数はほとんど全てのデータ型に適用できる
SELECT COUNT(DISTINCT shohin_bunrui)
FROM Shohin;
-- DISTINCT は必ず()の中に書かなくてはいけない。
```
### グループ分けを行う GROUP BY
```
SELECT shohin_bunrui, COUNT(*)
FROM shohin
GROUP BY shohin_bunrui;
-- GROUP BY句に指定する列の事を集約キーやグループ化列と呼ぶ。
複数の列をカンマ区切りで指定する事ができる。
1. SELECT-> 2.FROM-> 3.WHERE-> 4.GROUP BY　句の入れ替えはできない。
集約キーにNULLが含まれる場合、結果にも不明行として出力される。
SELECT <列名1>,<列名2>,<列名3>
FROM <テーブル名>
WHERE
GROUP BY <列名1>,<列名2>,<列名3>;
SELECT shiire_tanka, COUNT(*)
FROM Shohin
WHERE shohin_bunrui = '衣服'
GROUP BY shiire_tanka;
実行順序 FROM-> WHERE-> GROUP BY-> SELECT
GROUP BY句を使うときは、SELECT句に集約キー以外の列名を付けない。
GROUP BY句を使った結果の順番はランダム、ソートはされない。
集約関数をかける場所SELECT句とHAVING句（とORDER BY句）だけ。
```
### HAVING句
```
-- WHERE句はあくまで「レコード」に対してのみしか条件を指定できない。
HAVING句はGROUP BYの後ろに書く
SELECT shohin_bunrui, COUNT(*)
FROM shohin
GROUP BY shohin_bunrui
HAVING COUNT(*) = 2;
SELECT shohin_bunrui, AVG(hanbai_tanka)
FROM shohin
GROUP BY shohin_bunrui
HAVING AVG(hanbai_tanka) >= 2500;
HAVING句でかける要素
定数
集約関数
集約キー　= カラム名
GROUP BY句で指定した列名(つまり集約キー)
HAVING句の使い方を考えるときは「一度集約が終わった段階のテーブルを出発点にしている。GROUP BYを使ったあとのSELECT句を考える時にも当てはまる。
集約キー に対する条件はWHERE句に書いた方が良い。
WHERE句 => ただの行に対する条件
HAVING => グループ化に対する条件
WHERE句はRDBMSの内部では行を絞り込んでからソートを行うので処理速度が早くなる
また、index[索引]を作成する事で処理を大幅に高速化することができる。
ORDER BY句はいつどんな時でも、SELECT句の後ろに書く必要がある、ソートを行うから、別名: ソートキーと呼ばれる。
ソートキーにNULLが含まれていた場合、先頭か末尾にまとめられる。
ORDER BY句では、SELECT句で付けた別名を利用できる。
ORDER BY句ではテーブルに存在する列であればSELECT句に含まれていない列でも指定できる。
ORDER BY句では、列番号は使わない。
SELECT shohin_bunrui
FROM Shohin
WHERE torokubi > '2009-09-01'
GROUP BY shohin_bunrui;
SELECT shohin_bunrui, SUM(hanbai_tanka), SUM(shiire_tanka)
FROM shohin
GROUP BY shohin_bunrui
HAVING SUM(hanbai_tanka) > SUM(shiire_tanka) * 1.5;

SELECT torokubi
FROM shohin
order by torokubi;

SELECT *
  FROM Shohin
 ORDER BY torokubi DESC, hanbai_tanka;
 ```
 ### データの更新
 ```
 CREATE TABLE ShohinIns
 (shohin_id CHAR(4) NOT NULL,
  shohin_mei VARCHAR(100) NOT NULL,
  shohin_bunrui VARCHAR(32) NOT NULL,
  hanbai_tanka INTEGER,
  shiire_tanka INTEGER,
  torokubi DATE,
  PRIMARY KEY (shohin_id));

INSERT INTO ShohinIns (shohin_id, shohin_mei, shohin_bunrui, hanbai_tanka, shiire_tanka, torokubi) VALUES ('0001', 'Tシャツ', '衣服', 1000, 500, '2009-09-20');
INSERT INTO ShohinIns (shohin_id, shohin_mei, shohin_bunrui, hanbai_tanka, shiire_tanka, torokubi) VALUES ('0001', 'Tシャツ', '衣服', DEFAULT, 500, '2009-09-20');
明示的にデフォルトを示す事でDEFAULT値を挿入できる。
INSERT INTO ShohinIns VALUES ('0002', '穴あけパンチ', '事務用品', 500, 320, '2009-09-11');
INSERT INTO ShohinIns VALUES ('0003', 'カッターシャツ', '衣服', 4000, 2800, NULL);
INSERT INTO ShohinIns VALUES ('0004', '包丁', 'キッチン用品', 3000, 2800, '2009-09-20');
INSERT INTO ShohinIns VALUES ('0002, '穴あけパンチ', '事務用品', 500, 320, '2009-09-11');
INSERT INTO ShohinIns VALUES ('0002, '穴あけパンチ', '事務用品', 500, 320, '2009-09-11');
明示的にデフォルトを示す事でDEFAULT値を挿入できる。
INSERT INTO ShohinIns VALUES('0005','圧力鍋', 'キッチン用品', 6800, 5000, '2009-01-15');
テーブルにdefault値を設定する
ALTAER TABLE ShoinIns ALTER hanbai_tanka SET DEFAULT 0;
CREATE TABLE ShohinCopy(
  shohin_id CHAR(4) NOT NULL,
  shohin_mei VARCHAR(100) NOT NULL,
  shohin_bunrui VARCHAR(32) NOT NULL,
  hanbai_tanka INTEGER,
  shiire_tanka INTEGER,
  torokubi DATE,
  PRIMARY KEY (shohin_id)
);

-- 商品テーブルのデータを商品コピーテーブルへ「コピー」
INSERT INTO ShohinCopy (shohin_id, shohin_mei, shohin_bunrui, hanbai_tanka, shiire_tanka, torokubi)
SELECT shohin_id, shohin_mei, shohin_bunrui, hanbai_tanka, shiire_tanka, torokubi
FROM Shohin;
CREATE TABLE ShohinBunrui
(shohin_bunrui VARCHAR(32) NOT NULL,
 sum_hanbai_tanka INTEGER,
 sum_shiire_tanka INTEGER,
 PRIMARY KEY(shohin_bunrui));
--テーブルを作成し、既存のテーブルからコピーする
INSERT INTO ShohinBunrui (shohin_bunrui, sum_hanbai_tanka, sum_shiire_tanka)
SELECT shohin_bunrui, SUM(hanbai_tanka), SUM(shiire_tanka)
FROM Shohin
GROUP BY shohin_bunrui;
INSERT文内のSELECT文ではWHERE句やGROUP BY句など、どんなSQL構文も使うことができる。
--探索型DELETE
TRUNCATE<テーブル名>;必ずテーブルを削除する。
DELETE文より処理が早いため実行時間を短縮できる。
DML文 DataManipulation Language　データ操作言語
DDL文 DataDefiniton Language データ定義言語
DDLだとRollbackができないOracleでは注意が必要、暗黙的にcommitされる。
--UPDATE文の基本構文
UPDATE <テーブル名>
SET <列名> = <式>;
--torokubiを統一する
UPDATE Shohin
SET torokubi = '2009-10-10';
NULLだった場合も値は更新される
UPDATE Shohin
SET hanbai_tanka = hanbai_tanka * 10
WHERE shohin_bunrui = 'キッチン用品';
NULLクリア: 列をNULLで更新すること
UPDATE Shohin
SET torokubi = NULL
WHERE shohin_id = '0008';
UPDATE Shohin
--二つのUPDATEを一つにまとめることもできる
--二度もUPDATE文を実行するのは無駄なため」」
SET habai_tanka = hanbai_tanka * 10
SET shire_tanka = shiire_tanka / 2
WHERE shohin_bunrui = 'キッチン用品';
UPDATE Shohin
SET (hanbai_tanka, shiire_tanka) = (hanbai_tanka * 10, shiire_tanka /2)
WHERE Shohin_bunrui = 'キッチン用品';
```
### トランザクション
```
-- セットで実行されるべき一つ以上の更新処理の集まりのこと
トランザクション構文
トランザクション開始文;
DML文①
DML文②
DML文③
トランザクション終了文(COMMIT または ROLLBACK);
DBMSによってトランザクション開始文は異なる
SQL Server, PostgreSQL
BEGIN TRANSACTION
MySQL
START TRANSACTION
Oracle, DB2
ない
COMMIT トランザクションを終了するコマンド
ROLLBACK トランザクションに含まれていた処理による変更を全て破棄してトランザクションを終了するコマンド

トランザクションには守るべき四つの大事な約束事が標準規格によって取り決められているそれをACID特性という。
Atomicty原子性: トランザクションが終わった時に、そこに含まれていた更新処理は、全て実行されるか、または全て実行されない状態で終わることを保証する性質の事
COMMITかROLLBACKか
Consistency一貫性: トランザクションい含まれる処理は、データベースに予め設定された制約、例えば主キーやNOT NULL制約を満たす、という性質。
整合性 = 一貫性
Isolation独立性: トランザクション同士が互いに干渉を受けないことを保証する性質です。
Durability永続性: これは耐久性と言っても良いのですが、トランザクションが(コミットにせよロールバックにせよ)終了したら、その時点でのデータベースの状態が保存されることを保証する性質です。
この永続性を保証する方法は、実装によって異なるが一番ポピュラーなものは、トランザクションの実行記録をディスクなどに保存しておき(このような実行記録をログという)、障害が起きた際このログを使って障害前の状態に復旧するという方法。
UPDATE ShohinSaeki
SET hanbai_tanka = habai_tanka - 1000;
SET saeki = shiire_tanka - hanbai_tanka;
WHERE hanbai_mei = 'カッターシャツ';
CREATE TABLE ShohinSaeki
(shohin_id    CHAR(4)       NOT NULL,
 shohin_mei   VARCHAR(100)  NOT NULL,
 hanbai_tanka INTEGER,
 shiire_tanka INTEGER,
 saeki        INTEGER,
 PRIMARY KEY(shohin_id));
 INSERT INTO ShohinSaeki VALUES ('0001', 'Tシャツ', 1000, 500, 500);
 INSERT INTO ShohinSaeki (shohin_id, shohin_mei, hanbai_tanka, shiire_tanka, saeki)
 SELECT shohin_id, shohin_mei, hanbai_tanka, shiire_tanka, hanbai_tanka - shiire_tanka
 FROM Shohin;

 UPDATE ShohinSaeki
 SET hanbai_tanka = 3000, saeki = shiire_tanka - hanbai_tanka
 --複数の更新を行うときはカンマで区切る。
 WHERE shohin_mei = 'カッターシャツ';
```
### 複雑な問合せ
```
-- viewについて
SQLの観点から見ると"テーブルと同じもの"
SELECT文を組み立てる際にはテーブルとビューの違いは気にしなくても良い
実際のデータを保存しているかどうかが違う
viewのメリット: 記憶装置を使わないので要領を節約できる。
よく使うSELECT文は使いまわせるため便利である。

--ビュー文の書き方
CREATE VIEW ビュー名 (<ビューの列名1>, <ビューの列名2>)
AS
<SELECT文>

CREATE VIEW ShohinSum (shohin_bunrui, cnt_shohin)
AS
SELECT Shohin_bunrui, COUNT(*)
FROM Shohin
GROUP BY shohin_bunrui;

ビューはテーブルと同じくFROM句に書くことができる
SELECT shohin_bunrui, cnt_shohin
FROM ShohinSum;

ビューに対する検索
1: 最初に、ビューに定義されたSELECT文が実行され、
2: その結果にたいして、ビューをFROM句に指定したSELECT文が実行される
つまりビューに対する検索はでは、常に２つ以上のSELECT文が実行される
ビューの上にビューを重ねる多段ビューを作成することも可能

CREATE VIEW ShohinSumJim (shohin_bunrui, cnt_shohin)
AS
SELECT shohin_bunrui, cnt_shohin
FROM ShohinSum
WHERE shohin_bunrui = '事務用品';
しかしなるべく多段ビューを避けるパフォーマンスの低下を招くから

ビュー定義の制限事項
ビュー定義でORDER BY句は使えない
なぜかというと行には順序が無いと定められているから。
ビューに対する更新
DISTINCT　行単位で重複したデータがまとめられる
1: SELECT句にDISTINCTが含まれていない
2: FROM句に含まれるテーブルが一つだけである
3: GROUP BY句を使用していない
4: HAVING句を使用してはいない
ビューはあくまでテーブルから派生しているなので元のテーブルが変更されればビューのデータ内容も変更される。

posgersqlの場合多段ビューの作成元となっているビューを削除する場合に、それに依存するビューが存在すると次のようなエラーになる。
ERROR: 他のオブジェクトが依存しています。
DETAIL: ・・・が・・・に依存しています。
HINT: 依存しているオブジェクトも削除するにはDROP...CASCADEしてください。
DROP VIEW ShohinJim CASCADE;

サブクエリ: 使い捨てのビュー（SELECT文）viewと異なりselect文終了後に消去される。
queryはselect文と同義
サブクエリはFROM句のなかに書く先にそちらのselect文が実行されてその後に上のクエリが実行される。

サブクエリの階層数には制限がないので幾つでも入れ子構造にすることができる。

SELECT Shohin_bunrui, cnt_shohin
FROM (SELECT * 
        FROM (SELECT shohin_bunrui, COUNT(*) AS cnt_shohin
                FROM Shohin
                GROUP BY shohin_bunrui) AS ShohinSum
                WHERE cnt_shohin = 4) AS ShohinSum2;

サブクエリが深くなると見通しも悪くなるし、パフォーマンスも落ちるのでなるべく深くなることを防ぐ。
ASは省略可能。
スカラサブクエリ: スカラとは「単一の」という意味がある。
サブクエリは複数行返す事もあるが、スカラサブクエリは「必ず一行一行だけの戻り値を返す」という制限をつけたサブクエリの事
戻り値が単一というこうとはこれを使って条件式の比較演算子で評価させることができる。
集約関数をWHERE句に書くことはできない。AVGとか

SELECT shohin_id, shohin_mei, hanbai_tanka
FROM Shohin
--ここからしたのSELECT文がスカラサブクエリ
WHERE hanbai_tanka > (SELECT AVG(hanbai_tanka)
                      FROM Shohin);
        
基本的にスカラ値がかけるところにはどこにでもかける、つまり定数や列名を書くことのできる場所全てにかけるのでSELECT句でもGROUP BY句でもHAVING句でもORDER BY句でもほとんどあらゆる場所に書くことができる。
HAVING句: GROUP BY句に対する条件式

SELECT shohin_bunrui, AVG(hanbai_tanka)
FROM Shohin
GROUP BY shohin_bunrui
HAVING AVG(hanbai_tanka) > (SELECT AVG(hanbai_tanka)
                            FROM Shohin);

相関サブクエリはテーブル全体ではなく、テーブルの一部のレコード集合に限定した比較をしたい場合に使う。
SELECT shohin_bunrui, shohin_mei, hanbai_tanka
FROM Shohin AS S1
WHERE hanbai_tanka > (SELECT AVG(hanbai_tanka)
                      FROM Shohin AS S2
                      WHERE S1.shohin_bunrui = S2.shohin_bunrui
                      GROUP BY shohin_bunrui);

相関サブクエリを使うと、俗に「縛る（バインドする）」とか制限するとか行ったりする。
今回の場合は商品分類で縛って「平均単価との比較を行っている」
相関サブクエリもGROUP BYと同じくケーキを切り分けるような「集合」のカットのような機能を持っている。

CREATE VIEW ViewReshu5_1 (shohin_mei, hanbai_tanka, torokubi)
AS
SELECT shohin_mei, hanbai_tanka, torokubi
FROM Shohin
WHERE hanbai_tanka <= 1000
AND torokubi = '2009-9-20';

SELECT shohin_id, shohin_mei, shohin_bunrui, hanbai_tanka, (SELECT AVG(hanbai_tanka) FROM shohin AS hanbai_tanka_all)
FROM shohin;

SELECT shohin_id,
   shohin_mei,
   shohin_bunrui,
   hanbai_tanka, 
   (SELECT AVG(hanbai_tanka) 
   WHERE S1.shohin_bunrui = S2.shohin_bunrui FROM shohin AS S2
   GROUP BY S1.shohin_bunruiAS hanbai_tanka_all
FROM shohin AS S1;


