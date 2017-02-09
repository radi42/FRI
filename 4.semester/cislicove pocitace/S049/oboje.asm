;znaky vypisovaneho textu
byte 0x88,A		;index riadku: 0
byte 0x89,H		;index riadku: 1
byte 0xC0,O		;index riadku: 2
byte 0xE1,J		;index riadku: 3

;vyber displej | ; ktory riadok sa aktivuje -na najvyssich 4 bytoch nezalezi
byte 0x0E,A1		;index riadku: 4 - 1110
byte 0x0D,A2		;index riadku: 5 - 1101
byte 0x0B,A3		;index riadku: 6 - 1011
byte 0x07,A4		;index riadku: 7 - 0111

;inicializuj
INITD:
	mvi c,0x00	;ktore segmenty na displeji sa rozsvietia
	mvi d,0x04	;ktory displej s rozsvieti

CyklusD:
	;vypis 'A'
	mov a,c	;segmenty ma na starosti register c
	mmr b,a
	out 0xFFFE,b

	;zhasni vsetky displeje
	mvi a,0x0F		;1111 - vsetky displeje su vypnute
	out 0x0001,a	

	;zasviet displej
	mov a,d	;displeje ma na starosti register d
	mmr b,a
	out 0x0001,b
	
	;zhasni vsetky displeje
	mvi a,0x0F		;1111 - vsetky displeje su vypnute
	out 0x0001,a	
	
	pus a
	pus b
	mmr b,c
	out 0xFC,b
	inn a,0x0002
	cmi a,0x0F
	jzr Preskoc
		mov d,a
		scall dsp
	Preskoc:
	pop b
	pop a
		

	inc d		;posun displej
	inc c		;zobraz dalsi znak

	cmi c,0x04	;ak uz boli vsetky znaky zobrazene
	jzr INITD
	jmp CyklusD




INITB:	;B ako Button
pus a
pus b
pus c
pus d
mvi c,0x00 ; riadok - prvy riadok kodu

CyklusB:
	mmr b,c
	out 0xFFFD,b
	inn a,0x0002
	cmi a,0x0F
	jzr Preskocc
		mov d,a
		scall dsp
	Preskocc:
	inc c
	cmi c,0x04

	pop d
	pop c
	pop b
	pop a

ret
