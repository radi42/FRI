/*
Funkcia vrati cele meno studenta a studijnu skupinu
*/

set serveroutput on

CREATE OR REPLACE PROCEDURE query_stud
( v_oc IN student.os_cislo%TYPE,
  v_meno OUT VARCHAR2,
  v_skupina OUT student.st_skupina%TYPE)
IS
BEGIN
  SELECT meno||' '|| priezvisko, st_skupina
  INTO v_meno, v_skupina
  FROM student st JOIN os_udaje ou USING (rod_cislo)
  WHERE st.os_cislo = v_oc;
END ;
/

show error;

/*
priklad pouzitia v terminali:
variable p_meno varchar2(30)
variable p_skupina student.st_skupina%TYPE;
execute query_stud(501512, :p_meno, :p_skupina);
*/

declare
  p_os_cislo student.os_cislo%TYPE := 501512;
  p_meno varchar2(30);
  p_skupina student.st_skupina%TYPE;
begin
--este by mohlo byt uzitocne dat to do cyklu nech to vypise kazdeho studenta
    query_stud(p_os_cislo, p_meno, p_skupina);
    dbms_output.put_line(p_meno || ' ' || p_skupina );
  
end;
/