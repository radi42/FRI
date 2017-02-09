variable pr NUMBER;

create or replace FUNCTION prijem
RETURN NUMBER
IS
  km usek.km%TYPE;
  priplatky typ_vagonu.priplatok%TYPE;
BEGIN
  select sum(km) into km from usek, usek_listka, listky
  where usek_listka.us_id=usek.id
  and usek_listka.l_id=listky.id
  and listky.zaplatene='''A''';
  
  select sum(priplatok) into priplatky from
  (select typ_vagonu.priplatok
  from listky,usek_listka, vagon, typ_vagonu
  where usek_listka.l_id=listky.id
  and typ_vagonu.id=vagon.tv_id
  and vagon.cislo_vagonu=usek_listka.v_cislo_vagonu
  and listky.zaplatene='''A'''
  group by listky.id, typ_vagonu.priplatok);
  RETURN km+priplatky;
END prijem;
/
			
execute  :pr:=prijem;

print pr;     
 