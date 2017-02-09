CREATE OR REPLACE TRIGGER tab_sklad_ins
  BEFORE INSERT ON sklad
  REFERENCING NEW AS novy
  FOR EACH ROW
BEGIN
  SELECT nvl(max(sklad.id)+1,1) INTO :novy.id FROM sklad;
END;

/
