select meno, priezvisko from osoba
join sport using (os_cislo) 
where id_druhSportu = 3;