commit;

--pred apdejtom

SELECT os.meno, os.priezvisko, st.os_cislo
FROM os_udaje os
JOIN student st ON(st.rod_cislo = os.rod_cislo)
WHERE st.os_cislo = 8;



--studentovi, ktory ma osobne cislo 8 zmen meno na Carlos

UPDATE os_udaje
SET meno = 'Carlos'
WHERE os_udaje.rod_cislo IN(	SELECT student.rod_cislo FROM student
					WHERE os_cislo = 8);
--Poznamka:
--ak chcem apdejtnut atribut v jednej tabulke na zaklade udajov v inej tabulke
--musim za klauzulov WHERE uviest taky atribut, ktory maju obidve tabulky rovnaky;
--v nasom pripade je to rodne cislo



--kontrola

SELECT os.meno, os.priezvisko, st.os_cislo
FROM os_udaje os
JOIN student st ON(st.rod_cislo = os.rod_cislo)
WHERE st.os_cislo = 8;

rollback;