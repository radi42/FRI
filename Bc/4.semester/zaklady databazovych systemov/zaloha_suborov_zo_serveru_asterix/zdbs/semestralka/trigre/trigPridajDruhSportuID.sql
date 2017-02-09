create or replace trigger pridajIDdruhuSportu
before insert on druhSportu
for each row
begin
 select s_id_druhSportu.NEXTVAL into :new.id_druhSportu from dual;
end;
/
