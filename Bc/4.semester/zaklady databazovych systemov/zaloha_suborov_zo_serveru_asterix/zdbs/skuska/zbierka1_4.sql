--Vypiste pocet zrusenych leteniek v minulom mesiaci.
Select count(datum_zrusenia)
from l_letenka 
where datum_zrusenia  is not null 
and to_char(datum_zrusenia,'MM-YYYY') = to_char(add_months(sysdate,-1),'MM-YYYY');













--Vypiste zrusene letenky v minulom mesiaci.
select * from l_letenka
where to_char(datum_zrusenia,'MM-YYYY') = to_char(add_months(sysdate,-1),'MM-YYYY');