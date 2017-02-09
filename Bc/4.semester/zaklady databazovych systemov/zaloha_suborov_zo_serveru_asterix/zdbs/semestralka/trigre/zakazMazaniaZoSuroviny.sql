create or replace trigger zakaz_vymazavania_suroviny
before delete
on surovina
declare
ex_custom EXCEPTION;
PRAGMA EXCEPTION_INIT(ex_custom, -20002);
begin
raise_application_error(-20002, 'Vymazavanie suroviny nepovolene');
dbms_output.put_line(sqlerrm);	--vypise chybovu hlasku
end;
/