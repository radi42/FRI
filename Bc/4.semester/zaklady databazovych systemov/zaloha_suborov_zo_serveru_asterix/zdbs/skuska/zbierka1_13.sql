--zoznam ludi kt. si nekupili letenku v r.k 2014
select distinct meno,priezvisko 
from l_osoba 
join l_letenka using(cislo_dokladu,typ_dokladu) 
where datum_platby not in(
	select datum_platby 
	from l_letenka 
	where extract(year from datum_platby)=2014);

--alebo
select distinct meno, priezvisko
from l_osoba
join l_letenka using(cislo_dokladu, typ_dokladu)
where extract(year from l_letenka.datum_platby) <> 2014;


--polda mna, toto je spravne
select distinct meno, priezvisko
from l_osoba
where not exists(
	select 'x' from l_letenka
	where extract(year from datum_platby)= 2014
	and l_osoba.cislo_dokladu=l_letenka.cislo_dokladu
	and l_osoba.typ_dokladu=l_letenka.typ_dokladu);
