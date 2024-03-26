1. Требуется найти количество выходных дней (Сб, Вс) между двумя фиксированными датами.
Для решения требуется написать SQL-запрос

--2023-01-01 по 2023-01-31


with t as (
    select date'2023-01-01' + level - 1 dt from dual connect by date'2023-01-01' + level - 1 <= date'2023-02-04'
)

select count(1) from t where to_char(dt,'fmday', 'nls_date_language=ENGLISH') in ('sunday','saturday')



2. Имеется некоторая таблица t, в ней всего одно поле p типа number. 
Требуется отсортировать их по возрастанию и вывести результат таким образом, 
чтобы в каждой строке вывести по 10 значений, упорядоченных по возрастанию, через запятую.
Например:
t/p
1
2
3
9
7
10
15
19
5
8
6
4
Результат:
1, 2, 3, 4, 5, 6, 7, 8, 9, 10
15, 19, .....
Для решения требуется написать SQL-запрос.


with t as (select value(xt).getnumberval() val from xmltable('1 to 10, 15, 19') xt)

select listagg(val, ', ')within group(order by val desc) 
from (
    select val, trunc((val-1)/4)  grp_id from t) 
group by grp_id;



with t as (select value(xt).getnumberval() val from xmltable('1 to 10, 15, 19') xt),
   srt as(select val, row_number()over(order by val desc) rn from t)

select listagg(val, ', ')within group(order by val desc) 
from (
    select val, trunc((rn-1)/4)  grp_id from srt) 
group by grp_id
--order by grp_id desc



3. Допустим в банкомате есть купюры следующих номиналов и в таком кол-ве:
100р : 10 шт
200р : 15 шт
500р : 15 шт
Нужно найти все возможные комбинации купюр (номинал + кол-во), которые в сумме дадут 1000р.
Для решения требуется написать SQL запрос.


with t100 as (select 100 val_100, level-1 rn_100 from dual connect by level <= 10),
     t200 as (select 200 val_200, level-1 rn_200 from dual connect by level <= 15),
     t500 as (select 500 val_500, level-1 rn_500 from dual connect by level <= 15)
  
select 
    val_100, rn_100,
    val_200, rn_200,
    val_500, rn_500
from t100, t200, t500
where val_100 * rn_100 + val_200 * rn_200 + val_500 * rn_500 = 1000
