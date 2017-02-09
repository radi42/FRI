LOAD DATA
INFILE 'load_kontakt.unl'
INTO TABLE sem_kontakt
FIELDS TERMINATED BY '|'
(
    id_kontakt ,
    id_citatela,
    typ_kontaktu,
    kontakt
)
