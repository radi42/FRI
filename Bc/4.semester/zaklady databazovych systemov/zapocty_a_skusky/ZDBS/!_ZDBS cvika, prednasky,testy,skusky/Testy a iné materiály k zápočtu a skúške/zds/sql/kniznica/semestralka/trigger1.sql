-- triger pre vymazanie klucovych slov ak sa vymaze predmet

CREATE OR REPLACE TRIGGER vymazanie_klucovych_slov
BEFORE DELETE ON sem_predmet
REFERENCING OLD AS stare
FOR EACH ROW
BEGIN
 DELETE FROM sem_klucove_slova WHERE id_predmetu LIKE :stare.id_predmetu;
END;
/

-- pri zmene id_predmet v sem_predmet

CREATE OR REPLACE TRIGGER zmena_id_v_sem_predmet
BEFORE UPDATE ON sem_predmet
REFERENCING OLD AS stare NEW AS nove
FOR EACH ROW
BEGIN
 UPDATE sem_predmet_autor SET id_predmetu=:nove.id_predmetu WHERE
id_predmetu=:stare.id_predmetu;
 UPDATE sem_klucove_slova SET id_predmetu=:nove.id_predmetu WHERE
id_predmetu=:stare.id_predmetu;
 UPDATE sem_rezervacia SET id_predmetu=:nove.id_predmetu WHERE
id_predmetu=:stare.id_predmetu;
 UPDATE sem_pozicka SET id_predmetu=:nove.id_predmetu WHERE
id_predmetu=:stare.id_predmetu;
END;
/

-- pri zmazani citatela sa zmau aj jeho kontakty

CREATE OR REPLACE TRIGGER vymazanie_kontaktov
BEFORE DELETE ON sem_citatel
REFERENCING OLD AS stare
FOR EACH ROW
BEGIN
 DELETE FROM sem_kontakt WHERE id_citatela=:stare.id_citatela;
END;
/

-- pri zmene id_citatela v sem_citatel

CREATE OR REPLACE TRIGGER zmena_id_sem_citatel
BEFORE UPDATE ON sem_citatel
REFERENCING OLD AS stare NEW AS nove
FOR EACH ROW
BEGIN
 UPDATE sem_kontakt SET id_citatela=:nove.id_citatela WHERE
id_citatela=:stare.id_citatela;
 UPDATE sem_rezervacia SET id_citatela=:nove.id_citatela WHERE
id_citatela=:stare.id_citatela;
 UPDATE sem_pozicka SET id_citatela=:nove.id_citatela WHERE
id_citatela=:stare.id_citatela;
END;
/

-- datum pozicky nemoze byt vacsi ako datum pred_vratenia alebo datum_vra

CREATE OR REPLACE TRIGGER kontrola_datumov
BEFORE INSERT OR UPDATE ON sem_pozicka
REFERENCING NEW AS nove
FOR EACH ROW
WHEN ((nove.datum_pozicky > nove.datum_pred_vratenia)
OR (nove.datum_pozicky > nove.datum_vratenia))
BEGIN
 RAISE_APPLICATION_ERROR(-20000,'CHYBA - DATUMY');
END;
/

-- vratenie vypozicanych predmetov

CREATE OR REPLACE TRIGGER vratenie_predmetov
BEFORE DELETE ON sem_pozicka
REFERENCING OLD AS stare
FOR EACH ROW 
BEGIN
 
END;
/

show err;