set serveroutput on
create or replace procedure zmen_cislo
(v_rod_cislo in kontaktne_udaje.rod_cislo%type,
v_tel_cislo in kontaktne_udaje.tel_C%type)
is
begin
	update kontaktne_udaje
	set tel_c=v_tel_cislo
	where rod_cislo=v_rod_cislo;
	exception
		when others then
			dbms_output.put_line('Chybne zadane parametre');
end;
/