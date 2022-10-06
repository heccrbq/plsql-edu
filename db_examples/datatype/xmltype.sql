/**
 * разные варианты генерации xmltype
 */
 
 
 
 select xmltype(cursor(select * From dual)) xml from dual
 /
 
 
 select sys_xmlgen(sys.odcinumberlist(1,2,3)) xml from dual
 /
 
 
 
