--Vypiste pracovne pozicie zamestnancov (potlacte duplicity).
Select distinct pozicia from l_zamestnanec;

Vypiste informacie o vsetkych letoch ktore letia 16.6.2015 (+-3dni) z Bratislavy,Viedne do Londyna zoradte podla dat a ceny.
1.	select MestoZ.nazov,MestoDo.nazov,datum_letu datum FROM L_let join L_letisko LetiskoZ ON letisko_z=LetiskoZ.id_letiska JOIN L_letisko LetiskoDo ON letisko_do=letiskoDo.id_letiska JOIN L_mesto MestoZ ON MestoZ.psc=LetiskoZ.psc AND MestoZ.id_krajiny=LetiskoZ.id_krajiny JOIN L_mesto MestoDo on MestoDo.psc=LetiskoDo.psc AND MestoDo.id_krajiny=LetiskoDo.id_krajiny WHERE (datum_letu between to_date('16.06.2015','DD.MM.YYYY')-3 AND to_date('16.06.2015','DD.MM.YYYY')+3)
2.	AND (mestoZ.nazov='Bratislava' OR mestoZ.nazov='Vieden')
3.	AND MestoDo.nazov='London'
4.	ORDER BY datum_letu;

--Vypiste nazvy leteckych spolocnosti ktore lietaju do Spanielska.
Select distinct id_spolocnosti,nazov_spol from l_let join l_let_spolocnost using(id_spolocnosti) join l_krajina using(id_krajiny) join l_letisko on letisko_do=id_letiska where nazov_krajiny=‘Spanielsko‘;

--Vypiste pocet zrusenych leteniek v minulom mesiaci.
Select count(datum_zrusenia)from l_letenka where datum_zrusenia  is not null and extract(month from datum_zrusenia)= extract (month from sysdate)-1;

--Vypiste menny zoznam osob ktore si nekupili ani jednu letenku minuly rok (nepocitajte zo zrusenymi letenkami).
Select distinct meno,priezvisko from l_osoba join l_letenka using(cislo_dokladu,typ_dokladu) where datum_platby not in (select datum_platby from l_letenka where extract(year from datum_platby)=extract(year from sysdate)-1);

--Prebookujte let letenky 258 z id_letu 256 na 698.
Update l_letenka Set id_letenky =698 Where id_letu=256 and id_letenky=258;

--Zruste vsetky letenky dnesnych letov, ktore este neodleteli z mesta Londyn.
--Kto toto nakodi je sef - nakodil som to. som sef? :/ meh

--Vypiste lety ktore boli vyuzite na menej ako 30%.
Select id_letu,t.kapacita from l_triedy t join l_let l using(id_letu)join l_lietadlo lt using(id_lietadla)where t.kapacita<lt.kapacita*0.3;

--Vypiste nazvy leteckych spolocnosti ktore lietaju do viac ako 10 krajin.
select nazov_spol,count(distinct letisko_do) from l_let_spolocnost join l_krajina using(id_krajiny) join l_let using(id_spolocnosti) join l_letisko on letisko_do=id_letiska having (count(distinct letisko_do))>10 group by id_spolocnosti,nazov_spol;

--Vypíšte názvy leteckých spolocných, ktoré lietajú do mesta Rím
select distinct nazov_spol from l_let join l_letisko on letisko_do=id_letiska join l_mesto using(id_krajiny) join l_let_spolocnost using(id_spolocnosti)where nazov='Rim'

--Vypíšte zoznam letov tohto mesiaca u ktorých nemáme ani jednu predanú letenku (nepocítajte z duplicitu)
select distinct id_letu from l_let join l_letenka using(id_letu) where datum_platby not in (select datum_platby from l_letenka where extract(month from datum_platby)=extract(month from sysdate));

--Vypíšte pocet letov z letiska BTS, ktoré letia budúci mesiac
select id_letu from l_let where extract(month from datum_letu)=extract(month from sysdate)+1 and extract(year from datum_letu)=extract(year from sysdate) and letisko_z='BTS';

--.zmazte vsetky info o lete 545

--.vypiste mesta kde ja pocet letisiek >2 , pozor jedno mesto moze mat viac psc
select nazov,count(nazov) from l_mesto join l_letisko using(psc) group by psc,nazov having(count(nazov))>2;

--pridajte let. spol. skypeline kt. sidli v mnichove


--zoznam ludi kt. si nekupili letenku v r.k 2014
select distinct meno,priezvisko from l_osoba join l_letenka using(cislo_dokladu,typ_dokladu) where datum_platby not in(select datum_platby from l_letenka where extract(year from datum_platby)=2014);


--vypiste aktualnych zamestnancov spol. Ryanair
select distinct meno,priezvisko from l_osoba join l_zamestnanec using(cislo_dokladu,typ_dokladu) join l_let_spolocnost using(id_spolocnosti)where nazov_spol='Ryanair' and (datum_zrusenia is null or datum_zrusenia > sysdate);


--Vypíš presné informácie o letoch(id_letu, názov spolocnosti, dátum odletu, cas odletu) z Bratislavy do Viedne za minulý mesiac .
select id_letu,datum_letu,m1.nazov as MestoZ, m2.nazov as mestoDo, letiskoZ.id_letiska as 
	
Z,letiskoDo.id_letiska as do from l_let join l_letisko letiskoZ on 	
letiskoZ.id_letiska=l_let.letisko_z join l_letisko letiskoDo on 	
letiskoDo.id_letiska=l_let.letisko_do join L_mesto m1 on m1.psc=letiskoZ.psc and 
m1.id_krajiny=letiskoZ.id_krajiny join l_mesto m2 on m2.psc=letiskoDo.psc and 
m2.id_krajiny=letiskoDo.id_krajiny where m1.nazov='Bratislava' and m2.nazov='Rome' and extract
(month from datum_letu)=extract(month from sysdate)+1 and extract (year from sysdate)=extract(year 
from datum_letu);


--Vymaž všetky záznamy o letoch ktoré sú staršie ako 20rokov. Ako bude vyzerat telo triggra nad insertom do L_letenka ked id_letenky bude zo sekvencie let_sek.

--Vypíšte všetky lety minulého mesiaca ku ktorým sa nepredala žiadna letenka(neberte do úvahy datum_zrusenie).
select distinct id_letu from l_let join l_letenka using(id_letu) where datum_platby not in (select datum_platby from l_letenka where extract(month from datum_platby)=extract(month from sysdate)-1);

--Vypíšte všetky lety staršie ako rok do Talianska.
select id_letu,datum_letu from l_let join l_letisko on letisko_do=id_letiska join l_krajina using(id_krajiny)where nazov_krajiny='Taliansko' and datum_letu<add_months(sysdate,-12);

--Trigger nad update typ_dokladu z L_osoby ktoré dalšie tabulky má update.

--Vypíš všetky lety ktoré boli vcera z nejakého letiska lietadiel spolocnosti nvm ktorej.
select nazov_spol,letisko_z,datum_letu from l_let join l_let_spolocnost using(id_spolocnosti) join l_letisko on letisko_z=id_letiska where nazov_letiska='Zilina' and datum_letu=to_date('26.05.2015','DD.MM.YYYY')and nazov_spol='Ryanair';

--Vypíš všeky názvy letisiek Slovenska
select nazov_letiska from l_letisko join l_krajina using (id_krajiny)where nazov_krajiny ='Slovensko';
