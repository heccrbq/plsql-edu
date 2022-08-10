
-- вывести английский алфавит без использования union [all]
select chr(".") symbol from xmltable('65 to 90' columns "." number)
