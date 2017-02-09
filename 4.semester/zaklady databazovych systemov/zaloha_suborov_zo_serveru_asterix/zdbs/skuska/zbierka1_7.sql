--Vypiste nazvy leteckych spolocnosti ktore lietaju do viac ako 10 krajin.
select nazov_spol,count(distinct letisko_do) 
from l_let_spolocnost 
join l_krajina using(id_krajiny) 
join l_let using(id_spolocnosti) 
join l_letisko on letisko_do=id_letiska 
having (count(distinct letisko_do))>10 
group by id_spolocnosti,nazov_spol;

--Vypiste nazvy leteckych spolocnosti ktore lietaju do viac ako 10 krajin.
select nazov_spol, count(distinct letisko_do)
from l_let_spolocnost
join l_let using(id_spolocnosti)
join l_letisko on letisko_do = id_letiska
group by (nazov_spol, id_spolocnosti)
having(count(distinct letisko_do))>10;











