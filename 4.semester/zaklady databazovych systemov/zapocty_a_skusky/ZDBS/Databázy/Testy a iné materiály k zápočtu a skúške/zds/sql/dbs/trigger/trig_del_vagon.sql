CREATE OR REPLACE TRIGGER trig_del_vagon
    BEFORE DELETE on vagon
    FOR EACH ROW
BEGIN
    DELETE FROM usek_listka
    WHERE v_cislo_vagonu=:old.cislo_vagonu;

END;
/