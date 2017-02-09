SELECT os_udaje.priezvisko, predmet.nazov
FROM predmet
JOIN zap_predmety
ON (zap_predmety.cis_predm = predmet.cis_predm)
JOIN student
ON (student.os_cislo = zap_predmety.os_cislo)
JOIN os_udaje
ON (os_udaje.rod_cislo = student.rod_cislo)
WHERE priezvisko = 'Balaz';