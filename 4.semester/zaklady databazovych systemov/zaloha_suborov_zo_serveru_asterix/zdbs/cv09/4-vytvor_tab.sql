/*
Vytvorte tabul'ku pre logovanie operaci vykonavanych nad tabul'kou zap predmety. Potrebne je
logovat' { kto, kedy, aku operaciu vykonal a ako vyzeral p^ovodny zaznam (v prpade Delete, Update)
alebo novy zaznam (v prpade Insert).
*/
cl scr

drop table log_table_zap;
drop trigger vytvor_tab_upd;
drop trigger vytvor_tab_ins;
drop trigger vytvor_tab_del;


create table log_table_zap 
as select * from zap_predmety 
where 1=0;

alter table log_table_zap
add (
operacia varchar2(6),
uzivatel varchar2(20),
datum timestamp
);




--pre update
create or replace trigger vytvor_tab_upd
after update on zap_predmety
referencing old as stare
for each row
begin

insert into log_table_zap 
values (
:stare.os_cislo, 
:stare.cis_predm, 
:stare.skrok, 
:stare.prednasajuci, 
:stare.ects, 
:stare.zapocet, 
:stare.vysledok, 
:stare.datum_sk, 
'UPDATE', 
USER, 
sysdate
);

end;
/

show error;




--pre delete
create or replace trigger vytvor_tab_del
after delete on zap_predmety
referencing old as stare
for each row
begin

insert into log_table_zap 
values (
:stare.os_cislo, 
:stare.cis_predm, 
:stare.skrok, 
:stare.prednasajuci, 
:stare.ects, 
:stare.zapocet, 
:stare.vysledok, 
:stare.datum_sk, 
'DELETE', 
USER, 
sysdate
);

end;
/

show error;







--pre insert
create or replace trigger vytvor_tab_ins
after insert on zap_predmety
referencing new as nove
for each row
begin

insert into log_table_zap 
values (
:nove.os_cislo, 
:nove.cis_predm, 
:nove.skrok, 
:nove.prednasajuci, 
:nove.ects, 
:nove.zapocet, 
:nove.vysledok, 
:nove.datum_sk, 
'INSERT', 
USER, 
sysdate
);

end;
/

show error;





--kontrola pre trigger - UPDATE
/*
update zap_predmety
set cis_predm = 'BN99'
where cis_predm = 'BN10';
Tento update sa nevykona, pretoze predmet 'BN99' sa nenachadza v tabulke predmet.
Kedze je cis_predm cudzim klucom v tabulke zap_predmety, zmenit hodnotu cis_predm
v tabulke zap_predmety je mozne IBA Z EXISTUJUCICH cisiel predmetu, definovanych
v tabulke predmet
*/

--skontroluj
update zap_predmety
set cis_predm = 'BS10'
where cis_predm = 'BN10';


--vrat do kvazi povodneho stavu
update zap_predmety
set cis_predm = 'BN10'
where cis_predm = 'BS10';





--kontrola pre trigger - INSERT
insert into zap_predmety(os_cislo, cis_predm, skrok, prednasajuci, ects)
values (500422, 'SI28', 2015, 'KDS05', 10);






--kontrola pre trigger - DELETE
delete from zap_predmety
where os_cislo = 500422;


select * from log_table_zap;