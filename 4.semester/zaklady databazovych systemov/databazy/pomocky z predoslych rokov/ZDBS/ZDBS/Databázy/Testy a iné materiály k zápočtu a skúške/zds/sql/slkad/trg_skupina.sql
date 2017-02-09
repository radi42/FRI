CREATE OR REPLACE TRIGGER tab_skupina_ins
  BEFORE INSERT ON skupina
  REFERENCING NEW AS novy
  FOR EACH ROW
BEGIN
  SELECT nvl(max(skupina.id)+1,1) INTO :novy.id FROM skupina;
END;

/
