CREATE OR REPLACE TRIGGER trig_update_vlak
    AFTER UPDATE OF cislo_vlaku ON vlak
    FOR EACH ROW
BEGIN
    UPDATE vagon
    SET vl_cislo_vlaku=:new.cislo_vlaku
    WHERE vl_cislo_vlaku=:old.cislo_vlaku;
    
    UPDATE usek 
    SET vl_cislo_vlaku=:new.cislo_vlaku
    WHERE vl_cislo_vlaku=:old.cislo_vlaku;
    
END;
/