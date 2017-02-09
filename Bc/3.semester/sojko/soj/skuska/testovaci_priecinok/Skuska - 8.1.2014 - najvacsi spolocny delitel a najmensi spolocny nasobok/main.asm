TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
Sprava0 DB " " ,0dh,0ah,0				; odriadkovanie
Sprava1 DB "------------ GCD, LCM - Eukvidov algoritmus ------------",0dh,0ah,0				; informacie pre pouzivatela
Sprava2 DB "Zadajte 2 prirodzene cisla u>=v, v tvare u [enter], v [enter]",0dh,0ah,0
Sprava3 DB "GCD:",0dh,0ah,0
Sprava4 DB "LCM:",0dh,0ah,0


aU DB 0												; Premennne
aV DB 0

aU1 DB 0											; pomocné premenné
aV1 DB 0

MenoSub DB 'GCD.txt',0								; Relatívna cesta k súboru... bude tam, kde aj projekt
PocetZnakov DD 1									; Ostatné potrebné premenné na zápis (neviem čo robia)
FileHandle DD ?
PocetBytov DD ?



.code

Nacitaj PROC										; procedúra má nastarosti načítanie hodnôt

	mov EDX, offset Sprava1							; zobrazenie Informície na konzolu
	call WriteString

	mov EDX, offset Sprava2
	call WriteString

	call ReadInt									; nacita vstup typu Int, ulozi do EAX
	mov aU, AL										; Hodnotu uložím do premennej
	mov aU1, AL										; a aj do pomocnej premennej
		
	call ReadInt
	mov aV, AL
	mov aV1, AL


	ret
Nacitaj ENDP


Eukvid PROC											; Procedúra je prvá časť úlohy - Eukvidov algoritmus. Po vykonaní bude v aU hodnota GCD

	Opakuj:
		mov EAX, 0									; znulovanie
		mov EDX, 0
		cmp aV, 0									; Ak V = 0, tak sa cyklus preruší
		je Break


		mov DL, aV									; T = aV .. T je pomocná premenná, na jej uloženie používam register DL

		mov AL, aU									; vlož obsah au do AL
		div aV										; aU div aV, pročom výsledkom bude v AL podiel a v AH zvyšok po delení
		mov aV, AH									; aV = (aU MOD aV) obsahzátvorky je v AH

		mov aU, DL									; Povocná premenná T sa presunioe do aU

		jmp Opakuj

		Break:

	ret
Eukvid ENDP

Nasobok PROC										; Procedúra vypočíta najmensi spolocny nasobok - 2. cast ulohy, vysledok bude LCM v AL

	mov AL, aU1										; do Al vložím hodnotu z pomocnej premennej
	mul aV1											; Vynásobím aU1 a aV1, výsledok bude v AX
	div aU											; vydelím obsah AX hodnotou GCD

	ret
Nasobok ENDP


otvorSubor PROC										; 2 procedúry sa starajú o zápis do súvoru - 3. cast ulohy
	push NULL	
	push FILE_ATTRIBUTE_NORMAL	
	push CREATE_ALWAYS
	push NULL
	push 0; nezdieľať
	push GENERIC_WRITE
	push offset MenoSub
	call CreateFileA 
	mov FileHandle,eax; odlož popisovač
	ret
otvorSubor ENDP

zapisDoSuboru PROC
	push NULL
	push offset PocetBytov
	push PocetZnakov
	push offset aU
	push FileHandle
	call WriteFile
	; zatvor súbor
	push FileHandle
	call CloseHandle
	ret
zapisDoSuboru ENDP



main PROC
	call Clrscr

	call Nacitaj

	mov EDX, offset Sprava3							; Informujem čo idem vypísať
	call WriteString

	call Eukvid

	mov EAX, 0										; znulujem EAX aby sa mi nezmenila hodnota
	mov AL, aU										; Presuniem GCD do AL
	call WriteInt									; Vypisem obsah EAX

	mov EDX, offset Sprava0							; odriadkovanie
	call WriteString

	mov EDX, offset Sprava4
	call WriteString

	mov EAX, 0
	call Nasobok									
	mov AH, 0										; Znulujem nepotrebnú čast, v Al mám LCM
	call WriteInt

	mov EDX, offset Sprava0							; odriadkovanie
	call WriteString

	call otvorSubor									; zavolanie zápisu do súboru
	call zapisDoSuboru

	exit
main ENDP

END main