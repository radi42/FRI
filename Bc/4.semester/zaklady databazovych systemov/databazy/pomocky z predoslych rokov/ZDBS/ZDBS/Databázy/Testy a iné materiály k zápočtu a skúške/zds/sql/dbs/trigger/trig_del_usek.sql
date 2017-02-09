CREATE OR REPLACE TRIGGER trig_del_usek
    BEFORE DELETE on usek
    FOR EACH ROW
BEGIN
    DELETE FROM usek_listka
    WHERE us_id=:old.id;
    
END;
/