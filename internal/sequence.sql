-- как устроен сиквенс

drop sequence dropme_seq;
create sequence dropme_seq nocache;


alter session set tracefile_identifier = "dvb241022_1549";
select 
    file#,
    adr_home,
    trace_filename
from (
    select instance || '_ora_' ||
        ltrim(to_char(a.spid,'fm9999999999')) || '_' || a.traceid || '.trc' file#
    from v$process a, v$session b, v$parameter c, v$thread c
    where a.addr = b.paddr
        and b.audsid = userenv('sessionid')
--		and b.sid = 1053
        and c.name = 'user_dump_dest') t
    left join v$diag_trace_file d on d.trace_filename = t.file#;
    
    
alter session set events '10046 trace name context forever, level 12';
declare
    l_nextval number;
begin
    for i in 1.. 3
    loop
        select dropme_seq.nextval into l_nextval from dual;
    end loop;
end;
/
alter session set events '10046 trace name context off';


select 
    dbms_xmlgen.convert(xmlagg(xmlelement(r, payload)).extract('//text()').getclobval(),1)
from v$diag_trace_file_contents 
where trace_filename = 'rtwr_ora_42533162_dvb241022_1549.trc';




=====================
PARSING IN CURSOR #4852512888 len=143 dep=0 uid=64 oct=47 lid=64 tim=105928468827886 hv=1804881091 ad='700010007b7d050' sqlid='bmqfc35pt8m63'
declare
    l_nextval number;
begin
    for i in 1.. 3
    loop
        select dropme_seq.nextval into l_nextval from dual;
    end loop;
end;

END OF STMT
PARSE #4852512888:c=1751,e=3655,p=0,cr=0,cu=0,mis=1,r=0,dep=0,og=1,plh=0,tim=105928468827884
=====================
PARSING IN CURSOR #4854949616 len=35 dep=1 uid=64 oct=3 lid=64 tim=105928468829874 hv=1243842755 ad='7000100076eab20' sqlid='dhwvh6j527263'
SELECT DROPME_SEQ.NEXTVAL FROM DUAL
END OF STMT
PARSE #4854949616:c=734,e=1640,p=0,cr=0,cu=0,mis=1,r=0,dep=1,og=1,plh=1500558287,tim=105928468829873
EXEC #4854949616:c=25,e=77,p=0,cr=0,cu=0,mis=0,r=0,dep=1,og=1,plh=1500558287,tim=105928468830168
=====================
PARSING IN CURSOR #4878694832 len=129 dep=2 uid=0 oct=6 lid=0 tim=105928468830438 hv=2635489469 ad='7000100135e6340' sqlid='4m7m0t6fjcs5x'
update seq$ set increment$=:2,minvalue=:3,maxvalue=:4,cycle#=:5,order$=:6,cache=:7,highwater=:8,audit$=:9,flags=:10 where obj#=:1
END OF STMT
PARSE #4878694832:c=34,e=101,p=0,cr=0,cu=0,mis=0,r=0,dep=2,og=4,plh=89955185,tim=105928468830437
BINDS #4878694832:

 ...
 
WAIT #4878694832: nam='Disk file operations I/O' ela= 105 FileOperation=2 fileno=3 filetype=2 obj#=-1 tim=105928468832155
EXEC #4878694832:c=643,e=1763,p=0,cr=2,cu=3,mis=0,r=1,dep=2,og=4,plh=89955185,tim=105928468832384
STAT #4878694832 id=1 cnt=0 pid=0 pos=1 obj=0 op='UPDATE  SEQ$ (cr=2 pr=0 pw=0 str=1 time=471 us)'
STAT #4878694832 id=2 cnt=1 pid=1 pos=1 obj=79 op='INDEX UNIQUE SCAN I_SEQ1 (cr=2 pr=0 pw=0 str=1 time=21 us cost=1 size=63 card=1)'
CLOSE #4878694832:c=1,e=3,dep=2,type=3,tim=105928468832795
FETCH #4854949616:c=981,e=2737,p=0,cr=2,cu=4,mis=0,r=1,dep=1,og=1,plh=1500558287,tim=105928468832962
STAT #4854949616 id=1 cnt=1 pid=0 pos=1 obj=41794794 op='SEQUENCE  DROPME_SEQ (cr=2 pr=0 pw=0 str=1 time=2747 us)'
STAT #4854949616 id=2 cnt=1 pid=1 pos=1 obj=0 op='FAST DUAL  (cr=0 pr=0 pw=0 str=1 time=3 us cost=2 size=0 card=1)'
CLOSE #4854949616:c=1,e=2,dep=1,type=3,tim=105928468833317
EXEC #4854949616:c=12,e=34,p=0,cr=0,cu=0,mis=0,r=0,dep=1,og=1,plh=1500558287,tim=105928468833401
BINDS #4878694832:

 ...
 
