SELECT os.meno, os.priezvisko, count(zp.cis_predm)
FROM os_udaje os
JOIN student st ON (st.rod_cislo = os.rod_cislo)
JOIN zap_predmety zp ON (zp.os_cislo = st.os_cislo)
WHERE zp.skrok = 2008
GROUP BY os.meno, os.priezvisko;