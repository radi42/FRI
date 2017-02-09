SELECT meno, priezvisko
FROM os_udaje
JOIN student
USING (rod_cislo)
WHERE SUBSTR(st_skupina, 2, 1) = 'P';