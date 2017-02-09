--Vypíšte názvy leteckých spolocných, ktoré lietajú do mesta Rím
select distinct nazov_spol 
from l_let 
join l_letisko on letisko_do=id_letiska 
join l_mesto using(id_krajiny) 
join l_let_spolocnost using(id_spolocnosti)
where nazov='Rim';


/*
--Vypíšte názvy leteckých spolocnosti, ktoré lietajú do mesta Rím
select distinct nazov_spol
from l_let
join l_letisko on letisko_z=id_letiska
join l_mesto using(id_krajiny)
join l_let_spolocnost using(id_spolocnosti)
where nazov = 'Rome';
*/

/*
--alternativne riesenie - joinovanie tabuliek pekne po poradi
select distinct nazov_spol
from l_let_spolocnost
join l_let using(id_spolocnosti)
join l_letisko on letisko_do=id_letiska
join l_mesto on l_mesto.id_krajiny=l_letisko.id_krajiny
where nazov = 'Rome';
*/

/*
--alebo joinovanie tabuliek pekne po poradi s uplnou kontrolou referencnej integrity
select distinct nazov_spol
from l_let_spolocnost
join l_let on l_let.id_spolocnosti=l_let_spolocnost.id_spolocnosti
join l_letisko on letisko_z=id_letiska
join l_mesto on l_mesto.id_krajiny=l_letisko.id_krajiny and l_mesto.psc=l_letisko.psc
where nazov='Rome';
*/