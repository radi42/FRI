create or replace trigger naplnit
before insert or update on zap_predmety
referencing new as novy
for each row
begin
 :novy.uzivatel:=user;
 :novy.datum:=sysdate; 
end;
