-- Uloha 2 - select lety buduci mesiac zo slovenska do talianska
select id_letu, letisko_z, letisko_do, datum_letu
from l_let
where letisko_z IN (
	select id_letiska from l_letisko where id_krajiny = (
		select id_krajiny from l_krajina where nazov_krajiny = 'Slovensko'))
and letisko_do IN (
	select id_letiska from l_letisko where id_krajiny = (
		select id_krajiny from l_krajina where nazov_krajiny = 'Taliansko'))
and to_char(datum_letu,'MM-YYYY') = to_char(add_months(sysdate,1),'MM-YYYY');


/*
select id_letiska 
from l_letisko 
where id_krajiny IN (
select id_krajiny from l_krajina where nazov_krajiny = 'Slovensko');
*/

--skratena verzia
select id_letu, letisko_z, letisko_do, datum_letu
from l_let
where letisko_z IN (
	select id_letiska from l_letisko where id_krajiny = 'SK')
and letisko_do IN (
	select id_letiska from l_letisko where id_krajiny = 'IT')
and to_char(datum_letu,'MM-YYYY') = to_char(add_months(sysdate,1),'MM-YYYY');