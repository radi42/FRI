create or replace trigger trig_rod_cislo

before insert or update on osoba

referencing new as novy

for each row

begin
	
      if(substr(:novy.rod_cislo,3,1) != 0 OR

	substr(:novy.rod_cislo,3,1) != 1 OR

	substr(:novy.rod_cislo,3,1) != 5 OR

       substr(:novy.rod_cislo,3,1) != 6)
 
       then
 
	raise_application_error(-20000,'Zadajte spravy format rodneho cisla');
	end if;

end;
/