LOAD DATA
INFILE 'bankovky_v_bankomate.unl'
INTO TABLE bankovky_v_bankomate
FIELDS TERMINATED BY '|'
(
 ID_BANKOMATU
 ,HODNOTA
 ,MENA
 ,POCET_BANK
)