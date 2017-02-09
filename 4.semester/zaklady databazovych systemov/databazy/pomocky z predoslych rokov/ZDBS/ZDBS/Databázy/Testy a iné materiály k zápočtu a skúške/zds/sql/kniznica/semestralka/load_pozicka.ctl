LOAD DATA
INFILE 'load_pozicka.unl'
INTO TABLE sem_pozicka
FIELDS TERMINATED BY '|'
(
    datum_pozicky,
    id_predmetu,
    id_citatela,
    datum_pred_vratenia,
    datum_vratenia
)
