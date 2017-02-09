LOAD DATA
INFILE 'zamestnanec.unl'
INTO TABLE zamestnanec
FIELDS TERMINATED BY '|'
(
 OS_CISLO_ZAM
 ,ROD_CISLO
)

