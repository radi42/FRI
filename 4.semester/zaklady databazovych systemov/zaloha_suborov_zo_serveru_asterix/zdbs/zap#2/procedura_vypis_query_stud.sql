declare
  p_meno varchar2(30);
  p_skupina student.st_skupina%TYPE;
begin
  query_stud(501512, p_meno, p_skupina);
  dbms_output.put_line('Meno:	 ' || p_meno);
  dbms_output.put_line('Skupina: ' || p_skupina);
end;
/