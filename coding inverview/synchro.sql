1 задание 

Используя CTE pattern в качестве исходного набора данных, написать запрос который выбирет строки, содержащие только цифры.

with pattern as (select '123a345fb' str from dual union all select '2344556' from dual union all select 'a2404059b' from dual)
select * from pattern where translate(str,'#1234567890','#') is null


----------------------------------------------------------------------
2 задание 

Используя CTE pattern в качестве исходного набора данных

1. проверить есть ли в строках латинские символы
2. заменить латинтские символы на кириллические

with pattern as ( select 'Соловьeв' last_name from dual union all select 'Григорьев' from dual)
select translate(last_name,'AaBCcEeKkMOo','АаВСсЕеКкМОо') from pattern where regexp_like(last_name, '[A-Z]+',  'i') -- шаблон замены для translate можно продолжать по всему алфавиту. я написал для примера


-----------------------------------------------------------------------
3 задание

Используя CTE pattern в качестве исходного набора данных, написать запрос, который вернет  символы  столбца letter в количестве, соответствующему значению в столбце amount.

with pattern  as (select 'a' letter, 3 amount from dual union all select 'b', 4 from dual union all select 'c', 2 from dual)
select letter, amount from pattern 
    ,lateral (select 1 from dual connect by level <= pattern.amount)

получить результат 
letter amount
a    3
a    3
a    3
b    4
b    4
b    4
b    4
c    2
c    2
------------------------------------------------------------------------
4 задание 

Используя CTE pattern в качестве исходного набора данных, написать запрос, который сформирует результирующий набор из двух полей.
первое поле это исходные цифры поле l,  а второе будет формироваться по следующему правилу. нечетному числу будет сопоставлено следующее
по порядку нечетное число, а четному числу следующее по порядку четное число.

with pattern as (select level l from  dual connect by level<=100)
select l-2 l, l l_shift from pattern where l > 2

l,l_shift
1   3
2   4
3   5
4   6
.....
.....
96  98
97  99
98  100


-----------------------------------------------------------------
5 задание

Используя CTE pattern в качестве исходного набора данных, написать запрос без включения операторов DISTINCT и GROUP BY  который на выходе даст уникальные значения столбца num

with pattern as (select  1 num from dual union all select 2 from dual union all select 3 from dual union all select 1 from dual union all select 3 from dual)
select unique num from pattern -- речь была по distinct, а тут unique:)
----
--or
----
select num
from (
    select num,
        row_number()over(partition by num order by rownum) rn
    from pattern
)
where rn = 1


num
1
2
3

6 задание 

клиентам с датой последней активности 5 недель от текущего времени нужно определить любимого консультанта.
Любимым консультантом считается консультант, который ответил на два последних вопроса клиента.  Если консультация в истории клиента всего одна,
то тогда любимым  считается тот, кто товетил на этот вопрос.  
Есть таблица Answer с ответами по клиенту и в ней инфомрация кто провел консультацию.
Есть таблица CustomerKeyIndicators с ключевыми показателями по клиенту, среди них указатель на 1-й ответ и на последний ответ у клиента и кол-во ответов у клиента.
Есть таблица CustomerEvent с событиями по клиенту, куда сохраняются все события у клиента и в том числе ссылки на все отправленные сообщение и ответы.

Написать SQL  который будет выбирать клиентов(client_id + consulter_id любимого консультанта)

Answer        |   CustomerKeyIndicators |  CustomerEvent
id            |   Client_id             |   Client_id
Client_id     |   Last_activity_date-   |   Answer_id
Consulter_id  |   First_answer_id       |   Message_id
Answer_Date   |   Last_Answer_id        |   Message_type_id
              |   Answers_count         |
