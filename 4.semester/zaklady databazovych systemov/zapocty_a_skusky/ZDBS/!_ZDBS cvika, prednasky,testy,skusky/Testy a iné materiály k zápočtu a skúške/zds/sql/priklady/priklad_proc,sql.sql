create or replace procedure velkost
 pocet integer;
begin
  select count(*) into pocet from os_udaje;
  dbms_output.put_line('Pocet riadkov v tabulke os_udaje je ' || pocet);
end;
/