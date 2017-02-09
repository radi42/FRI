/*select datum_cas, nazov_jedla, kalorie_jedlo, tuky, bielkoviny, sacharidy 
from jedlo
join stravnik using (id_jedla)
join osoba using (os_cislo)
where stravnik.os_cislo = 26*/

/*select trunc(datum_cas) as DATUM, sum(kalorie_jedla) as KALORIE_SPOLU
from jedlo
join stravnik on (stravnik.id_jedla = jedlo.id_jedla)
where trunc(datum_cas) >= to_date('12-05-2015','dd-mm-yyyy') 
AND trunc(datum_cas) <= to_date('15-05-2015','dd-mm-yyyy') 
AND stravnik.os_cislo = 26
group by trunc(datum_cas);*/

set serveroutput on

CREATE OR REPLACE PROCEDURE vypisJedalnicka(
p_os_cislo osoba.os_cislo%TYPE,
p_datumOd varchar2,
p_datumDo varchar2)
IS

cursor datumyvsetky is 
select distinct trunc(datum_cas) from stravnik 
where os_cislo = p_os_cislo
and trunc(datum_cas) >=  to_date(p_datumOd,'dd-mm-yyyy')
AND trunc(datum_cas) <= to_date(p_datumDo, 'dd-mm-yyyy')
order by trunc(datum_cas);

tempdatum stravnik.datum_cas%type;

kkalorie number(10,2);
ttuky number(10,2);
bbielkoviny number(10,2);
ssacharidy number(10,2);

kaloriecelkovo number(10,2);
tukycelkovo number(10,2);
bielkovinycelkovo number(10,2);
sacharidycelkovo number(10,2);

BEGIN
kaloriecelkovo :=0;
tukycelkovo :=0;
bielkovinycelkovo :=0;
sacharidycelkovo :=0;

dbms_output.put_line('DATUM       - SUMA_KALORII - TUKY  - BIELKOVINY - SACHARIDY');
dbms_output.put_line('----------------------------------------------------------------');

open datumyvsetky;
loop
fetch datumyvsetky into tempdatum;

select sum(kalorie_jedla) into kkalorie from jedlo
join stravnik on (jedlo.id_jedla = stravnik.id_jedla)
where trunc(datum_cas)=tempdatum; 

select sum(tuky) into ttuky from jedlo
join stravnik on (jedlo.id_jedla = stravnik.id_jedla)
where trunc(datum_cas)=tempdatum;

select sum(bielkoviny) into bbielkoviny from jedlo
join stravnik on (jedlo.id_jedla = stravnik.id_jedla)
where trunc(datum_cas)=tempdatum;

select sum(sacharidy) into ssacharidy from jedlo
join stravnik on (jedlo.id_jedla = stravnik.id_jedla)
where trunc(datum_cas)=tempdatum;

exit when datumyvsetky%notfound;

kaloriecelkovo := kaloriecelkovo + kkalorie ;
tukycelkovo :=tukycelkovo +ttuky ;
bielkovinycelkovo :=bielkovinycelkovo +bbielkoviny ;
sacharidycelkovo :=sacharidycelkovo +ssacharidy ;

dbms_output.put_line(tempdatum || '   - ' || kkalorie || '          - ' || ttuky || ' - ' || bbielkoviny || '         - ' || ssacharidy);

end loop;
close datumyvsetky;

dbms_output.put_line('.');
dbms_output.put_line('CELKOVO ZA OBDOBIE:');
dbms_output.put_line('kalorie    = ' || kaloriecelkovo);
dbms_output.put_line('tuky       = ' || tukycelkovo);
dbms_output.put_line('bielkoviny = ' || bielkovinycelkovo);
dbms_output.put_line('sacharidy  = ' || sacharidycelkovo);

END;
/

show error;