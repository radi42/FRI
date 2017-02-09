/*
uloha c.1 Triggre
*/

/*
1 Rozsirte tabulku zap_predmety o dva stlpce -  uzivatl, datum. 
Vytvorte trigger, ktory pri zmene naplni tieto stlpce do vsetkych zmenenych 
riadkov aktualnym uzivatelom a datumom a casom  tejto zmeny. 
(Tak, aby ste zabranili prepisaniu uzivatelom.)
*/

/*
Rozsirenie tabulky
*/

/*
Alter table zap_predmety
  add(uzivatel Varchar2(9),datum DAte);
*/

/*
CREATE OR REPLACE TRIGGER tr_up_zap_predm
before update on zap_predmety
referencing new as novy
for each row
begin
  select user,sysdate into :novy.uzivatel, :novy.datum from dual;
end;
/
*/

/*
2. Pomocou triggra(triggrov) zabezpecte, ze ziaden student nemoze predmet 
opakovat viac ako jeden krat. (Pri operacii insert)
*/

/*
CREATE OR REPLACE TRIGGER tr_kon_opak
  befor insert on zap_predmety
  referencing new as novy
  for each row
  declare pocet integer;
  begin
    select count(*) into pocet
    from zap_predmety
    where os_cislo = :novy.os_cislo and cis_predm = :novy.cis_predm;
    
    if pocet >= 2 then
      raise_application_error(-20000,'error-nemozes si zapisat predmet 3x');
    end if;
  end;
/
*/

/*
3. Spravte trigger, ktory vam zabezpeci kaskadu na operaciu 
update pre zmenu osobneho cisla.
*/

/*
CREATE OR REPLACE TRIGGER trg_kaskada
before update of os_cislo on student
referencing new as novy old as stary
for each row
declare 
  pocet integer;
begin
  select count(*) into pocet from zap_predmety
  where os_cislo= :stary.os_cislo;
  dbms_output.put_line('opravenych '||pocet||' zaznamov');
  update zap_predmety
  set os_cislo = :novy.os_cislo
  where os_cislo = :stary.os_cislo;
end;
/
*/

/*
4. Vytvorte tabulku pre logovanie operacii vykonavanych 
nad tabulkou zap_predmety. Potrebne je logovat- kto, kedy, aku operaciu vykonal
a ako vyzeral povodny zaznam (v pripade Delete, Update) alebo novy zaznam
v pripade Insert
*/

/*
create table log_table
as select * from zap_predmety where os_cislo is null);
*/

/*
alter table log_table
add (operacia char(1));
*/

/*
create or replace trigger zp_predm_ins
  before insert on zap_predmety
  referencing new as novy
  for each row
begin
  insert into zp_del(os_cislo, skrok, cis_predm, prednasajuci, 
                     vysledok, datum_sk, termin, zapocet, kredity, 
                     uzivatel, datum, operacia)
  values (:novy.os_cislo, :novy.skrok, :novy.cis_predm, :novy.prednasajuci,
         :novy.vysledok, :novy.datum_sk, :novy.termin, :novy.zapocet,
         :novy.kredity, user, sysdate, 'I'); 
end;
*/

/*
create or replace trigger zp_predm_del
  before delete on zap_predmety
  referencing old as old
  for each row
begin
  insert into zp_del(os_cislo, skrok, cis_predm, prednasajuci, vysledok,
                     datum_sk, termin, zapocet, kredity, uzivatel, 
                     datum, operacia)
  values (:old.os_cislo, :old.skrok, :old.cis_predm, :old.prednasajuci,
          :old.vysledok, :old.datum_sk, :old.termin, :old.zapocet,
          :old.kredity, user, sysdate, 'D');
end;
/
*/

/*
create or replace trigger zp_predm_up
  before update on zap_predmety
  referencing old as stary
  for each row
begin
  insert into zp_del(os_cislo, skrok, cis_predm, prednasajuci, vysledok,
                     datum_sk, termin, zapocet, kredity, uzivatel, datum,
                     operacia)
  values (:stary.os_cislo, :stary.skrok, :stary.cis_predm, :stary.prednasajuci,
          :stary.vysledok, :stary.datum_sk, :stary.termin, :stary.zapocet,
          :stary.kredity, user, sysdate, 'U');
end;
/
*/

/*---------------------------------------------------------------------------*/

/*
Uloha c. 2- Procedury a funkcie
*/

/*
1. Vytvorte proceduru Vypis_typ_predmetu, ktora ma dva parametre- jeden ako
vstupny parameter cislo predmetu a druhy ako vystupny parameter informaciu,
ci je dany predmet povinny (P), alternativny (A) alebo volitelny (V).
*/

/*
create or replace procedure Vypis_typ_predmetu
  (v_cis_predm in zap_predmety.cis_predm%TYPE,
   vys_i out varchar2)
is
begin
  vys_i := substr(v_cis_predm,1,1);
end Vypis_typ_predmetu;
/
*/

