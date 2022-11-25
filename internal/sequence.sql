/**
 * RESOURCES:
 * https://orainternals.wordpress.com/tag/xkglob/
 * https://renenyffenegger.ch/notes/development/databases/Oracle/architecture/instance/fixed-tables/k/g/l/ob/index
 * https://www.red-gate.com/simple-talk/databases/oracle-databases/oracle-sequences-the-basics/
 */

select s.sequence_name, round(last_number / (sysdate - created))/24/60 freq_usage 
from user_objects o join user_sequences s on s.sequence_name = o.object_name 
where o.object_name = 'SEQ_UBRR_FSSP_PROTOCOL' and o.object_type = 'SEQUENCE';
--where cache_size = 0 
--order by 1 desc nulls last fetch first 50 row with ties;

select * From sys.obj$ where name = 'SEQ_UBRR_FSSP_PROTOCOL';
select * From sys.seq$ where obj# = 24980414;

select * from v$_sequences where sequence_name = 'DROPME_SEQ';
select * From user_sequences where sequence_name = 'DROPME_SEQ';


select dropme_seq.nextval From dual;
drop sequence dropme_seq;
create sequence dropme_seq;

sho parameter SEQUENCE_CACHE_ENTRIES;



SELECT inst_id                                 AS inst_id, 
       KGLNAOWN                                AS sequence_owner,
       KGLNAOBJ                                AS sequence_name,
       KGLOBT08                                AS object#,
       decode(bitand(KGLOBT00,1),0,'N','Y')    AS active_flag,
       decode(bitand(KGLOBT00,2),0,'N','Y')    AS replenish_flag,
       decode(bitand(KGLOBT00,16),0,'N','Y')   AS wrap_flag,
       KGLOBTN0                                AS nextvalue,
       KGLOBTN2                                AS min_value,
       KGLOBTN3                                AS max_value,
       KGLOBTN1                                AS increment_by,
       decode(bitand(KGLOBT09,1),0,'N','Y')    AS cycle_flag,
       decode(bitand(KGLOBT09,2),0,'N','Y')    AS order_flag,
       KGLOBTN4                                AS cache_size,
       KGLOBTN5                                AS highwater,
       decode(KGLOBT10,1,'Y','N')              AS background_instance_lock,
       decode(KGLOBT10,1,KGLOBT02,null)        AS instance_lock_flags
  FROM X$KGLOB 
 WHERE KGLOBTYP = 6 
   AND KGLOBT11 = 1;
   
   
   select * From v$lock where type = 'SQ';
   
   select * From v$wait_chains;
   select * From dict where table_name like '%EVENT%';
   select * From DBA_HIST_EVENT_NAME where event_name like '%enq: SQ%';
   select * From v$session_event where event = 'enq: SQ - contention';
   select * From v$session_wait where event = 'enq: SQ - contention';
   select * From v$session_blockers;


