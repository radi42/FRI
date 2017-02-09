SELECT os_udaje.meno, os_udaje.priezvisko,
floor(months_between(
sysdate, 
TO_DATE(SUBSTR(os_udaje.rod_cislo, 1, 2) || MOD(TO_NUMBER(SUBSTR(os_udaje.rod_cislo, 3, 1)), 5) || SUBSTR(os_udaje.rod_cislo, 4, 1) || SUBSTR(os_udaje.rod_cislo, 5, 2), 'RRMMDD')) 
/12)
AS vek, os_udaje.rod_cislo
FROM os_udaje
JOIN student
ON (student.rod_cislo = os_udaje.rod_cislo)
WHERE student.rocnik = '2' AND TO_NUMBER(SUBSTR(os_udaje.rod_cislo, 1, 1)) >= 7;