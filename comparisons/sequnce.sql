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





===========================================================
|  Test  |  Number of |  Elapsed time |    WITH | WITHOUT |
| number | iterations |               |  SELECT |  SELECT |
===========================================================
|      1 |     10 000 |  00:00:06.689 |     357 |     309 |
|      2 |     10 000 |  00:00:05.849 |     292 |     292 |
|      3 |     10 000 |  00:00:05.629 |     286 |     276 |
|      4 |     10 000 |  00:00:06.389 |     305 |     333 |
|      5 |     10 000 |  00:00:06.109 |     313 |     298 |
===========================================================
| based on  10k iterations: eq - 1, with - 1, without - 3 |
===========================================================
|      1 |    100 000 |  00:00:57.828 |    2802 |    2979 |
|      2 |    100 000 |  00:00:50.615 |    2492 |    2569 |
|      2 |    100 000 |  00:00:50.615 |    2492 |    2569 |

