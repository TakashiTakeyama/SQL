select distinct 列名...
from テーブル名

select distinct 費目 from 家計簿

/* select句にしか使えない修飾詞 */

select * from 家計簿
order by 日付 desc

select * from 家計簿
order by 日付 desc, 出金額 asc

/* offsetで先頭から３行を除外して、４から１０行目を取得 */
select * from 家計簿
order by 出入金 desc
offset 3 rows
fetch next 10 rows onry

select * from 家計簿
order by 費目 desc limit 3

select 費目, 入金額 from 家計簿
union
select 費目, 入金額, 出金額 from 家計簿アーカイブ
/* デフォルトのソート順は昇順 */
order by 2, 3, 1

select 費目, 入金額, 出金額 from 家計簿
union
select 費目, 入金額, null from 家計簿アーカイブ
order by 2, 3, 1

select 費目 from 家計簿
except
select 費目 null from 家計簿アーカイブ

select 費目 from 家計簿
intersect
select 費目 null from 家計簿アーカイブ

select 出金額, 出金額 + 100 as 出金額だよ, 'SQL' from 家計簿

insert into 家計簿 (出勤額)
values (出勤額 + 100)

update 家計簿
set 出勤額 = 出勤額 + 100

select 費目, 出金額,
  case 費目 when '居住費' then '固定費'
           when '水道光熱費' then '固定費'
           else '変動費'
  end as 出費の分類
from 家計簿 where 出勤額 > 0

select 費目, 入金額,
	case when 入金額 < 500 then 'お小遣い'
		when 入金額 < 10000 then '一時収入'
		when 入金額 < 30000 then '給与'
  end as 収入の分類
from 家計簿
where 入金額 > 0

select メモ, length (メモ) as メモの長さ from 家計簿

select メモ, trim (メモ) as トリムしたメモ from 家計簿

update 家計簿
/* メモの値に購入があったら、買ったに置き換える */
set メモ = replace (メモ, '購入', '買った')

select * from 家計簿
/* 費目の1~3文字目に「費」があるものだけを抽出 phpと一緒*/
where substring (費目, 1, 3) like '%費%'

select concat (費目, 'ここの文字列を接続' || メモ) from 家計簿

insert into 家計簿
values (current_date, '食費', 'ドーナツを買った', 0, 260)

select 出勤額 from 家計簿
cast (出勤額 as varcha(20) + '円')

/* メモにnullがあった時「メモはNULLです」に置き換える */
select 日付, 費目,
  coalesce (メモ, '(メモはNULLです)') as メモ,
  入金額, 出勤額
from 家計簿

/* olacleでは　必ず from句が必要 */

select 日付, 費目,
  case when length (メモ) >= 8 then substring (メモ, 1, 8) concat (メモ, '...') else メモ
  end as メモ, 入金額, 出金額
from 家計簿

select * from 家計簿 where 日付 > current_date

/* 文字列の結合 CONCAT */
mysql> SELECT CONCAT('My', 'S', 'QL');
        -> 'MySQL'
mysql> SELECT CONCAT('My', NULL, 'QL');
        -> NULL
mysql> SELECT CONCAT(14.3);
        -> '14.3'