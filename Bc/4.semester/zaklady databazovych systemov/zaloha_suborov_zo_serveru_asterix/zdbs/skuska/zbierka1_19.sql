--Trigger nad update typ_dokladu z L_osoby ktoré dalšie tabulky má update.

create or replace trigger updateTypDokladu
after update on l_osoba
for each row
begin
 update l_zamestnanec
 set typ_dokladu = :new.typ_dokladu
 where cislo_dokladu = :old.cislo_dokladu
 and typ_dokladu = :old.typ_dokladu;

 update l_letenka
 set typ_dokladu = :new.typ_dokladu
 where cislo_dokladu = :old.cislo_dokladu
 and typ_dokladu = :old.typ_dokladu;

end;
/

show error;