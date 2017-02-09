LOAD DATA
INFILE 'load_predmet_autor.unl'
INTO TABLE sem_predmet_autor
FIELDS TERMINATED BY '|'
(
    id_predmetu,
    id_autor
)
