CREATE OR REPLACE PROCEDURE zrus_usek_listka
			(p_us_id IN usek_listka.us_id%TYPE,
			 p_v_cislo_vagonu IN usek_listka.v_cislo_vagonu%TYPE,
			 p_l_id IN usek_listka.l_id%TYPE
			)
IS
BEGIN
    DELETE FROM usek_listka
    WHERE 	us_id=p_us_id
    AND		v_cislo_vagonu=p_v_cislo_vagonu
    AND		l_id=p_l_id;
END;			
/