SELECT count(*)
FROM student
JOIN zap_predmety
ON (zap_predmety.os_cislo = student.os_cislo)
JOIN predmet
ON (predmet.cis_predm = zap_predmety.cis_predm)
WHERE nazov LIKE 'Zaklady databazovych systemov';