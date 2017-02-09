LOAD DATA
INFILE 'load_autor.unl'
INTO TABLE sem_autor
FIELDS TERMINATED BY '|'
(
    id_autor,
    meno,
    priezvisko
)
