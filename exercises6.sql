select sum (降水量) as 年間降水量, avg (最高気温) as 最高気温の平均, avg (最低気温) as 最低気温の平均
from 年別気象観測

select sum (降水量) as 年間降水量, avg (最高気温) as 最高気温の平均, avg (最低気温) as 最低気温の平均
from 年別気象観測
where 都市名 = '東京'

select 都市名, avg (降水量) as 降水量の平均, min (最高気温) as 最も低かった最高気温, max (最低気温) as 最も高かった最低気温 
from 年別気象観測
group by 都市名

select sum (降水量), avg (最高気温) as 最高気温の平均, avg (最低気温) as 最低気温の平均
from 年別気象観測
group by 月

select 都市名, 最高気温 as 気温
from 年別気象観測
group by 最高気温
having 最高気温 >= 38

select 都市名, 最低気温 as 気温
from 年別気象観測
group by 最低気温 
having 最低気温 <= 10 

select 社員名
from 入退室管理
where 体質 = null

select (*) as 社員数
from 入退室管理
where 退室 = null

select 社員名, count (case when 退室 = null) as 入室回数
from 入退室管理
group by 社員名

select 社員名, count (case when 退室 = null) as 入室回数
from 入退室管理
group by 社員名
having 入室回数 >= 10

select count (社員名) as 社員数
from 入退室管理
where 自由区分 = 3
group by 社員名
having 日付

1, 2, 3, 5,

select 費目, sum (出金額) as 合計額, count (出金額) as 回数
from 家計簿
where 出金額 > 0
group by 費目
having count (出金額) >= 5
/* and 費目 = '食費' and 費目 = '居住費' とおなじ事 */
and 費目 in ('食費', '居住費')

/* こちらの方がwhere句で条件を指定しているので結果的に早くなる */
select 費目, sum (出金額) as 合計額, count (出金額) as 回数
from 家計簿
where 出金額 > 0
and 費目 in ('食費', '居住費')
group by 費目
having count (出金額) >= 5

select case 自由区分 when '1' then 'メンテナンス'
  when '2' then 'リリース作業'
  when '3' then '障害対応'
  when '9' then 'その他'
  end as 事由,
  count (*) as 入室回数
  from 入退室管理
  group by 事由区分
