create or replace procedure Vloz_predmet
(v_cp   IN  predmet.cis_predm%type,
v_nazov  IN predmet.nazov%TYPE)
AS
BEGIN
insert INTO predmet
values (v_cp,v_nazov);
EXCEPTION
WHERE unique_constraint then dbms_output.put_line ('Zaznam s takymto klucom existuje');
END;
/

show error;