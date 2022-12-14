/**
 *  NEXTVAL FROM SELECT VS PLSQL
 */

drop sequence dropme_seq;
create sequence dropme_seq cache 20;


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
        select dropme_seq.nextval into l_nextval from sys.dual;
    end loop;
    logtime('   WITH SELECT');
    
    for i in 1..c_interate
    loop        
        l_nextval := dropme_seq.nextval;
    end loop;
    logtime('WITHOUT SELECT');
end;
/


===========================================================                     ===========================================================
|           N O C A C H E      S E Q U E N C E            |                     |            C A C H E  20     S E Q U E N C E            |   
===========================================================                     ===========================================================
|  Test  |  Number of |  Elapsed time |    WITH | WITHOUT |                     |  Test  |  Number of |  Elapsed time |    WITH | WITHOUT |
| number | iterations |               |  SELECT |  SELECT |                     | number | iterations |               |  SELECT |  SELECT |
===========================================================                     ===========================================================
|      1 |     10 000 |  00:00:06.886 |     356 |     330 |                     |      1 |     10 000 |  00:00:01.468 |      70 |      75 |
|      2 |     10 000 |  00:00:05.909 |     295 |     295 |                     |      2 |     10 000 |  00:00:00.987 |      47 |      50 |
|      3 |     10 000 |  00:00:05.580 |     286 |     271 |                     |      3 |     10 000 |  00:00:01.638 |      86 |      73 |
|      4 |     10 000 |  00:00:05.143 |     259 |     255 |                     |      4 |     10 000 |  00:00:01.024 |      51 |      51 |
|      5 |     10 000 |  00:00:05.168 |     235 |     281 |                     |      5 |     10 000 |  00:00:01.448 |      71 |      73 |
===========================================================                     ===========================================================
| based on  10k iterations: eq - 1, with - 1, without - 3 |                     | based on  10k iterations: eq - 1, with - 3, without - 1 |
===========================================================                     ===========================================================
|      1 |    100 000 |  00:00:00.000 |       ? |       ? |                     |      1 |    100 000 |  00:00:12.257 |     582 |     642 |
|      2 |    100 000 |  00:00:00.000 |       ? |       ? |                     |      2 |    100 000 |  00:00:12.016 |     583 |     617 |
|      3 |    100 000 |  00:00:00.000 |       ? |       ? |                     |      3 |    100 000 |  00:00:12.220 |     618 |     603 |
|      4 |    100 000 |  00:01:00.000 |       ? |       ? |                     |      4 |    100 000 |  00:00:11.588 |     562 |     596 |
|      5 |    100 000 |  00:00:00.000 |       ? |       ? |                     |      5 |    100 000 |  00:00:11.522 |     573 |     579 |
===========================================================                     ===========================================================
| based on 100k iterations: eq - ?, with - ?, without - ? |                     | based on 100k iterations: eq - 0, with - 4, without - 1 |
===========================================================                     ===========================================================
|      1 |    100 000 |  00:00:00.000 |       ? |       ? |                     |      1 |  1 000 000 |  00:01:58.114 |    5622 |    6188 |
|      2 |    100 000 |  00:00:00.000 |       ? |       ? |                     |      2 |  1 000 000 |  00:02:05.023 |    6278 |    6223 |
|      3 |    100 000 |  00:00:00.000 |       ? |       ? |                     |      3 |  1 000 000 |  00:02:09.008 |    6306 |    6594 |
|      4 |    100 000 |  00:01:00.000 |       ? |       ? |                     |      4 |  1 000 000 |  00:02:04.570 |    6250 |    6206 |
|      5 |    100 000 |  00:00:00.000 |       ? |       ? |                     |      5 |  1 000 000 |  00:01:53.584 |    5760 |    5598 |
===========================================================                     ===========================================================
| based on  1M  iterations: eq - ?, with - ?, without - ? |                     | based on  1M  iterations: eq - 0, with - 2, without - 3 |
===========================================================                     ===========================================================
