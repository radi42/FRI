LOAD DATA
INFILE 'load_rezervacia.unl'
INTO TABLE sem_rezervacia
FIELDS TERMINATED BY '|'
(
    datum_rezervacie,
    id_predmetu,
    id_citatela,
    datum_konca_rez
)
