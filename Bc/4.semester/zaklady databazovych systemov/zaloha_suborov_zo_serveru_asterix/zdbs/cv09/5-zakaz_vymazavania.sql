--vytvor zalohu tabulky zap_predmety
create table zap_predmety_bak
as select * from zap_predmety
where 1=0;

create or replace trigger zakaz_vymazavania
instead of delete
on zap_predmety_bak
declare
ex_custom EXCEPTION;
PRAGMA EXCEPTION_INIT(ex_custom, -20001);
begin
raise_application_error(-20001, 'Vymazavanie nepovolene');
dbms_output.put_line(sqlerrm);	--vypise chybovu hlasku
end;
/

create or replace trigger zakaz_vymazavania
instead of delete
on zap_predmety
declare
ex_custom EXCEPTION;
PRAGMA EXCEPTION_INIT(ex_custom, -20001);
begin
raise_application_error(-20001, 'Vymazavanie nepovolene');
dbms_output.put_line(sqlerrm);	--vypise chybovu hlasku
end;

show error;