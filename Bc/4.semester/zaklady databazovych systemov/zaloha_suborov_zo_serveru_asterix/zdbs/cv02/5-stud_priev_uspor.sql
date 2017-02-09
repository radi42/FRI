SELECT priezvisko, meno
FROM os_udaje
JOIN student
USING (rod_cislo)
WHERE SUBSTR(st_skupina, 2, 1) = 'P'
ORDER BY priezvisko;