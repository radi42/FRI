create or replace trigger trig_adresa
before insert on adresa
for each row

declare pocet integer;

begin
	select count(*) into pocet from adresa where id_adresa=:new.id_adresa;
      	if(pocet=1) then
	 
	raise_application_error(-20000,'ID_adresa uz existuje');

	end if;

end;

/