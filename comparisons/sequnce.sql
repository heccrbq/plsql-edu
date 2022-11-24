/**
 *  NEXTVAL FROM SELECT VS PLSQL
 */

set timing on 
set serveroutput on
declare
    c_interate pls_integer := 1e6;
    l_nextval  number;
    --
    l_time     number := dbms_utility.get_time;
    procedure logtime(p_message in varchar2 default null)
    is
        l_curtime number;
    begin
        l_curtime := dbms_utility.get_time;
        dbms_output.put_line(case when p_message is not null then p_message || ' : ' end || to_char(l_curtime - l_time));
        l_time:= l_curtime;
    end logtime;
begin
    logtime;
    for i in 1..c_interate
    loop
        SELECT S_UBRR_LOG_TNUM.NEXTVAL into l_nextval FROM SYS.DUAL;
    end loop;
    logtime('   WITH SELECT');
    
    for i in 1..c_interate
    loop        
        l_nextval := S_UBRR_LOG_TNUM.NEXTVAL;
    end loop;
    logtime('WITHOUT SELECT');
end;
/





10 000 iterations                  100 000 iterations                  1 000 000 iterations
-----------------                  ------------------                  --------------------
Test 1:                            Test 1:                             Test 1:
-------                            -------                             -------
   WITH SELECT : 313                  WITH SELECT : 2870
WITHOUT SELECT : 313               WITHOUT SELECT : 2895

Test 2:                           Test 2:
-------                           -------
   WITH SELECT : 283                 WITH SELECT : 2735
WITHOUT SELECT : 274              WITHOUT SELECT : 2572

Test 3:                           Test 3:
-------                           -------
   WITH SELECT : 317                 WITH SELECT : 2604
WITHOUT SELECT : 307              WITHOUT SELECT : 2462


