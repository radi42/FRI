LOAD DATA
INFILE 'load_predmet.unl'
INTO TABLE sem_predmet
FIELDS TERMINATED BY '|'
(
    id_predmetu,
    nazov,
    vydavatelstvo,
    typ,
    info,
    nadradeny,
    vyradeny,
    pozicatelny
)
