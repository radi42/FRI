;znaky vypisovaneho textu
byte 0x88,A		;index riadku: 0
byte 0x89,H		;index riadku: 1
byte 0xC0,O		;index riadku: 2
byte 0xE1,J		;index riadku: 3

;vyber displej
byte 0x0E,A1		;index riadku: 4 - 1110
byte 0x0D,A2		;index riadku: 5 - 1101
byte 0x0B,A3		;index riadku: 6 - 1011
byte 0x07,A4		;index riadku: 7 - 0111

Start:
	Main:
	cal Tlacidla
	jmp Main
jmp Koniec

;inicializuj
Vypis:
	mvi c,0x00	;ktore segmenty na displeji sa rozsvietia
	mvi d,0x04	;ktory displej s rozsvieti

Cyklus:
	;vypis 'A'
	mov a,c	;segmenty ma na starosti register c
	mmr b,a
	out 0xFFFE,b

	;zhasni vsetky displeje
	mov a,d
	mmr b,a
	out 0xFFFD,b
	
	mvi a,0x0F		;1111 - vsetky displeje su vypnute
	out 0x000D,a	

	;zasviet displej
	mov a,d
	mmr b,a
	out 0xFFFD,b

	mov a,d	;displeje ma na starosti register d
	mmr b,a
	out 0x000D,b
	
	;zhasni vsetky displeje
	mov a,d
	mmr b,a
	out 0xFFFD,b
	
	mvi a,0x0F		;1111 - vsetky displeje su vypnute
	out 0x000D,a	

	inc d		;posun displej
	inc c		;zobraz dalsi znak

	cmi c,0x04	;ak uz boli vsetky znaky zobrazene
	jzr Preskoc
	jmp Cyklus
	Preskoc:
ret 








Tlacidla:
mvi c,0x00 ; riadok - prvy riadok kodu

CyklusB:
	mmr b,c
	out 0xFFFB,b
	inn a,0x000B
	cmi a,0x0F	;este nie je stlacene ziadne tlacidlo
	jzr Preskoc
		
	;najprv porovnavame pred stlpcovym navestim
		;bol stlaceny 1. stlpec?
		cmi a,0x0e
		jzr PrvyStlpec
		jmp DruhyStlpec
	PrvyStlpec:
		
		;riadok
		mov d,c
		adi d,48
		scall dsp

		;stlpec
		mvi d,0x30
		scall dsp

		;odriadkuj, aby to bolo pekne
		mvi d,0x0D
		scall dsp
		mvi d,0x0A
		scall dsp

	;teraz uz treba porovnavat vnutri stlpcoveho navestia
	DruhyStlpec:
		;bol stlaceny 2. stlpec?
		cmi a,0x0d
		jnz TretiStlpec

		;riadok
		mov d,c
		adi d,48
		scall dsp

		;stlpec
		mvi d,0x31
		scall dsp

		;odriadkuj, aby to bolo pekne
		mvi d,0x0D
		scall dsp
		mvi d,0x0A
		scall dsp

	TretiStlpec:
		;bol stlaceny 3. stlpec?
		cmi a,0x0b
		jnz StvrtyStlpec

		;riadok
		mov d,c
		adi d,48
		scall dsp

		;stlpec
		mvi d,0x32
		scall dsp

		;odriadkuj, aby to bolo pekne
		mvi d,0x0D
		scall dsp
		mvi d,0x0A
		scall dsp

	StvrtyStlpec:
		;bol stlaceny 4. stlpec?
		cmi a,0x07
		jnz PreskocD	;ak sa nerovna Preskoc, inak vypis suradnice

		;riadok
		mov d,c
		adi d,48
		scall dsp

		;stlpec
		mvi d,0x33
		scall dsp

		;odriadkuj, aby to bolo pekne
		mvi d,0x0D
		scall dsp
		mvi d,0x0A
		scall dsp

	PreskocD:
		inc c
		cmi c,0x04
		jzr preskocC
jmp CyklusB
preskocC:
ret

Koniec:
