На входе есть строка с числами, разделенными пробелом (одним).
Нужно написать SQL запрос, который вернет все числа, которые встречаются в строке только один раз.
Т.е. для строки для строки
9 83 49 22 2 83 22 833
запрос должен вернуть (порядок чисел не важен)
9
49
2
833
Предпочтительным считается вариант без использования регулярных выражений.

with t as (
    select ' ' || trim(column_value) || ' ' string, 
        length(translate(column_value, '#0123456789','#')) + 1 space_count 
    from table(sys.odcivarchar2list('9 83 49 22 2 83 22 833'))
)

select result
from (
    select substr(string, instr(string, ' ', 1, level)+1, instr(string, ' ', 1, level+1) - instr(string, ' ', 1, level) - 1) result 
    from t connect by level <= space_count
)
group by result
having count(1) = 1
