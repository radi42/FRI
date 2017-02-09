--Vypiste menny zoznam osob ktore si nekupili ani jednu letenku minuly rok (nepocitajte zo zrusenymi letenkami).
Select distinct meno,priezvisko 
from l_osoba 
join l_letenka using(cislo_dokladu,typ_dokladu) 
where datum_platby not in (
    select datum_platby 
    from l_letenka 
    where extract(year from datum_platby)=extract(year from sysdate)-1);



--Vypiste menny zoznam osob ktore si nekupili ani jednu letenku minuly rok (nepocitajte zo zrusenymi letenkami).
select distinct meno, priezvisko
from l_osoba
where not exists(
	select 'x' from l_letenka
	where extract(year from datum_platby) = extract(year from sysdate)-1
	and l_letenka.cislo_dokladu = l_osoba.cislo_dokladu
	and l_letenka.typ_dokladu = l_osoba.typ_dokladu);

--Pre kontrolu - vypis, kolko leteniek si kupili jednotlive osoby v minulom roku
select meno, priezvisko, count(*) 
from l_osoba join l_letenka 
using(cislo_dokladu,typ_dokladu) 
where extract(year from datum_platby) = extract(year from sysdate)-1
group by(meno,priezvisko);







--Vypiste menny zoznam osob ktore si nekupili ani jednu letenku minuly rok (nepocitajte zo zrusenymi letenkami).
--abecedne usporiadane
select meno, priezvisko
from l_osoba
where not exists(
	select 'x' from l_letenka
	where extract(year from datum_platby) = extract(year from sysdate)-1
	and l_letenka.cislo_dokladu = l_osoba.cislo_dokladu
	and l_letenka.typ_dokladu = l_osoba.typ_dokladu)
order by meno, priezvisko;