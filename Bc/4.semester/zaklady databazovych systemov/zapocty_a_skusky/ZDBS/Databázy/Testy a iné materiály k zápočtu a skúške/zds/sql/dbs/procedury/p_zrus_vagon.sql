CREATE OR REPLACE PROCEDURE zrus_vagon
			(p_cislo_vagonu IN vagon.cislo_vagonu%TYPE
			)
IS
BEGIN
    DELETE FROM vagon
    WHERE vagon.cislo_vagonu=p_cislo_vagonu;
END;			
/