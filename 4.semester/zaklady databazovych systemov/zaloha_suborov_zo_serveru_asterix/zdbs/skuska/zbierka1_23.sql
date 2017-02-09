-- Uloha 1 - select kolko minuli osoby s priezviskom Mravec na letenky v roku 2014
select meno, priezvisko, datum_platby, cena
from l_osoba
join l_letenka using(cislo_dokladu, typ_dokladu)
join l_let using(id_letu)
where priezvisko = 'Mravec'
and extract(year from datum_platby) = 2014;


select priezvisko, sum(cena)
from l_osoba
join l_letenka using(cislo_dokladu, typ_dokladu)
where priezvisko = 'Mravec'
and extract(year from datum_platby) = 2014
group by priezvisko;