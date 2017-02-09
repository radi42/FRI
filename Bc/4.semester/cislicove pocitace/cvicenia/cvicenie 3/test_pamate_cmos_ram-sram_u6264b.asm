;Najprv program zapise do kazdeho bloku 
;pamate hodnotu ulozenu v registri a
;Potom program precita hodnotu z kazdeho
;bloku a porovna ju s konstantou, ktoru sme
;si na zaciatku ulozili do registra a
;Ak sa vyskytne chyba, zvysi sa pocitadlo
;a tedapamat je chybna (skontrolovat 
;zapojenie alebo vymenit pamatovy modul)
;Na obrazovke sa vypise text 'KO' a 
;program sa ukonci
;Ak sa nevyskytne ziadna chyba, potom je
;pamat v poriadku a na obrazovke sa vypise
;text 'OK' a program sa ukonci

mvi a,0xAA		;co zapisujeme do pamatovej bunky
mxi m,0x0000	;prva adresa pamate

CyklusZapis:
	mvx c,m
	cmi c,0x20
	jzr VynulujA

	smr a
	inx m

	jmp CyklusZapis

VynulujA:
	mvi a,0x00		;teraz vynuluj register a, pouzijeme ho ako pocitadlo chyb
	jmp CyklusCitaj

CyklusCitaj:
	dcx m

	jcy KontrolujChybu

	lmr b
	
	cmi b,0xAA
	jnz ZvysChybu

	jmp CyklusCitaj

ZvysChybu:
	inc a
	jmp CyklusCitaj

KontrolujChybu:
	cmi a,0x00
	jzr OK
	jmp KO

OK:
	mvi d,0x4F
	scall dsp
	mvi d,0x4B
	scall dsp
	
	jmp Koniec

KO:
	mvi d,0x4B
	scall dsp
	mvi d,0x4F
	scall dsp
	
	jmp Koniec

Koniec: