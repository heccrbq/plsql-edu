declare
    l_cur integer;
    l_sql varchar2(4000) := 'select dummy, level from dual connect by level <= :1';
    l_rowcount integer;
    -- define columns
    l_colcount integer;
    l_collist  dbms_sql.desc_tab;
    l_numval   number;
    l_var2val  varchar2(50);
begin
    l_cur := dbms_sql.open_cursor;
    dbms_sql.parse(l_cur, l_sql, dbms_sql.native);
    
    dbms_sql.describe_columns(l_cur, l_colcount, l_collist);
--    for i in 1.. l_colcount
--    loop
--        if l_collist(i).col_type = 1 then
--            dbms_sql.define_column(l_cur, i, l_var2val);
--        elsif l_collist(i).col_type = 2 then
--            dbms_sql.define_column(l_cur, i, l_numval);
--        else
--            dbms_sql.define_column(l_cur, i, l_var2val);
--        end if;
--    end loop;
    
    dbms_sql.bind_variable(l_cur, ':1', 10);
    l_rowcount := dbms_sql.execute(l_cur);
    
    while dbms_sql.fetch_rows(l_cur) > 0
    loop
        for i in 1.. l_colcount
        loop
            if l_collist(i).col_type = 1 then
                dbms_sql.column_value(l_cur, i, l_var2val);
            elsif l_collist(i).col_type = 2 then
                dbms_sql.column_value(l_cur, i, l_numval);
            end if;
            
            dbms_output.put_line('column_1: ' || l_var2val || ', columns_2: ' || l_numval);
        end loop;
    end loop;
    
    dbms_sql.close_cursor(l_cur);
exception
    when others then
        dbms_sql.close_cursor(l_cur);
end;
/

/*

PUBLIC.USER_TAB_COLUMNS
    SYS.USER_TAB_COLUMNS
        SYS.USER_TAB_COLS
            SYS.USER_TAB_COLS_V$:
            
                  1 : NVARCHAR2 | VARCHAR2
                  2 : NUMBER | FLOAT
                  8 : LONG
                  9 : NCHAR VARYING | VARCHAR
                 12 : DATE
                 23 : RAW 
                 24 : LONG RAW
                 58 : ???
                 69 : ROWID
                 96 : NCHAR | CHAR
                100 : BINARY_FLOAT
                101 : BINARY_DOUBLE
                105 : MLSLABEL
                106 : MLSLABEL
                111, ???
                112 : NCLOB | CLOB
                113 : BLOB
                114 : BFILE 
                115 : CFILE
                121, ???
                122, nvl2(ac.synobj#, (select o.name from obj$ o
                                         where o.obj#=ac.synobj#), ot.name),
                123, nvl2(ac.synobj#, (select o.name from obj$ o
                                         where o.obj#=ac.synobj#), ot.name),
                178 : TIME
                179 : TIME WITH TIME ZONE
                180 : TIMESTAMP
                181 : TIMESTAMP WITH TIME ZONE
                231 : TIMESTAMP WITH LOCAL TIME ZONE
                182 : INTERVAL YEAR TO MONTH
                183 : INTERVAL DAY TO SECOND
                208 : UROWID

*/
