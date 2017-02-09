set serveroutput on
create or replace procedure zrus_zakaznika
(v_os_cislo in zakaznik.os_cislo_zak%type)
is
begin
	delete from zakaznik
	where os_cislo_zak=v_os_cislo;
	exception
		when others then
			dbms_output.put_line('Chybne zadane parametre');
end zrus_zakaznika;
/