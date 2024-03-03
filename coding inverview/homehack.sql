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
