--Vypíšte všetky lety staršie ako rok do Talianska.
								--select id_letu,datum_letu from l_let join l_letisko on letisko_do=id_letiska join l_krajina using(id_krajiny)where nazov_krajiny='Taliansko' and datum_letu<add_months(sysdate,-12);

select id_letu, datum_letu, letisko_z, letisko_do, (sysdate - datum_letu)
from l_let
join l_letisko on l_let.letisko_do=l_letisko.id_letiska
join l_krajina using(id_krajiny)
where nazov_krajiny = 'Taliansko'
and (sysdate - datum_letu) >= 365;