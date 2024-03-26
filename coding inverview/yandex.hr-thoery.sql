1.Дана таблица TBL
A
------
10
[NULL]

Что выведет запрос?
select count(a), count(*), sum(a) 
  from tbl;

1, 2, 10

2.Дана таблица TBL
 ID   PARENT_ID  NAME
 ----------------------
 10   [NULL]     Подр_4
 2    10         Подр_3
 3    10         Подр_2

Написать запрос для вывода дерева подразделений с сортировкой дочерних узлов по полю NAME
Подр_4
  Подр_2
  Подр_3

select lpad(name, length(name) + level * 2, ' ') as name
from tbl
start with parent_id is null
connect by prior id = parent_id
order siblings by name

3.Дана таблица TBL
DEPT    EMP
------------
Подр1	Сотр1
Подр2	Сотр2
Подр2	Сотр3

Нужно сгруппировать по полю DEPT и перечислить значения из EMP через запятую с сортировкой по убыванию:
DEPT    EMPS
------------------
Подр1	Сотр1
Подр2	Сотр3, Сотр2

select dept, listagg(emp, ', ') within group(order by emp desc) emps
from tbl
group by dept

4.Дана таблица TBL
A
-------
1
[NULL]
2

Нужно отсортировать значения по столбцу "A", принудительно указав, что значения NULL всегда идут первыми

order by "A" asc nulls first

5.Что выведет запрос?
select 1 a
  from dual
 where dummy not in (select max(dummy) from dual where 1 = 0)

 0 rows selected.

 6.Какой процент строк удалит следующая команда если в таблице TBL значения в столбце id возрастают последовательно от 1 до 100?
delete from tbl where mod(id, 10) != 0

90%

7.Дата таблица TBL
A
-----
2
2
4
4
6

Что выведет запрос
select a, 
       rank() over(order by a) b, 
       dense_rank() over(order by a) c
  from tbl
order by a

A B C
-----
2 1 1
2 1 1
4 3 2
4 3 2
6 5 3

8.Выбрать две случайные записи из таблицы TBL со статусом ERROR, например 1 и 3, 8 и 2 и т.д.
Строк всегда две и в них разные значения ID (например, не должны выбраться две строки с ID 3)

Таблица TBL
ID      STATUS
--------------
1	ERROR
2	ERROR
3	ERROR
4	OK
5	ERROR
6	OK
7	OK
8	ERROR
9	OK
10	OK

select * From tbl
where status = 'ERROR'
order by dbms_random.value
fetch first 2 rows only

9.Что вернёт запрос и сколько времени будет выполняться?
with 
function f1 return number is
begin
    dbms_lock.sleep(3);
    return 1;
end;
function f2 return number is
begin
    dbms_lock.sleep(5);
    return 1;
end;
select nvl(2, f1) a, coalesce(2, f2) b
from dual;
/

2, 2 за 3 секунды

10.Максимальная длина сообщения в SQLERRM
1000

11.Максимальное число столбцов в таблице БД Oracle
255

12.Какие есть способы посмотреть предполагаемый и реальный планы SQL-запроса без GUI-средств?
explain plan for
...

select * from table(dbms_xplan.display)


sql_id...
select * From table(dbms_xplan.display_cursor())

13.Что за аббревиатура ASH?
Назовите одно из представлений.
Можно ли найти запрос в ASH если он длился 5 секунд?

v$active_session_history - снимок каждую секунду
dba_hist_active_sess_history - каждые 10 секунд

14.Как идентифицировать сессию в v$session или v$active_session_history если все сессии приложения выполняются под одним пользователем базы данных?


dbms_application_info
module
action,
client_indentifier

15.Будет ли читаться таблица при выборке если в плане SQL-запроса указано INDEX FAST FULL SCAN?

нет

16.Перечислите несколько PL/SQL exception-ов
no_data_found
too_many_rows
dup_val_on_index

17.Права на таблицу в PL/SQL пакете
Создаём пакет PL/SQL, выдаём право на выполнение другому пользователю.
Будет ли у другого пользователя ошибка при вызове пакета если у него нет доступа к таблице, которая используется в пакете?

Ошибки не будет, так как создается с права автора по умолчанию

18.Для чего используются политики (VPD) на таблицах и какой PL/SQL пакет используется?

при применении VPD в запрос дополнительно добавляется предикат фильтрации, которые отсекает недоступные пользователю строки

19.Для чего используется ключевое слово WITH в запросе?

- рекурсия
- Inline function
- СTE
-   no_merge
-   materialize
-   переиспользовать

20.Рассказать про профилирование методов PL/SQL: зачем используется, какие виды существуют.
- profiler
- hierarchical profiler (более новый)

21.Рассказать про Flashback. Какие нужны права. Написать запрос с просмотром данных на 1 час назад.
select * From tbl as of timestamp'2024-03-26 13:36:00';

22.Какой пакет содержит метод для вывода стёка ошибок и как называется метод?
dbms_utility.error_stacktrace
dbms_utility.backtrace

23.Назвать примеры json-функций. Написать пример выбора значения поля b из JSON-объекта {"a":{"b": 123}}
select * from (select '{a:{b:123}}' x from dual), json_table(x,'$.a.b' columns a number path '$')

24.Как назначить имя неименованному exception-у в PL/SQL блоке?
declare
    new_custom_exception exception;
    pragma exception_init(new_custom_exception, -60);
begin
when new_custom_exception then
    ....

25.Дана интерфейсная таблица XX_INTERFACE, в которую попадают данные из внешней системы.
Необходимо написать обработчик на plsql, который
для каждой строки интерфейсной таблицы запускает некоторое API XX_API_PKG.EXECUTE(id)
сделать так, чтобы программу можно было запускать параллельно самой себе, при этом API выше не нужно запускать 2 раза для одной строки интерфейсной таблицы.
CREATE TABLE XX_INTERFACE
( ID NUMBER PRIMARY KEY,
  TRX_NUMBER VARCHAR2(255)
)

dbms_parallel_execute

dbms_aq

dbms_lock


for update skip locked rows
