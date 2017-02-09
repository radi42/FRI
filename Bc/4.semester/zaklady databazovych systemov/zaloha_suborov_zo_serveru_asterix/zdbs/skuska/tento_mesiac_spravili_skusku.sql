select meno, priezvisko, datum_sk
from os_udaje o, student s, zap_predmety zp
where o.rod_cislo = s.rod_cislo
  and s.os_cislo = zp.os_cislo
  and to_char(datum_sk, 'MM-YYYY') = to_char(sysdate,'MM-YYYY');