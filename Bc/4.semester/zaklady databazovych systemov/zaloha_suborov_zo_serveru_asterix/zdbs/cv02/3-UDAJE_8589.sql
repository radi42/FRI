SELECT meno, priezvisko
FROM os_udaje
JOIN student
USING (rod_cislo)
WHERE TO_NUMBER(SUBSTR(rod_cislo, 1, 2))
BETWEEN 85 AND 89;