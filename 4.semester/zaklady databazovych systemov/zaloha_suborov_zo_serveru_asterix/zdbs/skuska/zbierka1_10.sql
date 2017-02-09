--Vypíšte pocet letov z letiska BTS, ktoré letia budúci mesiac

/*
select id_letu 
from l_let 
where extract(month from datum_letu)=extract(month from sysdate)+1 
and extract(year from datum_letu)=extract(year from sysdate) 
and letisko_z='BTS';
*/

select count(distinct id_letu)
from l_let 
where to_char(datum_letu,'MM-YYYY')=to_char(add_months(sysdate,1),'MM-YYYY')
and letisko_z='BTS';