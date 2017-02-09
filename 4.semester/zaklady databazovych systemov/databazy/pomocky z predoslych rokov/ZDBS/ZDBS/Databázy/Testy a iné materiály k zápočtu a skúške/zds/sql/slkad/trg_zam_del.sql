CREATE OR REPLACE TRIGGER tab_zamestnanec_del
  BEFORE DELETE
  ON zamestnanec
  REFERENCING OLD AS stary
  FOR EACH ROW
  DECLARE
    vystup DATE;
BEGIN
  SELECT nvl(:stary.dat_vystupu,sysdate) INTO vystup
  FROM zamestnanec;

  INSERT INTO zamestnanec (id,rodne_cislo,meno,priezvisko,ulica,obec,psc,
                           dat_nastupu,dat_vystupu,heslo,skl_id)
  VALUES (:stary.id,:stary.rodne_cislo,:stary.meno,:stary.priezvisko,
          :stary.ulica,:stary.obec,:stary.psc,:stary.dat_nastupu,vystup,
          :stary.heslo,:stary.skl_id);
END;

/
