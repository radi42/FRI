Zoznam studentov podla kriterii :

SELECT * FROM
	osoba, narodnost, obec, okres, kraj, stat, osobne_cisla, student, stud_program, pracovisko
WHERE
	osoba.rod_cislo = osobne_cisla.rod_cislo
	AND student.os_cislo = osobne_cisla.os_cislo
	AND osoba.statna_prislusnost = narodnost.id_nar
	AND osoba.obec = obec.id_obec
	AND obec.id_okres = okres.id_okres
	AND okres.id_kraj = kraj.id_kraj
	AND kraj.id_stat = stat.id_stat
	AND student.id_zameranie = stud_program.id_zameranie
	AND student.id_stud_prog = stud_program.id_stud_prog
	AND pracovisko.id_student = student.id_student

	AND student.studijna_skupina = $STUD_SKUP
	AND student.rocnik = $ROCNIK
	AND pracovisko.nazov like '$PRACOVISKO'


Pocet studentov podla stud. skupiny : 
SELECT count(*) FROM 
		student
WHERE	
	sk_rok = $SK_ROK	
GROP BY studijna_skupina
	