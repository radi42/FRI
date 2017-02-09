SET PAGESIZE 70;
SET LINESIZE 100;
clear col

TTITLE LEFT '  Zoznam klientov najcastejsie vyuzivajucich bankomaty podla miest';

COLUMN nazov_mesto HEADING 'Mesto' format A20;
COLUMN meno HEADING 'Meno' format A20;
COLUMN priezvisko HEADING 'Priezvisko' format A20;
COLUMN pocet HEADING 'Pocet';


select nazov_mesto, meno, priezvisko, pocet from (
select m.nazov_mesto, osoba.meno, osoba.priezvisko, count(*) as pocet 
	from mesto m join adresa on(m.kod_mesto=adresa.kod_mesto) 
	join osoba on(adresa.id_adresa=osoba.id_adresa) 
	join zakaznik on(osoba.rod_cislo=zakaznik.rod_cislo) 
	join transakcie on(osoba.rod_cislo=transakcie.rod_cislo)
group by m.nazov_mesto, osoba.meno, osoba.priezvisko, m.kod_mesto
having count(*)=(
SELECT max(count(*)) AS pocet 
	from mesto m2 join adresa on(m2.kod_mesto=adresa.kod_mesto) 
	join osoba on(adresa.id_adresa=osoba.id_adresa) 
	join zakaznik on(osoba.rod_cislo=zakaznik.rod_cislo) 
	join transakcie on(osoba.rod_cislo=transakcie.rod_cislo)
WHERE m2.kod_mesto = m.kod_mesto
GROUP BY m2.nazov_mesto, osoba.meno, osoba.priezvisko, m2.kod_mesto
)
order by pocet desc
) 
;