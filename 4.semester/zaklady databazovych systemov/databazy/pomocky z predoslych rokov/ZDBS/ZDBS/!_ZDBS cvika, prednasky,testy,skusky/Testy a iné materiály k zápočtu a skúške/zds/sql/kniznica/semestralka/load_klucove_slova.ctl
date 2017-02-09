LOAD DATA
INFILE 'load_klucove_slova.unl'
INTO TABLE sem_klucove_slova
FIELDS TERMINATED BY '|'
(
    klucove_slovo,
    id_predmetu
)
