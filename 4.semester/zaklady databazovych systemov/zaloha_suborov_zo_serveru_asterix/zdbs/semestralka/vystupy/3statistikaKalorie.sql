set serveroutput on

CREATE OR REPLACE PROCEDURE statistikaKalorie(
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

/*cielkalorie integer;
kaloriejedlo integer;
kaloriesport integer;
vysledok integer;*/

tempdatum stravnik.datum_cas%type;
vypis varchar2(50);
vysledok number(10,2);
cielkalorie osoba.kcal_ciel%TYPE;
kumulovanekalorie number(10,2);
pocetdni integer;
statistikacelkova number(10,2);

vahazac integer;
vahaciel integer;
--stravnik.datum_cas%type
BEGIN

select kcal_ciel into cielkalorie from osoba where os_cislo = p_os_cislo;

vypis := '';
statistikacelkova := 0;
kumulovanekalorie :=  0;

dbms_output.put_line('DATUM --------- Splnenie cielovych kalorii za den [%]');
dbms_output.put_line('-----------------------------------------------------');

open datumyvsetky;
loop
fetch datumyvsetky into tempdatum;
kumulovanekalorie := kumulovanekalorie + prijateSpaleneKalorie(p_os_cislo, tempdatum);
vysledok := prijateSpaleneKalorie(p_os_cislo, tempdatum)/cielkalorie;
vysledok := vysledok * 100;
exit when datumyvsetky%notfound;
dbms_output.put_line(tempdatum || ' ' || vysledok);
end loop;
close datumyvsetky;

select (to_date(p_datumDo, 'dd-mm-yyyy')-to_date(p_datumOd,'dd-mm-yyyy')) into pocetdni from dual;

pocetdni := pocetdni +1;

select vaha_zaciatocna into vahazac from osoba where os_cislo = p_os_cislo;
select vaha_ciel into vahaciel from osoba where os_cislo = p_os_cislo;

if (vahazac > vahaciel) then
dbms_output.put_line('osoba ma ciel schudnut');
end if;
if (vahazac = vahaciel) then
dbms_output.put_line('osoba ma ciel udrzat vahu');
end if;
if (vahazac < vahaciel) then
dbms_output.put_line('osoba ma ciel pribrat');
end if;

--dbms_output.put_line('pocet dni' || pocetdni);
--dbms_output.put_line('kumul' || kumulovanekalorie);

statistikacelkova := (kumulovanekalorie/(pocetdni*cielkalorie)) * 100;
dbms_output.put_line('pomer prijatych a spalenych kalorii ku cielovym kaloriam: ' || statistikacelkova || '[%]');
dbms_output.put_line('Interpretacia vysledkov:');
dbms_output.put_line('Ak uzivatel chce schudnut a ma pomer mensi alebo rovny ako 100%, tak osoba chce chudnut a chudne.');
dbms_output.put_line('Ak uzivatel chce schudnut a ma pomer vacsi 100%, tak osoba chce chudnut, ale pribera.');
dbms_output.put_line('Ak uzivatel chce priberat a ma pomer mensi ako 100%, tak osoba priberat, ale chudne.');
dbms_output.put_line('Ak uzivatel chce priberat a ma pomer vacsi alebo rovny 100%, tak osoba chce pribrat, a pribera.');
END;
/

show error;