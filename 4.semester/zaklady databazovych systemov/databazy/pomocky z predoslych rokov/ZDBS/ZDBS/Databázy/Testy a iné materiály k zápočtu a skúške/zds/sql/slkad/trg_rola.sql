CREATE OR REPLACE TRIGGER tab_rola_ins
  BEFORE INSERT ON rola
  REFERENCING NEW AS novy
  FOR EACH ROW
BEGIN
  SELECT nvl(max(rola.id)+1,1) INTO :novy.id FROM rola;
END;

/
