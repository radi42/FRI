LOAD DATA
 INFILE 'l_typ_lietadla.unl'
 INTO TABLE l_typ_lietadla
FIELDS TERMINATED BY '|'
(
 ID_TYPU   ,
 NAZOV ,
 KAPACITA, 
 MIN_PRIST_DRAHA,
 MIN_ODLET_DRAHA
)
