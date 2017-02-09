;znaky vypisovaneho textu
byte 0x88,A		;index konstanty: 0
byte 0x89,H		;index konstanty: 1
byte 0xC0,O		;index konstanty: 2
byte 0xE1,J		;index konstanty: 3

;vyber displej / vyber stlpec
byte 0x0E,A1		;index konstanty: 4 - 1110
byte 0x0D,A2		;index konstanty: 5 - 1101
byte 0x0B,A3		;index konstanty: 6 - 1011
byte 0x07,A4		;index konstanty: 7 - 0111

byte 0x09; segmenty cisla 0 - index konstanty: 8
byte 0x00; segmenty cisla 1
byte 0x01; segmenty cisla 2
byte 0x02; segmenty cisla 3
byte 0x03; segmenty cisla 4
byte 0x04; segmenty cisla 5
byte 0x05; segmenty cisla 6
byte 0x06; segmenty cisla 7
byte 0x07; segmenty cisla 8
byte 0x08; segmenty cisla 9

Start:
	Main:
	cal Displeje
	cal Tlacidla
	jmp Main
jmp Koniec

;inicializuj
Displeje:
	mvi c,0x00	;ktore segmenty na displeji sa rozsvietia
	mvi d,0x04	;ktory displej s rozsvieti

CyklusDisp:
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
	jmp CyklusDisp
	Preskoc:
ret 

















Tlacidla:
mvi c,0x04 ; nacitaj stvrtu konstantu (a nie stvrty riadok!)

CyklusB:
	mmr b,c
	out 0xFFFB,b
	inn a,0x000B
	cmi a,0x0F	;este nie je stlacene ziadne tlacidlo
	jzr PreskocT
		
	;najprv porovnavame pred stlpcovym navestim
		;bol stlaceny 1. stlpec?
		cmi a,0x0e
		jzr PrvyStlpec
		jmp DruhyStlpec
	PrvyStlpec:

		;teraz treba porovnavat suradnice
		;tlacidiel s registrom C
		;a priradzovat im cinnosti v
		;podprogramoch

		
		cmi c,0x04
		  jzr Tlacidlo0

		cmi c,0x05
		  jzr Tlacidlo4

		cmi c,0x06
		  jzr Tlacidlo8

		cmi c,0x07
		  jzr Tlacidlo12

	;teraz uz treba porovnavat vnutri stlpcoveho navestia
	DruhyStlpec:
		;bol stlaceny 2. stlpec?
		cmi a,0x0d
		jnz TretiStlpec


		cmi c,0x04
		  jzr Tlacidlo1

		cmi c,0x05
		  jzr Tlacidlo5

		cmi c,0x06
		  jzr Tlacidlo9

		cmi c,0x07
		  jzr Tlacidlo13

	TretiStlpec:
		;bol stlaceny 3. stlpec?
		cmi a,0x0b
		jnz StvrtyStlpec

		

		cmi c,0x04
		  jzr Tlacidlo2

		cmi c,0x05
		  jzr Tlacidlo6

		cmi c,0x06
		  jzr Tlacidlo10

		cmi c,0x07
		  jzr Tlacidlo14

	StvrtyStlpec:
		;bol stlaceny 4. stlpec?
		cmi a,0x07
		jnz Preskoc	;ak sa nerovna Preskoc, inak vypis suradnice


		cmi c,0x04
		  jzr Tlacidlo3

		cmi c,0x05
		  jzr Tlacidlo7

		cmi c,0x06
		  jzr Tlacidlo11

		cmi c,0x07
		  jzr Tlacidlo15


	PreskocT:
		inc c
		cmi c,0x08
		jzr preskocC

jmp CyklusB

preskocC:
ret


;Cinnosti tlacidiel
Tlacidlo0:
  ;riadok
  mov d,c
  adi d,44
  scall dsp

  ;stlpec
  mvi d,0x30
  scall dsp

  ;odriadkuj, aby to bolo pekne
  mvi d,0x0D
  scall dsp
  mvi d,0x0A
  scall dsp

ret



Tlacidlo1:
  ;riadok
  mov d,c
  adi d,44
  scall dsp

  ;stlpec
  mvi d,0x31
  scall dsp

  ;odriadkuj, aby to bolo pekne
  mvi d,0x0D
  scall dsp
  mvi d,0x0A
  scall dsp
