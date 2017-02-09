CREATE OR REPLACE PROCEDURE zrus_vlak
			(p_cislo_vlaku IN vlak.cislo_vlaku%TYPE
			)
IS
BEGIN
    DELETE FROM vlak
    WHERE vlak.cislo_vlaku=p_cislo_vlaku;
END;			
/