/**
 * типы данных
 * функции приведения типов
 * null значение
 * состав rowid
 * --
 * RESOURCES:
 *   https://docs.oracle.com/database/121/SQLRF/sql_elements001.htm#SQLRF30020
 */



whenever sqlerror exit rollback
set timing on
set serveroutput on size unl

sho parameter recyclebin
sho parameter max_string_size

drop table dropme purge;

-- using data types
create table dropme (
	col1  number,
	col2  integer,      -- number(38,0)
	col3  number(5,2),  -- float, binary_float etc.
	-- 
	col4  varchar2(50), -- in case of max_string_size = 'EXNTEDED' then varchar2(32767)
	col5  nvarchar2(10),
	col6  char(10),
	--
	col7  date,
	col8  timestamp,
	col9  timestamp with time zone,
	col10 interval day to second,
	--
	col11 long,              -- deprecated
	col12 raw(32),
	col13 rowid,
	col14 clob,
	col15 blob,
	col16 xmltype,
	col17 sys.odcinumberlist -- nested table
) pctfree 0;


-- functions to convert data types
insert into dropme
    select
        to_number('1' default null on conversion error),
        cast(1.2 as integer) as col2,
        cast(1.235 as number(5,2)) as col3,
        --
        to_char(100500, 'fm999G999D00') col4,
        'yYy' col5,
        cast('xXx' as char(10)) col6,
        --
        to_date('2022-01-01', 'yyyy-mm-dd') col7,
        to_timestamp('2022-01-01 01:22:33.45678', 'yyyy-mm-dd hh24:mi:ss.ff') col8,
        timestamp'2022-01-02 01:22:33.45678 UTC' col9,
        numtodsinterval(26, 'day') col10,
        utl_raw.cast_to_raw('xXx') col11,
        standard_hash('xXx','SHA1') col12,
        rowid col13,
        to_clob('xXx') col14,
        to_blob(utl_raw.cast_to_raw('xXx')) col15,
        xmltype(cursor(select * From dual)) col16,       
        sys.odcinumberlist(1,2,3) col17
    from dual;

commit;


-- comparison with null value
select * from dual where dummy in ('X', null);
select * from dual where dummy not in ('X', null);
select * from dual where null = null;
select * from dual where null is null;
select * from dual where 'X' <> null;
select * from dual where lnnvl('X' <> null);


-- rowid consists of: 
--                    ACcKnZ-AGW-AAAPg3-AAA
--                      |     |    |     |
--          -------------     |    |     -------
--          |                 |    |           |
--         data        relative    block      row
--         object      file        number     number
--         number      number
select 
    rowid,
    dbms_rowid.rowid_object(rowid) object_id,
    dbms_rowid.rowid_relative_fno(rowid) file_id,
    dbms_rowid.rowid_block_number(rowid) block_id,
    dbms_rowid.rowid_row_number(rowid) row_id 
from dropme;
