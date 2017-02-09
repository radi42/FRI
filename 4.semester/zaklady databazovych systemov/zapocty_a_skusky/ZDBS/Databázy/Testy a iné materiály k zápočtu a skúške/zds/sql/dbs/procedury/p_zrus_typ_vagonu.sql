CREATE OR REPLACE PROCEDURE zrus_typ_vagonu
			(p_id IN typ_vagonu.id%TYPE
			)
IS
BEGIN
    DELETE FROM typ_vagonu 
    WHERE typ_vagonu.id=p_id;
END;			
/