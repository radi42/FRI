SELECT meno, priezvisko
FROM os_udaje
JOIN student
USING (rod_cislo)
WHERE(rocnik = 2);
