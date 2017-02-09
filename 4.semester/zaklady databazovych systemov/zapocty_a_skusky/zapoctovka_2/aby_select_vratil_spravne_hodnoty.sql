/*
myslim si, ze select ma vracat celkovy pocet letov pre kazdeho cestujuceho
*/

select meno, priezvisko, count(*)
from l_osoba join l_letenka using (cislo_dokladu, typ_dokladu)
 join l_let using(id_letu)
where to_char(datum_letu, 'YYYY') = '2015'
 and datum_zrusenia is null
group by cislo_dokladu, typ_dokladu, meno, priezvisko;