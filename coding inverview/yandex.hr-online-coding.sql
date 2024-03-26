


--- Задание 2

with employees as (
  select 1 as emp_id, to_date('01.01.2023', 'dd.mm.yyyy') as date_from, to_date('31.12.2023', 'dd.mm.yyyy') as date_to from dual
  union all
  select 2 as emp_id, to_date('01.01.2023', 'dd.mm.yyyy') as date_from, to_date('31.12.2023', 'dd.mm.yyyy') as date_to from dual
  union all
  select 3 as emp_id, to_date('01.01.2023', 'dd.mm.yyyy') as date_from, to_date('31.12.2023', 'dd.mm.yyyy') as date_to from dual
  union all
  select 4 as emp_id, to_date('01.01.2023', 'dd.mm.yyyy') as date_from, to_date('31.12.2023', 'dd.mm.yyyy') as date_to from dual
  union all
  select 5 as emp_id, to_date('01.01.2023', 'dd.mm.yyyy') as date_from, to_date('31.12.2023', 'dd.mm.yyyy') as date_to from dual
)
, vacations as (
  -- первый работник в отпуск не ходил
  -- второй работник был два раза в отпуске в середине периода
  select 1 as vac_id, 2 as emp_id, to_date('03.02.2023', 'dd.mm.yyyy') as date_from, to_date('10.02.2023', 'dd.mm.yyyy') as date_to from dual
  union all
  select 7 as vac_id, 2 as emp_id, to_date('03.04.2023', 'dd.mm.yyyy') as date_from, to_date('10.04.2023', 'dd.mm.yyyy') as date_to from dual
  -- третий работник был в отпуске с момента начала работы до когда-то и с когда-то до конца работы
  union all
  select 3 as vac_id, 3 as emp_id, to_date('01.01.2023', 'dd.mm.yyyy') as date_from, to_date('10.02.2023', 'dd.mm.yyyy') as date_to from dual
  union all
  select 5 as vac_id, 3 as emp_id, to_date('03.12.2023', 'dd.mm.yyyy') as date_from, to_date('31.12.2023', 'dd.mm.yyyy') as date_to from dual
  -- четвертый работник был в соприкасающихся отпусках внутри интервала
  union all
  select 2 as vac_id, 4 as emp_id, to_date('03.02.2023', 'dd.mm.yyyy') as date_from, to_date('10.02.2023', 'dd.mm.yyyy') as date_to from dual
  union all
  select 6 as vac_id, 4 as emp_id, to_date('11.02.2023', 'dd.mm.yyyy') as date_from, to_date('10.03.2023', 'dd.mm.yyyy') as date_to from dual
  -- пятый работник всю работу провел в отпуске
  union all
  select 4 as vac_id, 5 as emp_id, to_date('01.01.2023', 'dd.mm.yyyy') as date_from, to_date('31.12.2023', 'dd.mm.yyyy') as date_to from dual
)

Дано:
Таблица сотрудников EMPLOYEES:
EMP_ID - идентификатор сотрудника
DATE_FROM - дата начала работы
DATE_TO - дата окончания работы

Таблица отпусков VACATIONS:
VAC_ID - идентификатор отпуска
EMP_ID - идентификатор сотрудника
DATE_FROM - дата начала отпуска
DATE_TO - дата окончания отпуска

Требуется:
Написать SQL-запрос, который выводит интервалы состояний в отпуске / не в отпуске для каждого сотрудника с сортировкой по сотруднику и интервалам:
EMP_ID - идентификатор сотрудника
VAC_ID - NULL, если сотрудник в этот интервал работал / идентификатор отпуска, если находился в отпуске
EFFECTIVE_START_DATE - дата начала интервала
EFFECTIVE_END_DATE - дата окончания интервала

Допущения:
Период работы у каждого сотрудника один
Все отпуска находятся в интервале работы сотрудника
Нет пересекающихся по датам отпусков

Пример результата для сотрудника 2
EMP_ID  VAC_ID  EFFECTIVE_START_DATE    EFFECTIVE_END_DATE
2       NULL    01.01.2023              02.02.2023
2       1       03.02.2023              10.02.2023
2       NULL    11.02.2023              02.04.2023
2       7       03.04.2023              10.04.2023
2       NULL    11.04.2023              31.12.2023


select emp_id, vac_id, esd effective_start_date, eed effective_end_date
from (
    select emp_id, null vac_id, date_from esd, 
        coalesce((select min(date_from)-1 from vacations v where v.emp_id = e.emp_id), date_to) eed
    from employee e
    where not exists (
            select 1 from vacations v
            where v.emp_id = e.emp_id
                and v.date_from = e.date_from 
        )
    union all
    select emp_id, vac_id, date_from, date_to from vacations
    union all
    select emp_id, vac_id, esd, eed from (
        select v.emp_id, null vac_id, v.date_to + 1 esd, lead(v.date_from - 1, 1, e.date_to)over(partition by v.empl_id order by v.date_from) eed
        from vacations v join employees e on e.emp_id = v.emp_id
    )
    where esd <= eed
)
order by emp_id, effective_start_date;

