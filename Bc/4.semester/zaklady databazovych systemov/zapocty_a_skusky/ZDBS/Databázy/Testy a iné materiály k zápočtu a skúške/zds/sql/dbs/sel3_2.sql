SET FEEDBACK OFF;
SET VERIFY OFF;
UNDEFINE cas_od;
UNDEFINE cas_do;
UNDEFINE start_stanica;
UNDEFINE stop_stanica;


select sum(prejazd_vlaku(cislo_vlaku, to_date('&cas_od', 'DD-MM-YYYY'), to_date('&cas_do', 'DD-MM-YYYY'))) as pocet_prejazdov 
from
(select s1.nazov, s2.nazov, cislo_vlaku 
from usek u, stanica s1, stanica s2, vlak v
where ((u.s_id = s1.id and u.s_id_konci_v = s2.id)
or (u.s_id = s2.id and u.s_id_konci_v = s1.id))
and v.cislo_vlaku = u.vl_cislo_vlaku
and s1.nazov = '&start_stanica' and s2.nazov = '&stop_stanica')
/

UNDEFINE cas_od;
UNDEFINE cas_do;
UNDEFINE start_stanica;
UNDEFINE stop_stanica;
