SET PAGESIZE 60;
SET LINESIZE 123;
clear col

TTITLE CENTER 'Zoznam ludi ktory hraju futbal';
BTITLE RIGHT SQL.PNO

select distinct meno, priezvisko from osoba
join sport using (os_cislo) 
where id_druhSportu = 3;

ttitle off;
btitle off;

