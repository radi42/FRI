LOAD DATA
INFILE 'jedlo.unl'
INTO TABLE jedlo
FIELDS TERMINATED BY '|'
(
id_jedla,
nazov_jedla,
kalorie_jedla,
kategoria
)