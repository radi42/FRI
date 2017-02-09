variable VYTAZENOST_VLAKU NUMBER;

create or replace FUNCTION vytazenost(
                           id_vlaku IN vlak.cislo_vlaku%TYPE,
			   od listky.datum%TYPE,
			   do listky.datum%TYPE)
RETURN NUMBER
IS
  pocet NUMBER;
  kapacita NUMBER;
BEGIN
  select count(listky.id) into pocet
  from listky, usek_listka, vagon, vlak
  where listky.id=usek_listka.l_id
  and usek_listka.v_cislo_vagonu=vagon.cislo_vagonu
  and vagon.vl_cislo_vlaku=vlak.cislo_vlaku
  and vlak.cislo_vlaku=id_vlaku
  and listky.zaplatene='''A'''
  and listky.datum between od and do;

  select (sum(typ_vagonu.pocet_miest) * (to_date(do,'DD-MM-YYYY') - to_date(od,'DD-MM-YYYY') + 1)) 
  into kapacita
  from usek, vagon, typ_vagonu, vlak
  where usek.vl_cislo_vlaku=id_vlaku
  and usek.vl_cislo_vlaku=vlak.cislo_vlaku
  and vagon.vl_cislo_vlaku=vlak.cislo_vlaku
  and vagon.tv_id=typ_vagonu.id;

  RETURN pocet/kapacita;
END vytazenost;
/		      

EXECUTE :VYTAZENOST_VLAKU:=vytazenost(&ID_VLAKU,'&CAS_OD','&CAS_DO');

print VYTAZENOST_VLAKU;