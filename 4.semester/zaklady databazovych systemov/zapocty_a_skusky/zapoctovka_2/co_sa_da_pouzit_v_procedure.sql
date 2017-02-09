create or replace procedure selektuj(p_zam integer)
as
pocet integer;
zamestnanec integer;
begin
--A,B
/*
select count(*) into pocet
from l_zamestnanec
--group by id_zamestnanca;
where id_zamestnanca = p_zamestnanec;
*/

--C
select nvl(max(id_zamestnanca),0) into zamestnanec
from l_zamestnanec
where id_zamestnanca = p_zam;
end;
/

--kedze Bcko nefunguje, Dcko tiez nebude

show error;
