
LOAD DATA
 INFILE 'surovina.unl'
 INTO TABLE surovina
FIELDS TERMINATED BY '|'
(
nazov_suroviny,
id_suroviny,
kcal,
tuky,
bielkoviny,
sacharidy
)
