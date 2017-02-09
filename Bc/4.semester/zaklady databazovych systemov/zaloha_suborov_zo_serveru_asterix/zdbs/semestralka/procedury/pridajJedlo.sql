create or replace procedure pridajJedlo(
nazov jedlo.nazov_jedla%TYPE,
kateg jedlo.kategoria%TYPE)
is
begin
 insert into jedlo values(NULL, nazov, NULL, kateg);
end;
/

show error;