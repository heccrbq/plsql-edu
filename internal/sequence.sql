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
select dropme_seq.nextval from dual;
alter session set events '10046 trace name context off';


select 
    dbms_xmlgen.convert(xmlagg(xmlelement(r, payload)).extract('//text()').getclobval(),1)
from v$diag_trace_file_contents 
where trace_filename = 'rtwr_ora_42533162_dvb241022_1549.trc';




=====================
PARSING IN CURSOR #4852308464 len=35 dep=0 uid=64 oct=3 lid=64 tim=105926871343067 hv=978141032 ad='70001000331b630' sqlid='83bh9d0x4ugv8'
select dropme_seq.nextval from dual
END OF STMT
PARSE #4852308464:c=847,e=1786,p=0,cr=0,cu=0,mis=1,r=0,dep=0,og=1,plh=1500558287,tim=105926871343066
EXEC #4852308464:c=37,e=79,p=0,cr=0,cu=0,mis=0,r=0,dep=0,og=1,plh=1500558287,tim=105926871343311
WAIT #4852308464: nam='SQL*Net message to client' ela= 4 driver id=675562835 #bytes=1 p3=0 obj#=543458 tim=105926871343395
=====================
PARSING IN CURSOR #4852721760 len=129 dep=1 uid=0 oct=6 lid=0 tim=105926871344730 hv=2635489469 ad='7000100135e6340' sqlid='4m7m0t6fjcs5x'
update seq$ set increment$=:2,minvalue=:3,maxvalue=:4,cycle#=:5,order$=:6,cache=:7,highwater=:8,audit$=:9,flags=:10 where obj#=:1
END OF STMT

PARSE #4852721760:c=349,e=1164,p=0,cr=0,cu=0,mis=1,r=0,dep=1,og=4,plh=0,tim=105926871344728
EXEC #4852721760:c=1278,e=5678,p=0,cr=2,cu=2,mis=1,r=1,dep=1,og=4,plh=89955185,tim=105926871350730
STAT #4852721760 id=1 cnt=0 pid=0 pos=1 obj=0 op='UPDATE  SEQ$ (cr=2 pr=0 pw=0 str=1 time=399 us)'
STAT #4852721760 id=2 cnt=1 pid=1 pos=1 obj=79 op='INDEX UNIQUE SCAN I_SEQ1 (cr=2 pr=0 pw=0 str=1 time=60 us cost=1 size=63 card=1)'
CLOSE #4852721760:c=1,e=4,dep=1,type=3,tim=105926871351894

FETCH #4852308464:c=1944,e=8780,p=0,cr=2,cu=3,mis=0,r=1,dep=0,og=1,plh=1500558287,tim=105926871352237
STAT #4852308464 id=1 cnt=1 pid=0 pos=1 obj=41794793 op='SEQUENCE  DROPME_SEQ (cr=2 pr=0 pw=0 str=1 time=8786 us)'
STAT #4852308464 id=2 cnt=1 pid=1 pos=1 obj=0 op='FAST DUAL  (cr=0 pr=0 pw=0 str=1 time=6 us cost=2 size=0 card=1)'
WAIT #4852308464: nam='log file sync' ela= 2131 buffer#=10313 sync scn=1104889297781 p3=0 obj#=543458 tim=105926871354834
WAIT #4852308464: nam='SQL*Net message from client' ela= 877 driver id=675562835 #bytes=1 p3=0 obj#=543458 tim=105926871355966





********************************************************************************

SQL ID: 83bh9d0x4ugv8 Plan Hash: 1500558287

select dropme_seq.nextval 
from
 dual


call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        1      0.00       0.00          0          0          1           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        3      0.00       0.00          0          0          1           1

Misses in library cache during parse: 1
Optimizer mode: ALL_ROWS
Parsing user id: 64  
Number of plan statistics captured: 1

Rows (1st) Rows (avg) Rows (max)  Row Source Operation
---------- ---------- ----------  ---------------------------------------------------
         1          1          1  SEQUENCE  DROPME_SEQ (cr=2 pr=0 pw=0 time=1 us)
         1          1          1   FAST DUAL  (cr=0 pr=0 pw=0 time=1 us cost=2 size=0 card=1)


Elapsed times include waiting on following events:
  Event waited on                             Times   Max. Wait  Total Waited
  ----------------------------------------   Waited  ----------  ------------
  SQL*Net message to client                       1        0.00          0.00
  log file sync                                   1        0.00          0.00
  SQL*Net message from client                     1        0.00          0.00
********************************************************************************

SQL ID: 4m7m0t6fjcs5x Plan Hash: 89955185

update seq$ set increment$=:2,minvalue=:3,maxvalue=:4,cycle#=:5,order$=:6,
  cache=:7,highwater=:8,audit$=:9,flags=:10 
where
 obj#=:1


call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          2          2           1
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        2      0.00       0.00          0          2          2           1

Misses in library cache during parse: 1
Misses in library cache during execute: 1
Optimizer mode: CHOOSE
Parsing user id: SYS   (recursive depth: 1)
Number of plan statistics captured: 1

Rows (1st) Rows (avg) Rows (max)  Row Source Operation
---------- ---------- ----------  ---------------------------------------------------
         0          0          0  UPDATE  SEQ$ (cr=2 pr=0 pw=0 time=1 us)
         1          1          1   INDEX UNIQUE SCAN I_SEQ1 (cr=2 pr=0 pw=0 time=1 us cost=1 size=63 card=1)(object id 79)

********************************************************************************
