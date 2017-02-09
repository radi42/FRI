LOAD DATA
INFILE 'kontaktne_udaje.unl'
INTO TABLE kontaktne_udaje
FIELDS TERMINATED BY '|'
(
 ROD_CISLO
 ,TEL_C
 ,EMAIL
)

