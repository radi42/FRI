SET FEEDBACK OFF;
SET VERIFY OFF;


create table listky_km
(pasazier integer not null,
 km2 integer not null);
 
create or replace function priem_km
return number
is

vysledok NUMBER;
begin

    insert into listky_km(
    select usek_listka.l_id, sum(usek.km)
    from usek_listka, usek
    where usek_listka.us_id=usek.id
    group by usek_listka.l_id);
			
    select avg(km2) into vysledok
    from listky_km;
				
    return vysledok;
end priem_km;
/

variable kilometre NUMBER;
execute :kilometre:=priem_km();
print kilometre;
				
drop table listky_km;
				
				