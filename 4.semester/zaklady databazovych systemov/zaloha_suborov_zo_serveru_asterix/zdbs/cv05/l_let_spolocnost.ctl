LOAD DATA
 INFILE 'l_let_spolocnost.unl'
 INTO TABLE l_let_spolocnost
FIELDS TERMINATED BY '|'
(
 ID_SPOLOCNOSTI,
 NAZOV_SPOL,
 ULICA,
 PSC  ,
 ID_KRAJINY
)
