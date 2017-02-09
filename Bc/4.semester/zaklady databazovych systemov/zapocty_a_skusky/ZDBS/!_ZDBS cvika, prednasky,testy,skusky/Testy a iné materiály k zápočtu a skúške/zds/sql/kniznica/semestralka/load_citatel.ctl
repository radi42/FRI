LOAD DATA
INFILE 'load_citatel.unl'
INTO TABLE sem_citatel
FIELDS TERMINATED BY '|'
(
    id_citatela,
    meno,
    priezvisko
)
