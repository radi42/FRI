--Vypíš všetky lety ktoré vcera odleteli zo Ziliny, pricom lietadlo patrilo spolocnosti Ryanair
/*
select nazov_spol,letisko_z,datum_letu 
from l_let join l_let_spolocnost using(id_spolocnosti) 
join l_letisko on letisko_z=id_letiska 
where nazov_letiska='Zilina' and datum_letu=to_date('26.05.2015','DD.MM.YYYY')
and nazov_spol='Ryanair';
*/


select nazov_spol, nazov_letiska, datum_letu
from l_let
join l_let_spolocnost using(id_spolocnosti)
join l_letisko on letisko_z = id_letiska
where nazov_letiska = 'Zilina'
and nazov_spol = 'Ryanair'
and datum_letu=to_date('26.05.2015','DD-MM-YYYY');









--Vypíš všetky lety ktoré vcera odleteli zo Ziliny, pricom lietadlo patrilo spolocnosti Ryanair
select id_letu, datum_letu, letisko_z, letisko_do, nazov_spol
from l_let
join l_letisko on letisko_z=id_letiska
join l_mesto using(psc,id_krajiny)
join l_let_spolocnost using(id_spolocnosti)
where nazov='Zilina'
and datum_letu=to_date('26.05.2015','DD-MM-YYYY')
and id_lietadla IN (
	select id_lietadla from l_lietadlo
	join l_let_spolocnost using(id_spolocnosti)
	where nazov_spol = 'Ryanair');




















