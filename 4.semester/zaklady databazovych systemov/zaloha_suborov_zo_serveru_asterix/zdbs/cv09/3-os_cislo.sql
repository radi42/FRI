/*
Spravte trigger, ktory vam zabezpec kaskadu na operaciu Update pre zmenu osobneho csla.
*/

drop trigger upd_os_cislo;

create or replace trigger upd_os_cislo
after update of os_cislo on student
for each row
begin
update zap_predmety
set os_cislo = :new.os_cislo
where :old.os_cislo = os_cislo;
end;
/

--update nebude fungovat, lebo student s danym cislom uz neexistuje
/*
update student
set os_cislo = 345
where os_cislo = 234;
*/

update student
set os_cislo = 234
where os_cislo = 345;