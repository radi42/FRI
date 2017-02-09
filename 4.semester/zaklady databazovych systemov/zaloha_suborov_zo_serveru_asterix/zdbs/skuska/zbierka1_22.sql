--Zruste vsetky letenky dnesnych letov, ktore este neodleteli z mesta Londyn.
select id_letu, letisko_z, datum_letu
from l_let
join l_letisko on letisko_z = id_letiska
where datum_letu = to_date('26.05.2015','DD-MM-YYYY')
and nazov_letiska = 'Zilina';

delete from l_let
where datum_letu = to_date('26.05.2015','DD-MM-YYYY')
and letisko_z IN (select id_letiska from l_letisko
		join l_mesto using (psc, id_krajiny)
		where nazov='Zilina');