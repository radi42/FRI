SET PAGESIZE 30
SET LINESIZE 123
TTITLE CENTER "Prehlad kalorii s prepoctom na kategorie jedla podla osoby a dni"
BTITLE RIGHT SQL.PNO
COLUMN datum HEADING 'Datum'
COLUMN kategoria HEADING 'Kategoria' FORMAT A20 WORD_WRAP
COLUMN kalorie_spolu HEADING  'Spolu kalorie na kategoriu'

select trunc(datum_cas) as datum, kategoria, sum(kalorie_jedla) as kalorie_spolu
from jedlo
join stravnik on (stravnik.id_jedla = jedlo.id_jedla)
where trunc(datum_cas) >= to_date('&datum_od','dd-mm-yyyy') 
AND trunc(datum_cas) <= to_date('&datum_do','dd-mm-yyyy') 
AND stravnik.os_cislo = &os_cislo
group by kategoria, trunc(datum_cas)
order by trunc(datum_cas);

ttitle off;
btitle off;
clear columns;