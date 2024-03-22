-- Интервьюев утрверждал, что каждая сессия по новой обращается в сиквенс, создавая тем самым cache для себя и если 2 разне сессии буду пользоватьс одним и тем же сиквенсом, то могут быть непоследовательные вставки. То есть использование одного сиквенса в разных сессиях якобы не гарантирует последовательный рост вставляемых значений.
-- Тест ниже показывает, что все, что написано выше - неправда. Сиквенс является объектом глобальным (ЕСЛИ ЯВНО НЕ УКАЗАНО SESSION) и никаких кэшей для сессии не создается. Более того официальная документация говорит, что сиквенс хранится в SGA.

drop table dropme;
create table dropme(id number, source varchar2(50), datetime timestamp);

drop sequence dropme_sq;
create sequence dropme_sq cache 20;
--create sequence dropme_sq cache 20 session;


truncate table dropme;
col source for a13
select * from dropme order by datetime ;

-- Как видно из результатов заполнения таблицы номер сиквенса генерируется последовательно и никаких перескоков нет. 
-- Потому как 20 значений кэша были сразу выделены в SGA и последовательно выдавались сессиям.

        ID SOURCE        DATETIME                     
---------- ------------- -----------------------------
        42 SESSION #1    22.03.2024 14:10:57,066303000
        43 SESSION #2    22.03.2024 14:10:59,593669000
        44 SESSION #1    22.03.2024 14:11:00,071052000
        45 SESSION #2    22.03.2024 14:11:00,594300000
        46 SESSION #2    22.03.2024 14:11:01,596589000
        47 SESSION #2    22.03.2024 14:11:02,600938000
        48 SESSION #1    22.03.2024 14:11:03,071833000
        49 SESSION #2    22.03.2024 14:11:03,601392000
        50 SESSION #2    22.03.2024 14:11:04,601460000
        51 SESSION #2    22.03.2024 14:11:05,601216000
        52 SESSION #1    22.03.2024 14:11:06,073677000
        53 SESSION #2    22.03.2024 14:11:06,601271000
        54 SESSION #2    22.03.2024 14:11:07,601442000
        55 SESSION #2    22.03.2024 14:11:08,613478000
        56 SESSION #1    22.03.2024 14:11:09,081508000
        57 SESSION #1    22.03.2024 14:11:12,081676000
        58 SESSION #1    22.03.2024 14:11:15,086406000
        59 SESSION #1    22.03.2024 14:11:18,087036000
        60 SESSION #1    22.03.2024 14:11:21,093400000
        61 SESSION #1    22.03.2024 14:11:24,093631000
        
        
        
-- SESSION 1:
begin
    for i in 1..10
    loop
        insert into dropme(id, source, datetime) values(dropme_sq.nextval, 'SESSION #1', systimestamp);
        dbms_lock.sleep(3);
    end loop;
    commit;
end;
/

-- SESSION 2:
begin
    for i in 1..10
    loop
        insert into dropme(id, source, datetime) values(dropme_sq.nextval, 'SESSION #2', systimestamp);
        dbms_lock.sleep(1);
    end loop;
    commit;
end;
/

-- OFFICIAL DOCS:
The CACHE option pre-allocates and stores 500 sequence numbers in the instance's SGA for fast access. When those sequence numbers are used up, Oracle pre-allocates another group of sequence numbers. The CACHE option should be set to a value so that sequence requests for one to two seconds during the peak period can be satisfied if memory is critical for performance (see Oracle 11g SQL Reference and Oracle 11g Real Application Cluster (RAC) Administration.)
