--Vypiste nazvy leteckych spolocnosti ktore lietaju do Spanielska.
Select distinct id_spolocnosti,nazov_spol 
from l_let 
join l_let_spolocnost using(id_spolocnosti) 
join l_krajina using(id_krajiny) 
join l_letisko on letisko_do=id_letiska 
where nazov_krajiny='Spanielsko';

--alebo
select distinct id_spolocnosti, nazov_spol
from l_let_spolocnost
join l_let using(id_spolocnosti)
join l_krajina using(id_krajiny)
join l_letisko on letisko_z=id_letiska
where nazov_krajiny = 'Spanielsko';



/*
--vypis vsetky spanielske letiska
select nazov_letiska
from l_letisko
join l_krajina using(id_krajiny)
where nazov_krajiny = 'Spanielsko';



select * from l_letisko
where id_krajiny IN (
	select id_krajiny from l_krajina where nazov_krajiny = 'Spanielsko');
*/