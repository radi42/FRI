SELECT DISTINCT os_udaje.meno, os_udaje.priezvisko, ADD_MONTHS(sysdate, 1) AS buduci_mesiac, os_udaje.rod_cislo
FROM os_udaje
JOIN student
ON (student.rod_cislo = os_udaje.rod_cislo)
WHERE to_number(to_char(sysdate,'MM'))+1 LIKE MOD(to_number(SUBSTR(os_udaje.rod_cislo,3,2)),50)
AND TO_NUMBER(SUBSTR(os_udaje.rod_cislo, 1, 1)) >= 7;