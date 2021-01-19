select * from 注文履歴テーブル
order by 注文順, 明細順

select 商品名 from 注文詳細テーブル
where 日付 = '2018-01'
order by 商品名

select distinct 商品名 from 注文履歴
where 日付 >= '2018-01-01' and 日付 <= '2018-01-31'
order by 商品名

select 注文番号, 注文枝番, 注文金額 from 注文詳細テーブル
where 分類 = 1
offset 2 fetch 2
order by 注文金額 asc

select 注文番号, 注文枝番, 注文金額 from 注文詳細テーブル
where 分類 = 1
offset 1 rows fetch next 3 rows onry
order by 注文金額 asc

select 日付, 商品名, 単価, 数量, 注文金額 from 注文詳細テーブル
where 分類 = 3 and 数量 >= 2
order by 日付, 数量 desc

select 分類, 商品名, サイズ, 単価 from 注文詳細テーブル
where 分類 = 1
union 
select 分類, 商品名, null, 単価 from 注文詳細テーブル
where 分類 = 2
union
select 分類, 商品名, null, 単価 from 注文詳細テーブル
where 分類 = 3
order by 分類, 商品名

select distinct 分類, 商品名, サイズ, 単価 from 注文詳細テーブル
where 分類 = 1
union 
select distinct 分類, 商品名, null, 単価 from 注文詳細テーブル
where 分類 = 2
union
select distinct 分類, 商品名, null, 単価 from 注文詳細テーブル
where 分類 = 3
order by 分類, 商品名

select * from 奇数テーブル
union
select * from 偶数テーブル

select * from 自然数テーブル
except
select * from 偶数テーブル

select * from 自然数テーブル
intersect
select * from 偶数テーブル

select * from 偶数テーブル
intersect
select * from 奇数テーブル

/* order by句を指定しないとselectの結果がどのような順序になるかわからない
指定した列に同じ値が存在すると抽出結果は不定となる */