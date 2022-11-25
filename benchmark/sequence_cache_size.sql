/**
 *  CACHE SIZE: from 0 to 1M
 */

drop sequence dropme_seq;
drop sequence dropme_seq20;
drop sequence dropme_seq50;
drop sequence dropme_seq100;
drop sequence dropme_seq500;
drop sequence dropme_seq1000;
drop sequence dropme_seq5000;
drop sequence dropme_seq10000;
drop sequence dropme_seq50000;
drop sequence dropme_seq100000;
drop sequence dropme_seq500000;
drop sequence dropme_seq1000000;
create sequence dropme_seq nocache;
create sequence dropme_seq20 cache 20;
create sequence dropme_seq50 cache 50;
create sequence dropme_seq100 cache 100;
create sequence dropme_seq500 cache 500;
create sequence dropme_seq1000 cache 1000;
create sequence dropme_seq5000 cache 5000;
create sequence dropme_seq10000 cache 10000;
create sequence dropme_seq50000 cache 50000;
create sequence dropme_seq100000 cache 100000;
create sequence dropme_seq500000 cache 500000;
create sequence dropme_seq1000000 cache 1000000;


set timing on 
set serveroutput on
declare
    c_interate pls_integer := 5e5;
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
        l_nextval := dropme_seq.nextval;
    end loop;
    logtime('nocache');
    
    for i in 1..c_interate
    loop
        l_nextval := dropme_seq20.nextval;
    end loop;
    logtime('cache 20');
    
    for i in 1..c_interate
    loop
        l_nextval := dropme_seq50.nextval;
    end loop;
    logtime('cache 50');
    
    for i in 1..c_interate
    loop
        l_nextval := dropme_seq100.nextval;
    end loop;
    logtime('cache 100');
    
    for i in 1..c_interate
    loop
        l_nextval := dropme_seq500.nextval;
    end loop;
    logtime('cache 500');
    
    for i in 1..c_interate
    loop
        l_nextval := dropme_seq1000.nextval;
    end loop;
    logtime('cache 1000');
    
    for i in 1..c_interate
    loop
        l_nextval := dropme_seq5000.nextval;
    end loop;
    logtime('cache 5000');
    
    for i in 1..c_interate
    loop
        l_nextval := dropme_seq10000.nextval;
    end loop;
    logtime('cache 10000');
    
    for i in 1..c_interate
    loop
        l_nextval := dropme_seq50000.nextval;
    end loop;
    logtime('cache 50000');
    
    for i in 1..c_interate
    loop
        l_nextval := dropme_seq100000.nextval;
    end loop;
    logtime('cache 100000');
    
    for i in 1..c_interate
    loop
        l_nextval := dropme_seq500000.nextval;
    end loop;
    logtime('cache 500000');
    
    for i in 1..c_interate
    loop
        l_nextval := dropme_seq1000000.nextval;
    end loop;
    logtime('cache 1000000');
end;
/


=========================================================================================================================================
|  Test  |    Number  |  Elapsed time | NOCACHE | CACHE | CACHE | CACHE | CACHE | CACHE | CACHE | CACHE | CACHE | CACHE | CACHE | CACHE |
| number |   of value |               |         |    20 |    50 |   100 |   500 |    1K |    5K |   10K |   50K |  100K |  500K |    1M |
=========================================================================================================================================
|      1 |          1 |  00:00:00.086 |       0 |     1 |     0 |     0 |     0 |     1 |     0 |     1 |     0 |     0 |     0 |     0 |
|      2 |         20 |  00:00:00.094 |       1 |     0 |     1 |     0 |     0 |     1 |     0 |     0 |     1 |     0 |     0 |     1 |
|      3 |         50 |  00:00:00.110 |       2 |     1 |     0 |     1 |     0 |     0 |     1 |     0 |     1 |     0 |     1 |     0 |
|      4 |        100 |  00:00:00.184 |       4 |     1 |     1 |     1 |     1 |     1 |     0 |     1 |     1 |     1 |     1 |     0 |
|      5 |        500 |  00:00:00.520 |      18 |     3 |     4 |     3 |     2 |     3 |     2 |     3 |     2 |     3 |     3 |     3 |
|      6 |      1 000 |  00:00:01.079 |      39 |     6 |     6 |     5 |     6 |     5 |     3 |     4 |     5 |     6 |     5 |     6 |
|      7 |      5 000 |  00:00:03.590 |     133 |    28 |    25 |    33 |    20 |    17 |    16 |    16 |    21 |    19 |    19 |    20 |
|      8 |     10 000 |  00:00:09.002 |     323 |    67 |    62 |    63 |    50 |    42 |    44 |    46 |    54 |    57 |    44 |    44 |
|      9 |     50 000 |  00:00:42.542 |    1654 |   328 |   277 |   269 |   285 |   233 |   213 |   201 |   197 |   202 |   193 |   198 |
|     10 |    100 000 |  00:01:28.332 |    3367 |   723 |   601 |   515 |   488 |   469 |   449 |   448 |   454 |   447 |   396 |   473 |
|     11 |    500 000 |  00:07:35.509 |   17509 |  3462 |  2927 |  2722 |  2457 |  2517 |  2242 |  2371 |  2355 |  2371 |  2289 |  2322 |
|     12 |  1 000 000 |  00:14:20.256 |   33272 |  7182 |  5699 |  4988 |  4595 |  4546 |  4407 |  4194 |  4018 |  4113 |  4462 |  4544 |
=========================================================================================================================================
                      | TOTAL time:   |   56322 | 11802 |  9573 |  8600 |  7904 |  7835 |  7377 |  7285 |  7109 |  7219 |  7413 |  7611 |
                      ===================================================================================================================
                                      |    100% |   21% |   17% | 15.3% |   14% | 13.9% | 13.1% | 12.9% | 12.6% | 12.8% | 13.2% | 13.5% |
                                      ===================================================================================================


