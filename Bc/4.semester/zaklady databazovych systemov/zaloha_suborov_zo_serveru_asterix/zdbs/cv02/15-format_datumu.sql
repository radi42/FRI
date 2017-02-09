SELECT ou.meno, ou.priezvisko, ou.rod_cislo, 
TO_DATE(SUBSTR(ou.rod_cislo, 1, 2) || MOD(TO_NUMBER(SUBSTR(ou.rod_cislo, 3, 1)), 5) || SUBSTR(ou.rod_cislo, 4, 1) || SUBSTR(ou.rod_cislo, 5, 2), 'RRMMDD')
AS datum_narodenia 
FROM os_udaje ou
WHERE TO_NUMBER(SUBSTR(ou.rod_cislo, 1, 1)) >= 7;