--vypiste aktualnych zamestnancov spol. Ryanair
select distinct meno,priezvisko, nazov_spol, pozicia, datum_zrusenia
from l_osoba 
join l_zamestnanec using(cislo_dokladu,typ_dokladu) 
join l_let_spolocnost using(id_spolocnosti)
where nazov_spol='Ryanair' 
and (datum_zrusenia is null or datum_zrusenia >= sysdate);
