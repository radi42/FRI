CREATE OR REPLACE PROCEDURE zrus_typ_vlaku
			(p_id IN typ_vlaku.id%TYPE
			)
IS
BEGIN
    DELETE FROM typ_vlaku 
    WHERE typ_vlaku.id=p_id;
END;			
/