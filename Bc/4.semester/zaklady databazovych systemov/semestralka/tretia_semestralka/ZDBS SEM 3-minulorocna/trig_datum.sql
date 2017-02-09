create or replace trigger trig_datum

before insert or update on bankomat

referencing new as novy

for each row


begin
	
	if(:novy.datum_uvedenia > :novy.datum_vyradenia) then
 
	raise_application_error(-20000,'Zadajte spravny datum');

	end if;

end;

/