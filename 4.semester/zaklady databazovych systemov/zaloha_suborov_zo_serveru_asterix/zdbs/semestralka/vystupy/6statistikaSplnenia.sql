SET PAGESIZE 60;
SET LINESIZE 123;
clear col

TTITLE Center 'Statistika splnenia cielov uzivatelov';
COLUMN min_doba HEADING 'Min. doba';
COLUMN max_doba HEADING 'Max. doba';
COLUMN avg_doba HEADING 'Priemerna doba';
COLUMN vek HEADING 'Vek';
COLUMN pohlavie HEADING 'Pohlavie';
BTITLE RIGHT SQL.PNO;

variable ciel varchar2(15);
exec :ciel := '&ciel';

select min(max(datum_cas)-trunc(datum_nastupu)) min_doba, --minimalne
max(max(datum_cas)-trunc(datum_nastupu)) max_doba, --maximalne
avg(to_number(max(datum_cas)-trunc(datum_nastupu))) avg_doba --priemerne
from
(select * from osoba join stravnik using (os_cislo)
where 
(sign(vaha_ciel-vaha_zaciatocna)= decode(:ciel,'chudnutie',-1)
and (vaha_ciel-vahaPriebezna) >= 0) or 
(sign(vaha_ciel-vaha_zaciatocna)= decode(:ciel,'priberanie',1)
and (vaha_ciel-vahaPriebezna) <= 0) or
(sign(vaha_ciel-vaha_zaciatocna)= decode(:ciel,'vyvazene',0)
and (vaha_ciel-vahaPriebezna) = 0)
and floor(months_between(sysdate, datum_narodenia) /12) = '&vek'
and pohlavie = '&pohlavie'
and datum_nastupu between to_date('&datumOd','DD.MM.YYYY') and to_date('&datumDo','DD.MM.YYYY')) 
group by os_cislo, datum_cas, datum_nastupu;

exec :ciel := null;


clear col
TTITLE OFF;
BTITLE OFF;