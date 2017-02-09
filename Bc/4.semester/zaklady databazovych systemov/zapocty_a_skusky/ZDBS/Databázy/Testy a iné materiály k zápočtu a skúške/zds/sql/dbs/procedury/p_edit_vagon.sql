CREATE OR REPLACE PROCEDURE edit_vagon
		    (p_cislo_vagonu IN vagon.cislo_vagonu%TYPE,
		     p_tv_id IN vagon.tv_id%TYPE,
		     p_radenie IN vagon.radenie%TYPE,
		     p_vl_cislo_vlaku IN vagon.vl_cislo_vlaku%TYPE
		    )
IS 
BEGIN 

IF p_cislo_vagonu IS NOT NULL THEN

    IF p_tv_id IS NOT NULL THEN
        UPDATE vagon SET tv_id=p_tv_id
	WHERE cislo_vagonu=p_cislo_vagonu;
    END IF;
    
    IF p_radenie IS NOT NULL THEN
        UPDATE vagon SET radenie=p_radenie
	WHERE cislo_vagonu=p_cislo_vagonu;
    END IF;
    
    IF p_vl_cislo_vlaku IS NOT NULL THEN
        UPDATE vagon SET vl_cislo_vlaku=p_vl_cislo_vlaku
	WHERE cislo_vagonu=p_cislo_vagonu;
    END IF;

END IF;
END;
/
	