TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
R DB 20 dup(?)

.code
Odriadkuj MACRO
		mov al, 0dh
		call WriteChar
		mov al, 0ah
		call WriteChar
ENDM

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
	mul cx			;inak vynasob ax desiatimi ax*cx, cx=10, ax=nulty znak (pri kladnom cisle) resp prvy znak (pri zapornom cisle) v retazci
	inc edi			;zvys index o jedna
	add ax, bx		;a pripocitaj dalsie cislo
	jmp PrevedNaCislo

Koniec:
	cmp R, '-'			;porovnaj R s minuskom
	jne Koniec_koncov	;skoc na koniec koncov
	neg ax				;a vytvor dvojkovy doplnok celeho registra ax
	
Koniec_koncov:
	ret
	

NacitajCislo ENDP

main PROC

	call NacitajCislo

PrevedKladneNaRetazec:
	movsx eax, ax		;zober ax a rozsir ho na 32 bitov
	call WriteInt		;vypis cislo z registra eax
	Odriadkuj

exit
main ENDP
END main