with t as (
    select ' ' || trim(column_value) || ' ' string, 
        length(translate(column_value, '#0123456789','#')) + 1 space_count 
    from table(sys.odcivarchar2list('9 83 49 22 2 83 22 833'))
)

select result
from (
    select substr(string, instr(string, ' ', level)+1, instr(string, ' ', level+1) - instr(string, ' ', level) - 1) result 
    from t connect by level <= space_count
)
group by result
having count(1) = 1
