--zadanie

select nazov_letiska
from l_letisko
where id_letiska not in
 (select letisko_z 
  from l_let
   where to_char(datum_letu,'YYYYMM') = to_char(sysdate, 'YYYYMM')
);

/*
--upravene zadanie
select nazov_letiska
from l_letisko llisko
where llisko.id_letiska not in
 (select ll.letisko_z 
  from l_let ll
   where to_char(ll.datum_letu,'YYYYMM') = to_char(sysdate, 'YYYYMM')
);
*/

/*
--NOT IN prepisane do NOT EXISTS
select nazov_letiska
from l_letisko llisko
where not exists
 (select 'x' 
  from l_let ll
   where to_char(datum_letu,'YYYYMM') = to_char(sysdate, 'YYYYMM')
    and ll.letisko_z = llisko.id_letiska
);
*/