
SELECT os.meno, os.priezvisko
FROM os_udaje os
JOIN student st ON (st.rod_cislo = os.rod_cislo)
JOIN zap_predmety zp ON (zp.os_cislo = st.os_cislo)
GROUP BY os.meno, os.priezvisko
HAVING (avg(DECODE(zp.vysledok, 'A', 1, 'B', 1.5, 'C', 2, 'D', 2.5, 'E', 3, 4) ) < 3);

--agregacna funkcia sa nedava do WHERE ale do HAVING