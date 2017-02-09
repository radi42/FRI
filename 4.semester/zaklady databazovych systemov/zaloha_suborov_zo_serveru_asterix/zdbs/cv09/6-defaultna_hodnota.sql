/*
Pomocou triggra zabezpecte pri vkladan  udajov do tabulky zap_predmety 
nastavenie defaultnej hodnoty  ects  podla  tabulky  predmet_bod  z  
daneho  roku.  (  T.j.  ak  uzvatel pri  vkladan  nezadahodnotu ects, 
zistite ju z tabulky predmet_bod z udajov platnych pre dany predmet v dany rok.).
*/

create or replace trigger kredity_predmetu
before insert on zap_predmety
for each row
begin
  if(:new.ects IS NULL)
  then
	select pb.ects into :new.ects
	from predmet_bod pb
	where
	--najdi maximum zo skolskych rokov pre dany predmet v tabulke predmet_bod
	pb.skrok = (select max(skrok) from predmet_bod where cis_predm = :new.cis_predm)
	and 
	pb.cis_predm = :new.cis_predm;
  end if;
	
end;
/
show error;

--kontrola
insert into zap_predmety(os_cislo, cis_predm, skrok, prednasajuci, ects)
values (500422, 'IA02', 2015, 'KIS03', null);

--ukaz, co sa vlozilo
select * from zap_predmety 
where os_cislo = 500422 AND cis_predm = 'IA02' AND skrok = 2015 AND prednasajuci = 'KIS03';

--vymaz vlozene
delete from zap_predmety
where os_cislo = 500422 AND cis_predm = 'IA02' AND skrok = 2015 AND prednasajuci = 'KIS03';

--ukaz, ze sa to vymazalo
select * from zap_predmety 
where os_cislo = 500422 AND cis_predm = 'IA02' AND skrok = 2015 AND prednasajuci = 'KIS03';