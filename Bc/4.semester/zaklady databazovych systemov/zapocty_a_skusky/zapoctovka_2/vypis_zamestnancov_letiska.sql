select id_zamestnanca, meno, priezvisko, datum_zrusenia
from l_zamestnanec join l_osoba using(cislo_dokladu, typ_dokladu)
where datum_prijatia <= sysdate
  and (datum_zrusenia is null 
    or datum_zrusenia >= sysdate);