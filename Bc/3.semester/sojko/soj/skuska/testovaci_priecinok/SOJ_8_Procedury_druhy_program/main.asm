TITLE MASM Template(main.asm)

INCLUDE Irvine32.inc
.data
Pole DB 0,1,2,3,4 
Dlzka DD $-Pole
Cislo EQU 1

.code
Pripocitaj PROC pascal paOffset, paDlzka, paCislo:byte
	mov ebx, paOffset
	mov ecx, paDlzka
	mov al, paCislo
Cyklus:
	add [ebx], al

	;skoda, ze to vypisuje adresu v pamati a nie prvok z pola
	mov eax, ebx
	call WriteInt

	mov al, 0Dh
	call WriteChar
	mov al, 0Ah
	call WriteChar

	inc ebx
	loop cyklus
	ret
Pripocitaj ENDP
;prekladac automaticky doplni ramec zasobnika
;push ebp
;mov ebp, esp
;a na konci procedury
;leave
;ret 0Ch

main PROC

Odriadkuj MACRO
	mov al, 0Dh
	call WriteChar
	mov al, 0Ah
	call WriteChar
ENDM
;Formalne parametre a specifikacia jazyka
;Pri deklaracii procedury v direktive PROC mozeme
;parametrom procedury priradit symbolicke mena.
;Potom k parametrom mozeme pristupovat pomocou 
;tychto mien, a nie cez nepriamu adresu s registrom EBP

;Vyhody:
;-citatelnejsi kod procedury
;-nemusime si pamatat vzialenost parametrov od
;vrcholu zasobnika

;Kazdemu formalnemu parametru mozeme predpisat typ
;Ak neuvedieme typ parametra, predpoklada sa dword

;Specifikacia programovacieho jazyka pri volani
;procedury

;Jazyk			parametre sa ukladaju	parametre vyberie
;				do zasobnika			zo zasobnika
;------------------------------------------------------------
;pascal			zlava doprava			procedura (v prikaze ret n)
;basic
;fortran

;C				sprava dolava			volajuci program (add, sp.n)
;Prolog

;stdcall			sprava dolava			procedura
;(v 32-bit
;aplikaciach,
;pri volani
;sluzieb 
;Windows)

	push offset Pole
	push Dlzka  
	push Cislo  
	call Pripocitaj
	add esp, 0Ch
	exit
main ENDP
END main