--Vymaž všetky záznamy o letoch ktoré sú staršie ako 20rokov.
delete from l_let
where extract(year from datum_letu)<=extract(year from sysdate)-20;


--Ako bude vyzerat telo triggra nad insertom do L_letenka ked id_letenky bude zo sekvencie let_sek.
create or replace trigger vlozLetenku
before insert on l_letenka
for each row
begin

select let_sek.nextval into :new.id_letenky from dual;

end;
/

show error;
--samozrejme ze napise ze sekvencia neexistuje - ani nema existovat :)