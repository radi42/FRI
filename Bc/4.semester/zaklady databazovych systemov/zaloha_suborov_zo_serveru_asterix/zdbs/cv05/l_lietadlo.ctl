
LOAD DATA
 INFILE 'l_lietadlo.unl'
 INTO TABLE l_lietadlo
FIELDS TERMINATED BY '|'
(
 ID_LIETADLA ,
 ID_SPOLOCNOSTI,
 ID_TYPU,
 KAPACITA 
)


