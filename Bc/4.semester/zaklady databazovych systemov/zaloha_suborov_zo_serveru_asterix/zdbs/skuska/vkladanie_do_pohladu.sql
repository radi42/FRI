/*
CREATE OR REPLACE VIEW pohl6 (pmeno, ppriezvisko, prod_cislo)
AS
SELECT meno, priezvisko, rod_cislo
FROM os_udaje
WHERE meno LIKE 'S%';
*/

CREATE OR REPLACE VIEW pohlou (meno, priezvisko)
AS
SELECT meno, priezvisko
FROM os_udaje
WHERE meno LIKE 'P%';
