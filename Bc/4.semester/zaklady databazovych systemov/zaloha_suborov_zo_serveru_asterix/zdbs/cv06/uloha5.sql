SELECT pr.nazov
FROM predmet pr
JOIN zap_predmety zp ON (zp.cis_predm = pr.cis_predm)
JOIN student st ON (st.os_cislo = zp.os_cislo)
WHERE zp.skrok = 2006
HAVING(count(st.os_cislo) >= 4)
GROUP BY pr.nazov;