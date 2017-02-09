
LOAD DATA
 INFILE 'osoba.unl'
 INTO TABLE osoba
FIELDS TERMINATED BY '|'
(
 os_cislo,
 meno,
 priezvisko,
 vaha_zaciatocna,
 vaha_ciel,
 datum_nastupu DATE 'MM/DD/YYYY',
 datum_narodenia DATE 'MM/DD/YYYY',
 pohlavie,
 tuky_ciel,
 sach_ciel,
 bielk_ciel,
 kcal_ciel
)
