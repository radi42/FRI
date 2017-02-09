--.vypiste mesta kde ja pocet letisiek >2 , pozor jedno mesto moze mat viac psc
select nazov,count(id_letiska) 
from l_mesto 
join l_letisko using(id_krajiny,psc) 
group by nazov
having(count(nazov))>2;

--toto funguje tiez
select nazov,count(distinct id_letiska)
from l_letisko
join l_mesto using(psc,id_krajiny)
group by nazov
having(count(distinct id_letiska))>2;
