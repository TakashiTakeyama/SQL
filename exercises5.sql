update 試験結果
set 午後1 = (80 * 5) - (86 + 68 + 91)
where 受験者ID = SW1046

update 試験結果
set 論述 = (68 * 5) - (65 + 53 + 70)
where 受験者ID = SW1350 

update 試験結果
set 午前 = (56 * 5) - (59 + 56 + 36)
where 受験者ID = SW1877 

select 受験者ID
  when 午前 >= 60 and 午後1 + 午後2 >= 120 and 論述 >= 平均点 * 0.3 as 合格者ID
from 試験結果

update 回答者
　set 国名 = case substring (trim (メールアドレス), length (trim (メールアドレス)) -1, 2)
    then 'jp' when '日本' 
    then 'uk' when 'イギリス'
    then 'cn' when '中国'
    then 'fr' when 'フランス'
    then 'vn' when 'ベトナム'
  end

select trim (メールアドレス), case 性別 
  then 'M' when concat ('男性', ':', substring (年齢, 0, 1) + 0 + '代')
  then 'F' when concat ('女性', ':', substring (年齢, 0, 1) + 0 + '代')
  end as 属性 
from 回答者

select trim (メールアドレス) as メールアドレス, 
  case when 年齢 >= 20 and 年齢 < 30 then '20代'
       when 年齢 >= 30 and 年齢 < 40 then '30代'
       when 年齢 >= 40 and 年齢 < 50 then '40代'
       when 年齢 >= 50 and 年齢 < 60 then '60代'
  end
  || ':' ||
  case 性別 when 'M' then '男性'
           when 'F' then '女性'
  end as 属性
  from 回答者

select 受注ID, 
  length (trim (文字)) as 刺繍に必要な文字数 
from 受注

select 受注日, 受注ID, length (trim (文字)) as 文字数, 
  case 書体コード 
    then 1 when 'ブロック体', 
    then 2 when '筆記体', 
    then 3 when '草書体', 
  end as 書体名
  case 書体コード 
    then 1 when 100, 
    then 2 when 150, 
    then 3 when 200, 
  end as 単価 
  case 文字
    then 10 >= length (trim (文字)) when 500
    then 10 < length (trim (文字)) when 0
  end as 特別加工料
from 受注

update 受注
  set 文字 = replace (文字, ' ', '★')
where 受注ID = '113'

select 受注日, 受注ID, 文字数,
   case coalesce (書体コード, '1')
    when '1' then 'ブロック体'
    when '2' then '筆記体'
    when '3' then '草書体' end as 書体名, 
   case coalesce (書体コード, '1')
    when '1' then 100
    when '2' then 150
    when '3' then 200 end as 書体名, 
   case when 文字数 > 10 then 500
   else 0 end as 特別加工料
from 受注
