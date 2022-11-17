/* FORALL 15x faster then FOR */

drop table dropme purge;

create table dropme (col1 number) pctfree 0;

set timing on
set serveroutput on size unl
declare
    l_rowcount number := 1e6;
    l_collect  sys.ku$_objnumset;
    --
    l_time    number := dbms_utility.get_time;
    procedure logtime(p_message in varchar2)
    is
        l_curtime number;
    begin
        l_curtime := dbms_utility.get_time;
        dbms_output.put_line(p_message || ' : ' || to_char(l_curtime - l_time));
        l_time:= l_curtime;
    end logtime;
begin
    logtime('start');
    
    select level 
    bulk collect into l_collect 
    from dual connect by level <= l_rowcount;
    
    forall i in indices of l_collect
        insert into dropme values (l_collect(i));
    
    logtime('forall');
    
    for i in (select level lvl from dual connect by level <= l_rowcount)
    loop
        insert into dropme values (i.lvl);
    end loop;
    
    logtime('for');
end;
/
 
 
 
PL/SQL procedure successfully completed.
 
Elapsed: 00:00:31.117
 
start  : 0
forall : 187
for    : 2922
