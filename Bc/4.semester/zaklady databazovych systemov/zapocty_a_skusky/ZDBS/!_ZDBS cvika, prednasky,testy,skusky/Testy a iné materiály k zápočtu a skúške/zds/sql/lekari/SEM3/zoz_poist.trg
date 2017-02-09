create or replace trigger trg_zoz_poist_upd
before update on zoz_poist
for each row
begin
  update os_udaje_pac set zoz_poist_id_poistovne = :new.id_poistovne
  where zoz_poist_id_poistovne = :old.id_poistovne;
end;
/

create or replace trigger trg_zoz_poist_del
before delete on zoz_poist
for each row
declare
  pocet integer;
begin
 SELECT count(*) INTO pocet FROM os_udaje_pac 
 WHERE zoz_poist_id_poistovne = :old.id_poistovne;
 IF pocet>0 THEN
   raise_application_error(-20000,'ERROR - NEMOZES VYMAZAT POISTOVNU. JE POUZITA V OS_UDAJE_PAC!');
 END IF;
end;
/
