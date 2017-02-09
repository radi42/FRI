LOAD DATA
INFILE 'typ_bankomatu.unl'
INTO TABLE typ_bankomatu
FIELDS TERMINATED BY '|'
(
 TYP_BANKOMATU
 ,VYROBCA
 ,MODEL
 ,POPIS
)

