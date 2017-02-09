SELECT priezvisko, meno
FROM os_udaje
JOIN student
USING (rod_cislo)
JOIN zap_predmety
USING(os_cislo)
WHERE cis_predm LIKE 'BI06'
ORDER BY priezvisko;