SET PAGESIZE 60;
SET LINESIZE 123;
clear col

TTITLE Center 'Zoznam ludi ktory schudli aspon 5kg';
COLUMN Meno HEADING 'Meno stravnika';
COLUMN Priezvisko HEADING 'Priezvisko stravnika';
BTITLE RIGHT SQL.PNO;

select distinct meno, priezvisko from osoba
--join stravnik using (os_cislo) where vaha_zaciatocna - vahaPriebezna >= 5;
join stravnik using (os_cislo) where vaha_zaciatocna - vahaPriebezna >= 1;

TTITLE OFF;
BTITLE OFF;