На входе есть строка с числами, разделенными пробелом (одним).
Нужно написать SQL запрос, который вернет все числа, которые встречаются в строке только один раз.
Т.е. для строки для строки
9 83 49 22 2 83 22 833
запрос должен вернуть (порядок чисел не важен)
9
49
2
833
Предпочтительным считается вариант без использования регулярных выражений.

with t as (
    select ' ' || trim(column_value) || ' ' string, 
        length(translate(column_value, '#0123456789','#')) + 1 space_count 
    from table(sys.odcivarchar2list('9 83 49 22 2 83 22 833'))
)

select result
from (
    select substr(string, instr(string, ' ', 1, level)+1, instr(string, ' ', 1, level+1) - instr(string, ' ', 1, level) - 1) result 
    from t connect by level <= space_count
)
group by result
having count(1) = 1






Нужно реализовать функцию OneEditApart, проверяющую, можно ли одну строку получить из другой не более, чем за одно исправление
(удаление, добавление, изменение символа):

OneEditApart("cat", "dog") -> false 
OneEditApart("cat", "cats") -> true 
OneEditApart("cat", "cut") -> true 
OneEditApart("cat", "cuts") -> true 
OneEditApart("cat", "cast") -> true 
OneEditApart("cat", "at") -> true 
OneEditApart("cat", "acts") -> false 


create or replace function OneEditApart(p_string1 in varchar2, p_string_2 in varchar2) return boolean
is
    l_length number;
    l_length_str1 number;
    l_length_str2 number;
    l_flag number := 0;
    l_index_str1 number := 1;
    l_index_str2 number := 1;
begin
    if p_string1 is null or p_string2 is null then
        return false;
    end if;

    l_length_str1 := length(p_string1);
    l_length_str2 := length(p_string2);

    if abs(l_length_str1 - l_length_str2) > 1 then
        return false;
    end if;

    loop
        exit when l_index_str1 > l_length_str1 and l_index_str2 > l_length_str2;

        if nvl(substr(p_string1, l_index_str1, 1), '$') <> nvl(substr(p_string2, l_index_str2, 1), '$') then
            if l_length_str2 > l_length_str1 then
                l_index_str2 := l_index_str2 + 1;
            elsif l_length_str1 > l_length_str2
                l_index_str1 := l_index_str1 + 1;
            else 
                l_index_str1 := l_index_str1 + 1;                
                l_index_str2 := l_index_str2 + 1;
            end if;

            if l_flag = 0 then
                l_flag := 1;
            else
                return false;
            end if;
        else
            l_index_str1 := l_index_str1 + 1;                
            l_index_str2 := l_index_str2 + 1;
        end if;
    end loop;

    return true;

end OneEditApart;
/
