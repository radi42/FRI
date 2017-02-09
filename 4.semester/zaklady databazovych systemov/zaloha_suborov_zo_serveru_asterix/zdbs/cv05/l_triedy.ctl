
LOAD DATA
 INFILE 'l_triedy.unl'
 INTO TABLE l_triedy
FIELDS TERMINATED BY '|'
(
 ID_LETU  ,
 ID_TRIEDY,
 KAPACITA  
)
