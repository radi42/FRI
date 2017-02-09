--Vypíš presné informácie o letoch(id_letu, názov spolocnosti, dátum odletu, cas odletu) z Bratislavy do Viedne za minulý mesiac .

/*
select id_letu,datum_letu,m1.nazov as MestoZ, m2.nazov as mestoDo, letiskoZ.id_letiska as 
	
Z,letiskoDo.id_letiska as do from l_let join l_letisko letiskoZ on 	
letiskoZ.id_letiska=l_let.letisko_z join l_letisko letiskoDo on 	
letiskoDo.id_letiska=l_let.letisko_do join L_mesto m1 on m1.psc=letiskoZ.psc and 
m1.id_krajiny=letiskoZ.id_krajiny join l_mesto m2 on m2.psc=letiskoDo.psc and 
m2.id_krajiny=letiskoDo.id_krajiny where m1.nazov='Bratislava' and m2.nazov='Rome' and extract
(month from datum_letu)=extract(month from sysdate)+1 and extract (year from sysdate)=extract(year 
from datum_letu);
*/

select id_letu, id_spolocnosti, letisko_z, letisko_do, datum_letu, skut_cas_odletu
from l_let
where letisko_z = (select id_letiska from l_letisko join l_mesto using(id_krajiny,psc) where nazov='Bratislava' )
and letisko_do =  (select id_letiska from l_letisko join l_mesto using(id_krajiny,psc) where nazov='Vieden' )
and extract(month from datum_letu)=extract(month from sysdate)-1;

--nevrati nic, pretoze tabulka l_letisko nema ziadny zaznam o letisku vo viedni
