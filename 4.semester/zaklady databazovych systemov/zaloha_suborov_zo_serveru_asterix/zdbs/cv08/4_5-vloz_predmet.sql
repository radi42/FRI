create or replace procedure Vloz_predmet
(cislo in char, naz in Varchar2)
is
je_null EXCEPTION;
begin
	if cislo is null then
		raise je_null;
	elsif naz is null then
		raise je_null;
	else
		insert into predmet	--povodny riadok: insert into predmet(cis_predm, nazov)
		values (cislo, naz);
	end if;
end Vloz_predmet;
/