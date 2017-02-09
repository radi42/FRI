create or replace trigger pridajIDckoJedlu
before insert on jedlo
for each row
begin
 select s_id_jedla.NEXTVAL into :new.id_jedla from dual;
end;
/
