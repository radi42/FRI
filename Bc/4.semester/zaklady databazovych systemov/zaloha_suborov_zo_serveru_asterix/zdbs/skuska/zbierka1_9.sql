--Vypíšte zoznam letov tohto mesiaca u ktorých nemáme ani jednu predanú letenku (nepocítajte z duplicitu)
select distinct id_letu, datum_letu
from l_let 
join l_letenka using(id_letu) 
where to_char(datum_letu,'MM-YYYY')=to_char(sysdate,'MM-YYYY')
and datum_platby not in (
	select datum_platby 
	from l_letenka 
	where datum_platby IS NOT NULL);





--Vypíšte zoznam letov tohto mesiaca u ktorých nemáme ani jednu predanú letenku (nepocítajte z duplicitu)
select distinct id_letu, datum_letu
from l_let
where to_char(datum_letu,'MM-YYYY')=to_char(sysdate,'MM-YYYY')
and id_letu not in(
	select id_letu from l_letenka
	where datum_platby IS NOT NULL);





--lety za dnesny mesiac, ku ktorym boli kupene letenky
select distinct id_letu, datum_platby, datum_letu
from l_letenka
join l_let using (id_letu)
where to_char(datum_letu,'MM-YYYY')=to_char(sysdate,'MM-YYYY')
and datum_platby is not NULL;

--vsetky lety za dnesny mesiac
select distinct id_letu, datum_letu
from l_let
where to_char(datum_letu,'MM-YYYY')=to_char(sysdate,'MM-YYYY');

--vsetky lety za dnesny mesiac - lety za dnesny mesiac, ku ktorym boli kupene letenky = lety za dnesny mesiac, ku ktorym neboli kupene letenky
select distinct id_letu, datum_letu
from l_let
where to_char(datum_letu,'MM-YYYY')=to_char(sysdate,'MM-YYYY')
and id_letu not in(
	select distinct id_letu
	from l_letenka
	join l_let using (id_letu)
	where to_char(datum_letu,'MM-YYYY')=to_char(sysdate,'MM-YYYY')
	and datum_platby is not NULL);






--alebo aj cez outer join
select distinct id_letu, count(datum_platby), datum_letu
from l_let
left  join l_letenka using(id_letu)
where to_char(datum_letu,'MM-YYYY')=to_char(sysdate,'MM-YYYY')
group by id_letu, datum_letu
having count(datum_platby)=0;