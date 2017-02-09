
LOAD DATA
 INFILE 'l_mesto.unl'
 INTO TABLE l_mesto
FIELDS TERMINATED BY '|'
(
 PSC,
 ID_KRAJINY,
 NAZOV  
)

