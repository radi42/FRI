commit;

SELECT * FROM os_udaje
WHERE meno = 'Karol';

UPDATE os_udaje
SET priezvisko = 'Stary'
WHERE meno = 'Karol' AND priezvisko = 'Novy';

SELECT * FROM os_udaje
WHERE meno = 'Karol';

rollback;