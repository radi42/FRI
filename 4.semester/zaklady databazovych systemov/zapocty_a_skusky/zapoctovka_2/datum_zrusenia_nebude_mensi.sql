create or replace trigger datum_zrusenia
before insert on l_zamestnanec
for each row
begin
 if(:new.datum_zrusenia < :new.datum_prijatia) then
  raise_application_error(-20000, 'nekonzistentne data');
 end if;
end;
/