/*
Pomocou triggra (triggrov) zabezpecte, ze ziaden student nem^oze predmet opakovat' viac ako jeden
krat. (Pri operacii insert). Po odskusan tento trigger dropnite.
*/


create or replace trigger opakuj_predmet
before insert on zap_predmety
for each row
declare
v_pocet integer;
begin 
select count(*) into v_pocet
from zap_predmety
where zap_predmety.os_cislo = :new.os_cislo;

if v_pocet >= 2
then RAISE_APPLICATION_ERROR(-20001, 'CHYBA: Neda sa zapisat predmet. Predmet je zapisany viac ako dva krat!');
end if;
end;
/
show errors;

--najst si niekoho, kto uz mal zapisany ten isty predmet viac krat
select os_cislo, cis_predm, count(skrok)
from zap_predmety
group by os_cislo, cis_predm
having count(skrok) >= 2;  
--treba pocitat pocet skolskych rokov, v ktorych sa predmet nachadza

insert into zap_predmety(os_cislo, cis_predm, skrok)
values(500422, 'II07', 2015);

drop trigger opakuj_predmet;