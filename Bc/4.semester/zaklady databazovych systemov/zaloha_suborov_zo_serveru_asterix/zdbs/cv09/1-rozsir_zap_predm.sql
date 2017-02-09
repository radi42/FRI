/*
Rozsrte tabul'ku zap predmety o dva stlpce - uzvatel', datum. Vytvorte trigger, ktory pri zmene
napln tieto stlpce do vsetkych zmenenych riadkov aktualnym uzvatel'om a datumom a casom tejto
zmeny. (Tak, aby ste zabranili prepsaniu uzvatel'om.)
*/


--alter table zap_predmety
--add (uzivatel VARCHAR(20), datum TIMESTAMP);

create or replace trigger pridaj_stlpce
before update on zap_predmety
referencing new as novy
for each row
begin
	select USER into :novy.uzivatel from dual;
	select sysdate into :novy.datum from dual;

end;
/

--otestujeme
update zap_predmety
set uzivatel = USER;
set datum = sysdate;
