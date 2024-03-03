-- Factorial
create or replace function f (p number) return number
is
begin
    if p < 0 then
        raise_application_error(-20162, 'Факториал можно вычислить только у натуральных чисел и нуля.', true);
    elsif p = 0 then
        return 1;
    else
        return p * f(p-1);
    end if;
end f;
/


--12
create table table1 as select * from dual;
create table table2 as select * from dual;

set serveroutput on size unl
begin
    dbms_output.put_line('start');
    delete from table1;
    dbms_output.put_line('delete completed');
    execute immediate'truncate table table2 nowait';
    dbms_output.put_line('truncate completed');
    commit;
exception
    when others then
        dbms_output.put_line('Exception');
        rollback;
end;
/

select * from table1;
select * from table2;



-- 14
select 
    string_agg(email, ', ' order by fio)
from administrators


-- 15
with recursive t as (
    select date_trunc('year', current_date) dt
    union all
    select dt + interval '1 day' dt
    FROM t
    WHERE dt < date_trunc('month', current_date) + interval '1 month'
)
insert into date_table
select dt
from t;

select * from date_table;


-- 16
select
    (select min(id) from minmax),
    (select max(id) from minmax)


-- 17
create or replace function factorial(p int) 
returns int
language plpgsql
as
$$
begin
    if p < 0 then
        raise exception 'Факториал можно вычислить только у натуральных чисел и нуля.';
    end if;
     
    if p = 0 then
        return 1;
    else
        return p * factorial(p-1);
    end if;
end;
$$;

SELECT factorial((SELECT number FROM temp_vars)) AS result;



-- 18
create or replace function process_message(p_msg text, p_bit int)
returns text
language plpgsql
as
$$
declare
    result text := p_msg;
begin
    if (p_bit & 1) = 1 then
        result := to_leet_speak(result);
    end if;
    
    if (p_bit & 2) = 2 then
        result := adjust_text_length(result);
    end if;
    
    if (p_bit & 4) = 4 then
        result := remove_spaces(result);
    end if;
    
    return result;
end;
$$;

SELECT process_message(msg, bit) FROM temp_vars;
