create or replace procedure vloz_zam
	(v_os_cislo in zamestnanec.os_cislo_zam%type,
	v_rod_cislo in zamestnanec.rod_cislo%type)
is
begin 
	insert into zamestnanec(os_cislo_zam, rod_cislo)
	values(v_os_cislo, v_rod_cislo);
	exception
		when dup_val_on_index then
			dbms_output.put_line('Tato osoba uz je zamestnancom');
		when others then
			dbms_output.put_line('Chybne zadane parametre');

	
end;
/