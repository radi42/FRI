LOAD DATA
INFILE 'typ_bankovky.unl'
INTO TABLE typ_bankovky
FIELDS TERMINATED BY '|'
(
 HODNOTA
 ,MENA
)

