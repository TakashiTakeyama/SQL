select * from  家計簿
where 日付 = '2018-03-01' and 費目 = '食費'

select * from  家計簿
where 日付 is null

/* ANDの方がORよりも優先度が高い */
select * from 家計簿
where メモ like '%1月' and 出金額 > 0

3-1
select * from 気象観測
where 月 = 6

select * from 気象観測
where not 月 = 6

select * from 気象観測
where 降水量 < 100

select * from 気象観測
where 降水量 > 200

select * from 気象観測
where 最高気温 >= 30 

select * from 気象観測
where 最低気温 <= 0 

select * from 気象観測
where 月 = 3 or 月 = 5 or 月 = 7

select * from 気象観測
where not 月 = 3 or 月 = 5 or 月 = 7

select * from 気象観測
where 最低気温 < 5 or 最高気温 < 35

select * from 気象観測
where 湿度 between 60 and 79

select * from 気象観測
where 観測データ is null

select 都道府県名　from 都道府県
where 都道府県名　like '%川'

select 都道府県名　from 都道府県
where 都道府県名　like '%島%'

select 都道府県名　from 都道府県
where 都道府県名　like '愛%'

select * from 都道府県
where 都道府県名 = 県庁所在地

select * from 都道府県
where 都道府県名 != 県庁所在地

select * from 成績表

insert into 成績表 ('学籍番号', '学生名', '法学', '経済学', '哲学', '情報理論', '外国語', '総合成績')
value ('S001', '織田信長', 77, 55, 80, 75, 93, null)

update from 成績表
set 法学 = 85 and 哲学 = 67
where 学籍番号 = 'S001'

update from 成績表
set 外国語 = 81 
where 学籍番号 = 'A002' and 学籍番号 = 'E003'

update from 成績表
set 総合成績 = 'A'
where '法学' >= 80 and '経済学' >= 8 and '哲学' >= 80 =nd '情報理論' >= 80 an= '外国語' >= 80

update from 成績表
set 総合成績 = 'B'
where ('法学' > 80 or '外国語' > 80) and ('哲学' > 80 or '経済学' > 80)

delete from 成績表
where '法学' = 0 or '外国語' = 0 or '哲学' = 0 or '経済学' = 0

/* 月、県コード、学籍番号 */

select * from 気象観測 where 月 <> 6
select * from 気象観測 where 月 != 6

/* いずれか */
select * from 気象観測 where 月 in (3, 5, 7)
/* 以外 */
select * from 気象観測 where 月 not in (3, 5, 7)