create or replace trigger zakaz_vymazavania_druhuSportu
before delete
on druhSportu
declare
ex_custom EXCEPTION;
PRAGMA EXCEPTION_INIT(ex_custom, -20003);
begin
raise_application_error(-20003, 'Vymazavanie druhu sportu nepovolene');
dbms_output.put_line(sqlerrm);	--vypise chybovu hlasku
end;
/