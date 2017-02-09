set serveroutput on

create or replace procedure zapis_predmet
(
  oc student.os_cislo%TYPE,
  cp predmet.cis_predm%TYPE,
  rok zap_predmety.skrok%TYPE
)
AS
  err1 EXCEPTION;
  err2 EXCEPTION;
  err3 EXCEPTION;
  pocet integer;
BEGIN

SELECT count(*) INTO pocet
FROM student
WHERE os_cislo = oc;

IF (pocet = 0) THEN
RAISE err1;
END IF;

SELECT count(*) INTO pocet
FROM predmet
WHERE cis_predm = cp;

IF (pocet = 0) THEN
RAISE err2;
END IF;

SELECT count(*) INTO pocet
FROM predmet_bod
WHERE cis_predm = cp AND skrok = rok;

IF(pocet = 0) THEN
RAISE err3;
END IF;

INSERT INTO zap_predmety(os_cislo, cis_predm, skrok, prednasajuci, ects)
SELECT oc, cp, rok, garant, ects
FROM predmet_bod
WHERE cis_predm = cp AND skrok = rok;

EXCEPTION
WHEN err1 THEN
  dbms_output.put_line('Not existing student');
WHEN err2 THEN
  dbms_output.put_line('Not existing subject');
WHEN err3 THEN
  dbms_output.put_line('Not existing subject for this year');
WHEN others THEN
  dbms_output.put_line('Other error');


END;
/

show error;