ret



Tlacidlo2:
  ;riadok
  mov d,c
  adi d,44
  scall dsp

  ;stlpec
  mvi d,0x32
  scall dsp

  ;odriadkuj, aby to bolo pekne
  mvi d,0x0D
  scall dsp
  mvi d,0x0A
  scall dsp
ret



Tlacidlo3:
  ;riadok
  mov d,c
  adi d,44
  scall dsp

  ;stlpec
  mvi d,0x33
  scall dsp

  ;odriadkuj, aby to bolo pekne
  mvi d,0x0D
  scall dsp
  mvi d,0x0A
  scall dsp
ret



Tlacidlo4:
  ;riadok
  mov d,c
  adi d,44
  scall dsp

  ;stlpec
  mvi d,0x30
  scall dsp

  ;odriadkuj, aby to bolo pekne
  mvi d,0x0D
  scall dsp
  mvi d,0x0A
  scall dsp
ret



Tlacidlo5:
  ;riadok
  mov d,c
  adi d,44
  scall dsp

  ;stlpec
  mvi d,0x31
  scall dsp

  ;odriadkuj, aby to bolo pekne
  mvi d,0x0D
  scall dsp
  mvi d,0x0A
  scall dsp
ret



Tlacidlo6:
  ;riadok
  mov d,c
  adi d,44
  scall dsp

  ;stlpec
  mvi d,0x32
  scall dsp

  ;odriadkuj, aby to bolo pekne
  mvi d,0x0D
  scall dsp
  mvi d,0x0A
  scall dsp
ret



Tlacidlo7:
  ;riadok
  mov d,c
  adi d,44
  scall dsp

  ;stlpec
  mvi d,0x33
  scall dsp

  ;odriadkuj, aby to bolo pekne
  mvi d,0x0D
  scall dsp
  mvi d,0x0A
  scall dsp
ret



Tlacidlo8:
  ;riadok
  mov d,c
  adi d,44
  scall dsp

  ;stlpec
  mvi d,0x30
  scall dsp

  ;odriadkuj, aby to bolo pekne
  mvi d,0x0D
  scall dsp
  mvi d,0x0A
  scall dsp
ret



Tlacidlo9:
  ;riadok
  mov d,c
  adi d,44
  scall dsp

  ;stlpec
  mvi d,0x31
  scall dsp

;odriadkuj, aby to bolo pekne
  mvi d,0x0D
  scall dsp
  mvi d,0x0A
  scall dsp
ret



Tlacidlo10:
  ;riadok
  mov d,c
  adi d,44
  scall dsp

  ;stlpec
  mvi d,0x32
  scall dsp

  ;odriadkuj, aby to bolo pekne
  mvi d,0x0D
  scall dsp
  mvi d,0x0A
  scall dsp
ret



Tlacidlo11:
  ;riadok
  mov d,c
  adi d,44
  scall dsp

  ;stlpec
  mvi d,0x33
  scall dsp

  ;odriadkuj, aby to bolo pekne
  mvi d,0x0D
  scall dsp
  mvi d,0x0A
  scall dsp
ret



Tlacidlo12:
  ;riadok
  mov d,c
  adi d,44
  scall dsp

  ;stlpec
  mvi d,0x30
  scall dsp

;odriadkuj, aby to bolo pekne
  mvi d,0x0D
  scall dsp
  mvi d,0x0A
  scall dsp
ret



Tlacidlo13:
  ;riadok
  mov d,c
  adi d,44
  scall dsp

  ;stlpec
  mvi d,0x31
  scall dsp

;odriadkuj, aby to bolo pekne
  mvi d,0x0D
  scall dsp
  mvi d,0x0A
  scall dsp
ret



Tlacidlo14:
  ;riadok
  mov d,c
  adi d,44
  scall dsp

  ;stlpec
  mvi d,0x32
  scall dsp

  ;odriadkuj, aby to bolo pekne
  mvi d,0x0D
  scall dsp
  mvi d,0x0A
  scall dsp
ret



Tlacidlo15:
  ;riadok
  mov d,c
  adi d,44
  scall dsp

  ;stlpec
  mvi d,0x33
  scall dsp

  ;odriadkuj, aby to bolo pekne
  mvi d,0x0D
  scall dsp
  mvi d,0x0A
  scall dsp
ret



Koniec:


