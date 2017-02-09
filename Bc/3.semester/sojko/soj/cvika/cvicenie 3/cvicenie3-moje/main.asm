TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
Retaz DB "No nazdar!",0dh,0ah,0 ;typ DB je to iste ako BYTE, bodkociarka je ako zaciatok jednoriadkoveho komentara
znak DB ?; ? - je neinicializovany

.code
main PROC
	call Clrscr; vycisti obrazovku
	
	mov edx, offset Retaz;	uloz do edx adresu 1. znaku retazca
	mov edi, 0; prvy znak ma indexe 0

	call ReadChar; nacita znak do registra al; implicitne adresovanie
	mov znak, al; do premennej znak pridaj hodnotu al
	mov cl, 0; vynuluj pocitadlo znakov
	call WriteChar; vypis hladany znak

	;odriadkuj
	mov al, 0dh
	call WriteChar
	mov al, 0ah
	call WriteChar

	;a este raz odriadkuj, kvoli prehladnosti
	mov al, 0dh
	call WriteChar
	mov al, 0ah
	call WriteChar

	Vypis:
			mov al, [edx+edi]; uloz do al znak na offsete ebx+edi - do al uloz prvy znak premennej Retaz
			cmp al, 0; porovnaj al s nulou
			je Koniec; ak su rovnake, skok na navestie Koniec

			cmp al, znak; porovnaj al so znakom nacitanym z klavesnice
			je Pripocitaj; skoc na navestie pripocitaj
	
	PridajZnakDoRiadkuADokonciVypis:
			;pridaj znak do riadku
			call WriteChar; vypis znak, ktoreho ascii kod je v al
			add al, 1; na tom istom riadku vypisat nasledujuci znak vypisaneho znaku 
			call WriteChar;

			mov al, 0dh; odriadkovat, najprv dat znak do al a potom odriadkovat
			call WriteChar; vrat kurzor na zaciatok
			mov al, 0ah; odriadkuj
			call WriteChar; vypis novy riadok

			;dokonci vypis
			inc edi; zvys index o 1
			jmp Vypis; skoc na zaciatok procedury
	
	Pripocitaj:
			inc cl; ak nastala zhoda znakov znak a al, inkrementuj register cl
			jmp PridajZnakDoRiadkuADokonciVypis

	Koniec:
			;odriadkuj
			mov al, 0dh
			call WriteChar
			mov al, 0ah
			call WriteChar

			;ako vypisat jednociferne cislo
			;cislo sa vypisuje tak, ze k ascii kodu cisla pripocitame ascii kod nuly
			mov al, cl; do registra al prirad pocet zhodnych pismen
			add al, "0"
			call WriteChar; vypis poctu zhod

			;odriadkuj
			mov al, 0dh
			call WriteChar
			mov al, 0ah
			call WriteChar

exit
main ENDP
END main