
/* Скрипты писались в блокноте и не проверялись, отчего могут содержать синтаксические ошибки */

-- Задание 1
select * from t1 cross join t2

-- Задание 2
select length(str) - length(replace(str, '$')) "$ symbol count" from (select '124323$fsdf#dlf $ world' str from dual);

-- Задание 3
select value, count(1) cnt
from A
group by value
having count(1) > 1;

-- Задание 4
Запрос работать будет, вернет 2 записи

-- Задание 5
select * from dual connect by level <= 1e6;

-- Задание 6
select
	max(rate)keep(dense_rank last order by value_day)
from rates
where code = :b1
  and value_day <= :b2;
  
-- Задание 7
-- 1
select dep_id
from employee
group by dep_id
having count(employee_id) <= 15;

-- 2
select employee_id
from (
	select employee_id,
	   dense_rank()over(partition by dep_id order by salary desc) rnk
	from employee
)
where rnk = 1;

-- 3
select dep_id
from (
	select dep_id,
		dense_rank()over(order by sum(salary) desc) rnk
	from employee
	group by dep_id
)
where rnk = 1;

-- Задание 8
select
	client_id,
	max(case when upper(attrib) = 'A' then attrib_value end) attrib1,
	max(case when upper(attrib) = 'B' then attrib_value end) attrib2,
	...
	max(case when upper(attrib) = 'Z' then attrib_value end) attrib26
from client_attributes
group by client_id;


select * 
from client_attributes
pivot (
  max(attrib_value)
  for attrib in ( 'A' as attrib1, 'B' as attrib2,  'Z' as attrib26)
)