/*
2. Vytvorte proceduru Vloz_predmet, ktora vykona INSERT operaciu noveho predmetu
do tabulky predmet. Zabezpecte aby boli vyplnene vsetky NOT NULL stlpce este
pred pokusom o vlozenie.
Skompilujte proceduru a vlozte nasledujuce predmety:
Cislo predmetu: P614, nazov: Databazove systemy, gestor: KI003
Cislo predmetu: P112, nazov: Uvod do inzinierstva, gestor: KMME1
Cislo predmetu: P112, nazov: Uvod do inzinierstva, gestor: KMME1
(Co sa stalo pri vkladani tohto zaznamu?Nastala chyba?Preco?)
*/

/*
create or replace procedure vloz_predmet
  (v_cis_predm in predmet.cis_predm%TYPE DEFAULT 'NIC',
   v_gestor in predmet.gestor%TYPE DEFAULT 'NIC',
   v_nazov in predmet.nazov%TYPE DEFAULT 'NIC')
is
begin
  insert into predmet (cis_predm,gestor,nazov) 
  values (v_cis_predm,v_gestor,v_nazov);
end;
/ 
*/

/*
3. Vytvorte prislusnu exception na osetrenie predchadzajucej chyby 
v procedure Vloz_predmet 
*/

/*
create or replace procedure vloz_predmet
  (v_cis_predm in predmet.cis_predm%TYPE DEFAULT 'NIC',
   v_gestor in predmet.gestor%TYPE DEFAULT 'NIC',
   v_nazov in predmet.nazov%TYPE DEFAULT 'NIC')
is
begin
  insert into predmet (cis_predm,gestor,nazov)
  values (v_cis_predm,v_gestor,v_nazov);
  exception
  when DUP_VAL_ON_INDEX then
    dbms_output.put_line('Pokusas sa vkladat duplicitny primarny kluc');
end;
/
*/

/*
Uloha c.3- Domaca uloha- triggre
*/

/*
1. Napiste trigger, ktorym zakazete vymazavat komukolvek riadky z tabulky
zap_predmety. Nasledne sa pokuste vymazat niektory riadok.
*/

/*
create or replace trigger tr_del_zap_predm
  before delete on zap_predmety
  for each row
begin
  raise_application_error(-20000,'Nemas pravo mazat udaje');
end;
/
*/

/*
2. Vyskusajte si odstavenie a znovu aktivovanie triggra z predchadzajuceho
prikladu.
*/

/*
alter trigger tr_del_zap_predm disable;

alter trigger tr_del_zap_predm enable;
*/

/*
Dropnite triggerz prikladu c.1.
*/

/*
drop trigger tr_up_zap_predm;
*/

/*
Uloha c.4 - Domaca uloha- procedury
*/

/*
1. Bonus- Upravte proceduru Vloz_predmet, tak aby ste skontrolovali skor ako to
tam vlozite, ci je mozne vlozit a ak nie vypiste hlasku, inak tam vlozte nove
udaje.
*/

/*
create or replace procedure vloz_predmet
  (v_cis_predm in predmet.cis_predm%TYPE DEFAULT 'NIC',
   v_gestor in predmet.gestor%TYPE DEFAULT 'NIC',
   v_nazov in predmet.nazov%TYPE DEFAULT 'NIC')
is
begin
  insert into predmet (cis_predm,gestor,nazov)
  values (v_cis_predm,v_gestor,v_nazov);
  exception
  when DUP_VAL_ON_INDEX then
    dbms_output.put_line('Pokusas sa vkladat duplicitny primarny kluc');
end;
/
*/


/*
2. Vytvorte proceduru Zmen_predmet, ktora vykona UPDATE operaciu nazvu predmetu
v tabulke PREDMET. Ako vstupny parameter odovzdajte cislo predmetu a novy nazov
predmetu. Vytvorte exception pre osetrenie pripadu, ked zadany predmet 
neexistuje, t.j. nenastane ziaden update.
Skompilujte proceduru a otestujte.
*/

/*
create or replace procedure Zmen_predmet
  (v_cis_predm in predmet.cis_predm%TYPE,
   v_nazov in predmet.nazov%TYPE)
as
  pocet number := 0;
begin
  select count(*) into pocet from predmet where cis_predm=v_cis_predm;
  if (pocet =0) then
    raise_application_error(-20000,'Takyto predmet neexistuje v tabulke predmety');
  end if;
  update predmet set nazov=v_nazov where cis_predm=v_cis_predm;
end Zmen_predmet;
/
*/

/*
3. Vytvorte funkciu Zrus_predmet, kotra vykona DELETE operaciu predmetu v 
tabulke PREDMET. Ako vstupny parameter odovzdajte cislo predmetu. Navratova 
hodnota funkcie bude pocet vymazanych riadkov. 

Podla mna zle definovana uloha asi bude treba zabezpecit aj kaskadu na zap_predmety
*/

/*
Create or replace function Zrus_predmet
  (v_cis_predm predmet.cis_predm%TYPE)
  return number
as
pocet number := 0;
begin
  select count(*) into pocet from zap_predmety where cis_predm = v_cis_predm;
  delete from zap_predmety where cis_predm = v_cis_predm;
  delete from predmet where cis_predm = v_cis_predm;
  pocet := pocet + 1;
  return pocet;
end;
/
*/