EXEC #4878694832:c=506,e=1838,p=0,cr=2,cu=2,mis=0,r=1,dep=2,og=4,plh=89955185,tim=105928468835348
CLOSE #4878694832:c=1,e=6,dep=2,type=3,tim=105928468835496
FETCH #4854949616:c=583,e=2237,p=0,cr=2,cu=3,mis=0,r=1,dep=1,og=1,plh=1500558287,tim=105928468835676
CLOSE #4854949616:c=0,e=2,dep=1,type=3,tim=105928468835782
EXEC #4854949616:c=7,e=52,p=0,cr=0,cu=0,mis=0,r=0,dep=1,og=1,plh=1500558287,tim=105928468835947
BINDS #4878694832:

 ...
 
EXEC #4878694832:c=378,e=1570,p=0,cr=2,cu=2,mis=0,r=1,dep=2,og=4,plh=89955185,tim=105928468837664
CLOSE #4878694832:c=1,e=3,dep=2,type=3,tim=105928468837771
FETCH #4854949616:c=434,e=1899,p=0,cr=2,cu=3,mis=0,r=1,dep=1,og=1,plh=1500558287,tim=105928468837896
CLOSE #4854949616:c=0,e=2,dep=1,type=3,tim=105928468837988
EXEC #4852512888:c=3193,e=9941,p=0,cr=6,cu=10,mis=0,r=1,dep=0,og=1,plh=0,tim=105928468838037
WAIT #4852512888: nam='log file sync' ela= 986 buffer#=126992 sync scn=1104899636853 p3=0 obj#=-1 tim=105928468839083
WAIT #4852512888: nam='SQL*Net message to client' ela= 3 driver id=675562835 #bytes=1 p3=0 obj#=-1 tim=105928468839160

*** 2022-11-24T18:08:38.247276+05:00
WAIT #4852512888: nam='SQL*Net message from client' ela= 3112993 driver id=675562835 #bytes=1 p3=0 obj#=-1 tim=105928471952213
CLOSE #4852512888:c=16,e=27,dep=0,type=0,tim=105928471952409
=====================
PARSING IN CURSOR #4852512888 len=55 dep=0 uid=64 oct=42 lid=64 tim=105928471952644 hv=2217940283 ad='0' sqlid='06nvwn223659v'
alter session set events '10046 trace name context off'
END OF STMT
PARSE #4852512888:c=95,e=156,p=0,cr=0,cu=0,mis=0,r=0,dep=0,og=0,plh=0,tim=105928471952643
EXEC #4852512888:c=356,e=741,p=0,cr=0,cu=0,mis=0,r=0,dep=0,og=0,plh=0,tim=105928471953520





********************************************************************************

declare
    l_nextval number;
begin
    for i in 1.. 3
    loop
        select dropme_seq.nextval into l_nextval from dual;
    end loop;
end;

call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           1
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        2      0.00       0.00          0          0          0           1

Misses in library cache during parse: 1
Optimizer mode: ALL_ROWS
Parsing user id: 64  

Elapsed times include waiting on following events:
  Event waited on                             Times   Max. Wait  Total Waited
  ----------------------------------------   Waited  ----------  ------------
  log file sync                                   1        0.00          0.00
  SQL*Net message to client                       1        0.00          0.00
  SQL*Net message from client                     1        3.11          3.11
********************************************************************************

SQL ID: dhwvh6j527263 Plan Hash: 1500558287

SELECT DROPME_SEQ.NEXTVAL 
FROM
 DUAL


call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      3      0.00       0.00          0          0          0           0
Fetch        3      0.00       0.00          0          0          3           3
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        7      0.00       0.00          0          0          3           3

Misses in library cache during parse: 1
Optimizer mode: ALL_ROWS
Parsing user id: 64     (recursive depth: 1)
Number of plan statistics captured: 1

Rows (1st) Rows (avg) Rows (max)  Row Source Operation
---------- ---------- ----------  ---------------------------------------------------
         1          1          1  SEQUENCE  DROPME_SEQ (cr=2 pr=0 pw=0 time=1 us)
         1          1          1   FAST DUAL  (cr=0 pr=0 pw=0 time=1 us cost=2 size=0 card=1)

********************************************************************************

SQL ID: 4m7m0t6fjcs5x Plan Hash: 89955185

update seq$ set increment$=:2,minvalue=:3,maxvalue=:4,cycle#=:5,order$=:6,
  cache=:7,highwater=:8,audit$=:9,flags=:10 
where
 obj#=:1


call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      3      0.00       0.00          0          6          7           3
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.00       0.00          0          6          7           3

Misses in library cache during parse: 0
Optimizer mode: CHOOSE
Parsing user id: SYS   (recursive depth: 2)
Number of plan statistics captured: 1

Rows (1st) Rows (avg) Rows (max)  Row Source Operation
---------- ---------- ----------  ---------------------------------------------------
         0          0          0  UPDATE  SEQ$ (cr=2 pr=0 pw=0 time=1 us)
         1          1          1   INDEX UNIQUE SCAN I_SEQ1 (cr=2 pr=0 pw=0 time=1 us cost=1 size=63 card=1)(object id 79)


Elapsed times include waiting on following events:
  Event waited on                             Times   Max. Wait  Total Waited
  ----------------------------------------   Waited  ----------  ------------
  Disk file operations I/O                        1        0.00          0.00
********************************************************************************
