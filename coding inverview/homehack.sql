-- Factorial
create or replace function f (p number) return number
is
begin
    if p < 0 then
        raise_application_error(-20162, 'Факториал можно вычислить только у натуральных чисел и нуля.', true);
    elsif p = 0 then
        return 1;
    else
        return p * f(p-1);
    end if;
end f;
/
