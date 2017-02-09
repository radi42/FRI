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
main PROC

	call Clrscr			;vycisti obrazovku

	Odriadkuj

	mov ecx, 20			; dlzka retazca
	mov edx, offset R	;uloz do edx adresu retazca
	call ReadString
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
	mul cx			;inak vynasob ax desiatimi ax*cx
	inc edi			;zvys index o jedna
	add ax, bx		;a pripocitaj dalsie cislo
	jmp PrevedNaCislo

Koniec:
	cmp R, '-'	;porovnaj R s minuskom
	jne Koniec_koncov	;skoc na koniec koncov
	neg ax				;a vytvor dvojkovy doplnok celeho registra ax
	
Koniec_koncov:
	cmp R, '-'
	jne PrevedKladneNaRetazec
	;jmp PrevedZaporneNaRetazec

PrevedKladneNaRetazec:
	mov edi, 0
	xor ah, ah		;vymaz hornu polovicu ax
	mov al, R[edi]	;zober znak do al
	add al, 30h
	call WriteChar
	jmp PrevedNaCislo

exit
main ENDP
END main