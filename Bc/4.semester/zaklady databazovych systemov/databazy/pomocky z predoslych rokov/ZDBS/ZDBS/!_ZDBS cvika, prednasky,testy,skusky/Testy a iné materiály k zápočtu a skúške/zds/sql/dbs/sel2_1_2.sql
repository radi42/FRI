SET VERIFY OFF;
SET FEEDBACK OFF;

CREATE TABLE zoznam_usekov (id NUMBER, cislo_v number, mcl number);

CREATE TABLE vytazenie_vagonov(us_id NUMBER, v_cislo_vagonu NUMBER, pocet NUMBER, pocet_miest NUMBER);

CREATE OR REPLACE PROCEDURE kup_listok
    (
     p_cislo_vlaku IN usek.vl_cislo_vlaku%TYPE,
     p_od IN stanica.nazov%TYPE,
     p_do IN stanica.nazov%TYPE,
     p_kedy IN listky.datum%TYPE,
     p_typ_vagonu IN typ_vagonu.id%TYPE, 
     p_zakupene IN listky.zaplatene%TYPE  
    )
IS
    stanica_od NUMBER;
    stanica_do NUMBER;
    start_od varchar2(5);
    stop_do  varchar2(5);
    max_cislo_listka NUMBER;
    cislo_vagonu NUMBER;
BEGIN
    SELECT stanica.id into stanica_od FROM stanica
	 WHERE stanica.nazov=p_od;

    SELECT stanica.id into stanica_do FROM stanica
	 WHERE stanica.nazov=p_do;
	 
    SELECT usek.us_start into start_od FROM usek
	 WHERE usek.vl_cislo_vlaku=p_cislo_vlaku
	 AND usek.s_id=stanica_od;
	  
    SELECT usek.stop into stop_do FROM usek
	 WHERE usek.vl_cislo_vlaku=p_cislo_vlaku
	 AND usek.s_id_konci_v=stanica_do;
	 
    INSERT INTO zoznam_usekov(ID)
	(SELECT usek.id FROM usek
	 WHERE usek.vl_cislo_vlaku=p_cislo_vlaku
	 AND  usek.us_start>=start_od
	 AND  usek.stop<=stop_do
	); 
	
    SELECT max(NVL(id,0))+1 into max_cislo_listka FROM listky;
    
    INSERT INTO listky
    VALUES(max_cislo_listka ,stanica_od, stanica_do,to_date(p_kedy,'DD-MM-YYYY'),p_zakupene);

    INSERT INTO vytazenie_vagonov
    (SELECT us_id, v_cislo_vagonu, count(*) pocet, pocet_miest
     FROM usek_listka, vagon, typ_vagonu
     WHERE us_id IN (SELECT id FROM zoznam_usekov)
     AND usek_listka.v_cislo_vagonu=vagon.cislo_vagonu
     AND vagon.vl_cislo_vlaku=p_cislo_vlaku
     AND vagon.tv_id=p_typ_vagonu
     AND typ_vagonu.id=vagon.tv_id
     GROUP BY us_id, v_cislo_vagonu,pocet_miest);
     
    SELECT max(v_cislo_vagonu) into cislo_vagonu FROM vytazenie_vagonov
     WHERE v_cislo_vagonu NOT IN 
        (SELECT v_cislo_vagonu 
	 FROM vytazenie_vagonov 
	 WHERE pocet>=pocet_miest);

    UPDATE zoznam_usekov SET cislo_v = cislo_vagonu, mcl = max_cislo_listka;
	 
    INSERT INTO usek_listka
    (SELECT * FROM zoznam_usekov);  
    
END;
/


EXECUTE kup_listok(&CISLO_VLAKU, '&STANICA_OD', '&STANICA_DO','&KEDY', &TYP_VAGONU, '''&ZAKUPENE''');

DROP TABLE zoznam_usekov;
DROP TABLE vytazenie_vagonov;