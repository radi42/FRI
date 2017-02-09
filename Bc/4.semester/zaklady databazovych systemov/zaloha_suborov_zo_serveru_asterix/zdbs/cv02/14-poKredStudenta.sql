SELECT sum(zap_predmety.ects)
FROM zap_predmety
JOIN student
ON (student.os_cislo = zap_predmety.os_cislo)
WHERE student.os_cislo = 500439;