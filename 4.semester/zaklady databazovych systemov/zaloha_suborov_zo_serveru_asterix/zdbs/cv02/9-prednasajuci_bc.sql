SELECT meno, priezvisko
FROM ucitel
JOIN zap_predmety
ON(ucitel.os_cislo = zap_predmety.prednasajuci)
JOIN student
ON(student.os_cislo = zap_predmety.os_cislo)
WHERE st_odbor BETWEEN 100 AND 199;