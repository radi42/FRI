LOAD DATA
INFILE 'zlozenie.unl'
INTO TABLE zlozenie
FIELDS TERMINATED BY '|'
(
id_jedla,
id_suroviny,
pocet_gramov
)