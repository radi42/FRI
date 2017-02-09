--Vypíšte všetky lety minulého mesiaca ku ktorým sa nepredala žiadna letenka(neberte do úvahy datum_zrusenie).
select distinct id_letu, datum_letu, datum_platby
from l_let
join l_letenka using(id_letu)
where to_char(datum_letu,'MM-YYYY')=to_char(add_months(sysdate,-1),'MM-YYYY')
and datum_platby not in(
	select datum_platby from l_letenka
	where datum_platby is not null
	and to_char(datum_platby,'MM-YYYY')=to_char(add_months(sysdate,-1),'MM-YYYY'));




/*
select distinct id_letu, datum_letu, datum_platby
from l_let
join l_letenka using(id_letu)
where datum_platby is not null;
*/


--vsetky lety minuleho mesiaca
select distinct id_letu, datum_letu from l_let
where to_char(datum_letu,'MM-YYYY')=to_char(add_months(sysdate,-1),'MM-YYYY');

--vsetky lety minuleho mesiaca, ku ktorym sa predala letenka
select distinct id_letu 
from l_letenka
where datum_platby IS NOT NULL;

--vsetky lety minuleho mesiaca, ku ktorym sa nepredali letenky
select distinct id_letu, datum_letu, datum_platby from l_let
where to_char(datum_letu,'MM-YYYY')=to_char(add_months(sysdate,-1),'MM-YYYY')
and not exists(
	select 'x'
	from l_letenka
	where datum_platby IS NOT NULL
	and l_letenka.id_letu=l_let.id_letu);






--vsetky lety minuleho mesiaca, ku ktorym sa nepredali letenky
select distinct id_letu, datum_letu, datum_platby 
from l_let
left join l_letenka using(id_letu)
where to_char(datum_letu,'MM-YYYY')=to_char(add_months(sysdate,-1),'MM-YYYY')
and datum_platby IS null;


select distinct id_letu, datum_letu, datum_platby
from l_let
left join l_letenka using(id_letu)
where (datum_platby is null
and to_char(datum_letu,'MM-YYYY')=to_char(add_months(sysdate,-1),'MM-YYYY'));
