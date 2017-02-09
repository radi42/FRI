CREATE OR REPLACE VIEW pohl6 (vmeno, vpriezvisko, vrod_cislo)
AS
SELECT ou.meno, ou.priezvisko, ou.rod_cislo
FROM os_udaje ou
where ou.meno like 'S%'
WITH CHECK OPTION;
 
INSERT INTO pohl6
VALUES ( 'Stano', 'Stary', '790502/1213');