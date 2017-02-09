select meno, priezvisko, datum_sk
from os_udaje o, student s, zap_predmety zp
where o.rod_cislo = s.rod_cislo
  and s.os_cislo = zp.os_cislo
  and datum_sk between trunc(add_months(sysdate, -1),'MM') 
  and last_day(add_months(sysdate,-1));
--datum skusky je medzi prvym a poslednym dnom predchadzajuceho mesiaca


select meno, priezvisko
from os_udaje o, student s, zap_predmety zp
where o.rod_cislo = s.rod_cislo
  and s.os_cislo=zp.os_cislo
  and MONTHS_BETWEEN(sysdate, datum_sk) BETWEEN 0 AND 1;