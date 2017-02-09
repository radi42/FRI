TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
R DB 7 dup(?)
;Postupnost DW 1, 2, 14, -11, 50, 77	;pevne deklarujeme pole
Postupnost DW 20 dup(?)
pocetPrvkov EQU ($-Postupnost)/2		;urcime pocet prvkov postupnosti
VypisIndexMinima DB " index najmensieho prvku je ", 0Dh, 0Ah

.code
Odriadkuj MACRO
		mov al, 0dh
		call WriteChar
		mov al, 0ah
		call WriteChar
ENDM

;procedura na naplnanie pola z klavesnice
NaplnMa PROC
Nacitaj:
	call NacitajCislo
	cmp 
	ret
NaplnMa ENDP

;procedura na najdenie minima
NajdiMin PROC
	mov si, 32767		;docasne minimum
	mov edi, 0
	mov ecx, pocetPrvkov
Porovnaj:
	;cyklus porovnava cisla
	cmp si, Postupnost[2*edi]	;offset v pamati nasobime velkostou jedneho prvku pola
	jl Inkrementuj
	mov si, Postupnost[2*edi]
	mov ebx, edi
Inkrementuj:
	inc edi
	loop Porovnaj
	ret

NajdiMin ENDP

;do hlavicky procedury NacitajCislo sme doplnili registre parametre, ktore ma procedura pouzivat, direktiva pascal
NacitajCislo PROC pascal USES ecx edx edi ebx
	call Clrscr			;vycisti obrazovku

	Odriadkuj

	mov ecx, 20			; dlzka retazca
	mov edx, offset R	;uloz do edx adresu retazca
	call ReadString		;vyziadaj vstup od uzivatela
	mov edi, 0		;nastav edi na nulu
	mov cx, 10		;nastav cx na 10
	xor ax, ax		;vymax cely ax register
	cmp R, '-'		;R je nulty znak pola R
	jne PrevedNaCislo
	inc edi

PrevedNaCislo:
	mov bl, R[edi]	;zober znak do bl
	xor bh, bh		;vymaz hornu polovicu bx
	cmp bl, 0		;porovnaj bl a nula
	je Koniec		;ak je bl rovne 0 skoc na koniec
	sub bx, 30h		;konvertuj ASCII kod cisla na jeho hodnotu
	mul cx			;inak vynasob ax desiatimi ax*cx, cx=10, ax=
	inc edi			;zvys index o jedna
	add ax, bx		;a pripocitaj dalsie cislo
	jmp PrevedNaCislo

Koniec:
	cmp Postupnost, '-'			;porovnaj R s minuskom
	jne Koniec_koncov	;skoc na koniec koncov
	neg ax				;a vytvor dvojkovy doplnok celeho registra ax
	
Koniec_koncov:
	ret
	

NacitajCislo ENDP

main PROC
	call NaplnMa
	call NajdiMin

PrevedKladneNaRetazec:
	movsx eax, si		;zober si a rozsir ho na 32 bitov; lavy operand musi byt dvakrat vacsi ako pravy
	call WriteInt		;vypis cislo z registra eax
	mov edx, offset VypisIndexMinima
	call WriteString
	mov eax, ebx
	call WriteInt
	Odriadkuj

exit
main ENDP
END main