/*
procedura, ktora dokaze pridat studentovi platny predmet
*/

create or replace procedure zapis_predmet
( oc student.os_cislo%TYPE,
  cp predmet.cis_predm%TYPE,
  rok zap_predmety.skrok%TYPE
)
AS
  pocet integer;
BEGIN

  SELECT count(*) INTO pocet
  FROM student
  WHERE student.os_cislo = oc;

  IF (pocet = 0) THEN
  RAISE_APPLICATION_ERROR(-20000, 'Student neexistuje');
  END IF;

  SELECT count(*) INTO pocet
  FROM predmet
  WHERE cis_predm = cp;

  IF (pocet = 0) THEN
  RAISE_APPLICATION_ERROR(-20001, 'Predmet neexistuje');
  END IF;

  SELECT count(*) INTO pocet
  FROM predmet_bod
  WHERE cis_predm = cp AND skrok = rok;

  IF (pocet = 0) THEN
  RAISE_APPLICATION_ERROR(-20002, 'Predmet neexistuje v danom roku');
  END IF;

  INSERT INTO zap_predmety (os_cislo, cis_predm, skrok, prednasajuci, ects)
  SELECT oc, cp, rok, garant, ects
  FROM predmet_bod
  WHERE cis_predm = cp AND skrok = rok;

END;
/

show error;