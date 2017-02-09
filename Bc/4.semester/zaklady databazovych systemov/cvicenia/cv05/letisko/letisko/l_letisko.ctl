
LOAD DATA
 INFILE 'l_letisko.unl'
 INTO TABLE l_letisko
FIELDS TERMINATED BY '|'
(
 ID_LETISKA     ,
 NAZOV_LETISKA,
 DLZKA_DRAHY,
 ULICA,
 PSC,
 ID_KRAJINY        
)

