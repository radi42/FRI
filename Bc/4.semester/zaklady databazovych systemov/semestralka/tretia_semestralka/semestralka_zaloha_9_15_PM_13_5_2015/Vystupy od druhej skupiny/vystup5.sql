select meno, priezvisko from osoba
join stravnik using (os_cislo) where vaha_zaciatocna - vahaPriebezna >= 5;