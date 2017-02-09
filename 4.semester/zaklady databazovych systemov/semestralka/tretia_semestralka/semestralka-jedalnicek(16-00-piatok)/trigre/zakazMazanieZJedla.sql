create or replace trigger zakaz_vymazavania_jedla
before delete
on jedlo
declare
ex_custom EXCEPTION;
PRAGMA EXCEPTION_INIT(ex_custom, -20001);
begin
raise_application_error(-20001, 'Vymazavanie jedla nepovolene');
dbms_output.put_line(sqlerrm);	--vypise chybovu hlasku
end;
/