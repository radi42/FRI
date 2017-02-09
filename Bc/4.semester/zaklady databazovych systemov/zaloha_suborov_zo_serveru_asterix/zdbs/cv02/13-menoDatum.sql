SELECT os_udaje.meno, os_udaje.priezvisko,
TO_DATE(SUBSTR(os_udaje.rod_cislo, 1, 2) || MOD(TO_NUMBER(SUBSTR(os_udaje.rod_cislo, 3, 1)), 5) || SUBSTR(os_udaje.rod_cislo, 4, 1) || SUBSTR(os_udaje.rod_cislo, 5, 2), 'YYMMDD')
AS datum_narodenia, os_udaje.rod_cislo
FROM os_udaje
JOIN student
ON (student.rod_cislo = os_udaje.rod_cislo)
WHERE TO_NUMBER(SUBSTR(os_udaje.rod_cislo, 1, 1)) >= 7; --tuto podmienku som tam musel pridat, pretoze sme do databazy pridali studenta Karol Novy, Karol Novsi atd. a tito maju divne rodne cisla. A kedze sa datum pocita v milisekundach od roku 1970, treba porovnavat prvy znak rodneho cisla s podmienkou, ci je vacsie alebo rovne 7