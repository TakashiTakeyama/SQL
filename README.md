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
FROM Shohin;
```