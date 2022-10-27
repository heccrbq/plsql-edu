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
