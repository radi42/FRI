SELECT os.meno, os.priezvisko
FROM os_udaje os
JOIN student st ON (st.rod_cislo = os.rod_cislo)
JOIN zap_predmety zp ON (zp.os_cislo= st.os_cislo)
HAVING(count(cis_predm) >= 2)
GROUP BY os.meno, os.priezvisko;