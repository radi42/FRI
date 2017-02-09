commit;



--pred apdejtom

SELECT meno, priezvisko, stav
FROM student
JOIN os_udaje ON(os_udaje.rod_cislo = student.rod_cislo)
WHERE stav IS NULL;






--vsetci studenti, ktori nemaju definovany stav, zmen stav na 'S'

UPDATE student
SET stav = 'S'
WHERE stav IS NULL;






--kontrola, ci sa stav studentov zmenil

SELECT meno, priezvisko, stav
FROM student
JOIN os_udaje ON(os_udaje.rod_cislo = student.rod_cislo)
WHERE stav IS NULL;

SELECT os.meno, os.priezvisko, st.stav
FROM os_udaje os
JOIN student st
ON(st.rod_cislo = os.rod_cislo);

rollback;
