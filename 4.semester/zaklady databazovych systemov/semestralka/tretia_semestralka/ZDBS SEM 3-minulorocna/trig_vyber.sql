create or replace trigger trig_transakcie
before insert or update on transakcie
referencing new as novy

for each row

begin

	if(:novy.suma_vyber < 0) then
 
	raise_application_error(-20000,'Zadajte kladne cislo');

	end if;

end;

/