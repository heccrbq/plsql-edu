---------------------------------------------------------------------------------------------------
| Id  | Operation        | Name        | Starts | E-Rows | A-Rows |   A-Time   | Buffers | Reads  |
---------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT |             |      1 |        |      1 |00:00:02.27 |   21079 |    761 |
|   1 |  SORT AGGREGATE  |             |      1 |      1 |      1 |00:00:02.27 |   21079 |    761 |
|   2 |   INDEX FULL SCAN| PK_DROPME   |      1 |     10M|     10M|00:00:02.21 |   21079 |    761 |
---------------------------------------------------------------------------------------------------



---------------------------------------------------------------------------------------------------------------
| Id  | Operation                      | Name      | Starts | E-Rows | A-Rows |   A-Time   | Buffers | Reads  |
---------------------------------------------------------------------------------------------------------------
...
|   3 |    NESTED LOOPS                |           |      1 |  60682 |  60682 |00:00:00.57 |     176K|      0 |
|   4 |     TABLE ACCESS FULL          | TTESTTBL  |      1 |  60682 |  60682 |00:00:00.01 |     249 |      0 |
|   5 |     TABLE ACCESS BY INDEX ROWID| DROPME    |  60682 |      1 |  60682 |00:00:00.47 |     176K|      0 |
|*  6 |      INDEX UNIQUE SCAN         | PK_DROPME |  60682 |      1 |  60682 |00:00:00.28 |     115K|      0 |
...
---------------------------------------------------------------------------------------------------------------

Predicate Information (identified by operation id):
--------------------------------------------------- 
   6 - access("T"."FLG"=1 AND "T"."NO"="U"."NO")
   
   
   
   
-------------------------------------------------------------------------------------------------------------
| Id  | Operation                    | Name      | Starts | E-Rows | A-Rows |   A-Time   | Buffers | Reads  |
-------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT             |           |      1 |        |  60682 |00:00:02.62 |     176K|   3684 |
|   1 |  NESTED LOOPS                |           |      1 |        |  60682 |00:00:02.62 |     176K|   3684 |
|   2 |   NESTED LOOPS               |           |      1 |  60682 |  60682 |00:00:00.26 |     115K|      0 |
|   3 |    TABLE ACCESS FULL         | TTESTTBL  |      1 |  60682 |  60682 |00:00:00.01 |     249 |      0 |
|*  4 |    INDEX UNIQUE SCAN         | PK_DROPME |  60682 |      1 |  60682 |00:00:00.23 |     115K|      0 |
|   5 |   TABLE ACCESS BY INDEX ROWID| DROPME    |  60682 |      1 |  60682 |00:00:02.96 |   61025 |   3684 |
-------------------------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   4 - access("T"."FLG"=1 AND "T"."NO"="U"."NO")
   
Outline Data
-------------
 
  /*+
      NLJ_BATCHING(@"SEL$1" "T"@"SEL$1")
  */
