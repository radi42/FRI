create or replace trigger pridajIDckoSurovine
before insert on surovina
for each row
begin
 select s_id_suroviny.NEXTVAL into :new.id_suroviny from dual;
end;
/
