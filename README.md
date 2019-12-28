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
```