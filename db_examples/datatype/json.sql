/**
 * How to store JSON data
 */

drop table dropme purge;

create table dropme (
    json_col clob, --varchar2(4000),
    constraint dropme_check_json check(json_col is json))
/


