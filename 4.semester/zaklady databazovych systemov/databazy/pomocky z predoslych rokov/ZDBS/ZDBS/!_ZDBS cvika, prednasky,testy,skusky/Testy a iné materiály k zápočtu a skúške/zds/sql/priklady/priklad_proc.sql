create or replace procedure velkost
 as  pocet integer;
begin
 select count(*) into pocet from os_udaje;
 dbms_output.put_line('Pocet riadkov v tabulke je '||pocet);
end;
/