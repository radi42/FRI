set serveroutput on

CREATE OR REPLACE PROCEDURE statistikaSport(
p_os_cislo osoba.os_cislo%TYPE,
p_datumOd varchar2,
p_datumDo varchar2)
IS

cursor datumyvsetky is 
select distinct trunc(datum_cas) from sport 
where os_cislo = p_os_cislo
and trunc(datum_cas) >=  to_date(p_datumOd, 'dd-mm-yyyy')
AND trunc(datum_cas) <= to_date(p_datumDo, 'dd-mm-yyyy')
order by trunc(datum_cas);

/*cielkalorie integer;
kaloriejedlo integer;
kaloriesport integer;
vysledok integer;*/

tempdatum sport.datum_cas%type;
vypis varchar2(50);
vysledok number(10,2);
cielkalorie osoba.kcal_ciel%TYPE;
kumulovaneSpaleneKalorie number(10,2);
pocetdni integer;
statistikacelkova number(10,2);

vahazac integer;
vahaciel integer;

prijKalorie integer;
burnedCalories integer;

BEGIN

select kcal_ciel into cielkalorie from osoba where os_cislo = p_os_cislo;

vypis := '';
statistikacelkova := 0;
kumulovaneSpaleneKalorie :=  0;
prijKalorie := 0;
burnedCalories := 0;

dbms_output.put_line('--------- Statistika spalenych kalorii zo sportovych aktivit');
dbms_output.put_line('-----------------------------------------------------');
dbms_output.put_line('Datum______Pomer___Vysportovane kcal____Prijate kcal');

open datumyvsetky;
loop
fetch datumyvsetky into tempdatum;
kumulovaneSpaleneKalorie := kumulovaneSpaleneKalorie + spaleneKalorie(p_os_cislo, tempdatum);
 prijKalorie := prijateKalorie(p_os_cislo, tempdatum);
 burnedCalories := spaleneKalorie(p_os_cislo, tempdatum);
 if(prijKalorie = 0) then
  --ak nic nezjedol
  vysledok := 0;
 else
  vysledok := burnedCalories/prijKalorie;
 end if;

vysledok := vysledok * 100;
exit when datumyvsetky%notfound;
dbms_output.put_line(tempdatum || ' +-+ ' || vysledok || ' +-+ ' || burnedCalories|| ' +-+ ' || prijKalorie );
end loop;
close datumyvsetky;

select (to_date(p_datumDo, 'dd-mm-yyyy')-to_date(p_datumOd, 'dd-mm-yyyy')) into pocetdni from dual;

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
--dbms_output.put_line('kumul' || kumulovaneSpaleneKalorie);

statistikacelkova := (kumulovaneSpaleneKalorie/(pocetdni*cielkalorie)) * 100;
dbms_output.put_line('pomer prijatych a spalenych kalorii ku cielovym kaloriam: ' || statistikacelkova || '[%]');
dbms_output.put_line('Vysledky hovoria, aky percentualny podiel mal sport pri spalovani kalorii');
END;
/

show error;