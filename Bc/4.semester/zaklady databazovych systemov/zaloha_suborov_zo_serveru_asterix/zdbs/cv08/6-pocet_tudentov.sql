create or replace function pocet_studentov(cislo_predmetu in Char, skolsky_rok in Number)
return Integer
as
pom Integer;
begin
	select count(os_cislo) into pom
	from zap_predmety
	where cislo_predmetu in (select cis_predm from zap_predmety where cis_predm like cislo_predmetu) 
	and skolsky_rok in (select skrok from zap_predmety where skolsky_rok = skrok );	
	return pom;
end pocet_studentov;
/