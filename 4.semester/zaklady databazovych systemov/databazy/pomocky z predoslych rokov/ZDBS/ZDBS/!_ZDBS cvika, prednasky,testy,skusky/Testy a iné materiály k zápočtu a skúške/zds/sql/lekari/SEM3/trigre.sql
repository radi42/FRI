create or replace trigger trg_zoz_poist_del
before delete on zoz_poist
referencing old as stary
for each row
begin
  update os_udaje_pac set zoz_poist_id_poistovne = 'AHOJ'
  where zoz_poist_id_poistovne:stary.id_poistovne;
end;
/
