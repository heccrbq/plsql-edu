-- Сгенерировать последовательность чисел от 1 до 100

select level id from dual connect by level <= 100
/

with t(id) as (
    select 1 from dual
    union all
    select id+1 from t where id < 100)
select * from t
/

select id from dual
model
dimension by ( rownum rn)
measures (1 id)
rules iterate (101) (
    id[iteration_number] = iteration_number
)
/

select * from xmltable('1 to 100' columns id number path '.')
/

with function f(p_start number, p_stop number) return sys.odcinumberlist
is
    l_result$ sys.odcinumberlist := sys.odcinumberlist();
begin
    for i in p_start .. p_stop
    loop
        l_result$.extend;
        l_result$(i) := i;
    end loop;
    
    return l_result$;
end;
select column_value id from table(f(1,100));
/

