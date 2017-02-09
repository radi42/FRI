;znaky vypisovaneho textu
byte 0xBF,-		;index konstanty: 0
byte 0xBF,-		;index konstanty: 1
byte 0xBF,-		;index konstanty: 2
byte 0xBF,-		;index konstanty: 3

;vyber displej / vyber stlpec
byte 0x0E,A1		;index konstanty: 4 - 1110
byte 0x0D,A2		;index konstanty: 5 - 1101
byte 0x0B,A3		;index konstanty: 6 - 1011
byte 0x07,A4			;index konstanty: 7 - 0111

byte 0xC0; segmenty cisla 0 - index konstanty: 8
byte 0xF9; segmenty cisla 1
byte 0xA4; segmenty cisla 2
byte 0xB0; segmenty cisla 3
byte 0x99; segmenty cisla 4
byte 0x92; segmenty cisla 5
byte 0x82; segmenty cisla 6
byte 0xF8; segmenty cisla 7
byte 0x80; segmenty cisla 8
byte 0x90; segmenty cisla 9 - index konstanty: 18

Start:
	cal Pomlcka
	Main:
	cal Displeje
	cal Tlacidla

	
	jmp Main
jmp Koniec

;inicializuj
Displeje:
	mvi c,10	;ktore segmenty na displeji sa rozsvietia
	mvi d,0x04	;ktory displej s rozsvieti

CyklusDisp:
	;vypis znak
	ldr b,c
	out 0xFFFE,b

	;zhasni vsetky displeje
	mmr b,d
	out 0xFFFD,b
	
	mvi a,0x0F		;1111 - vsetky displeje su vypnute
	out 0x000D,a	

	;zasviet displej
	mmr b,d
	out 0xFFFD,b

	;displeje ma na starosti register d
	mmr  b,d
	out 0x000D,b
	
	;zhasni vsetky displeje
	mmr b,d
	out 0xFFFD,b
	
	mvi a,0x0F		;1111 - vsetky displeje su vypnute
	out 0x000D,a	

	inc d		;posun displej
	inc c		;zobraz dalsi znak

	cmi c,14	;ak uz boli vsetky znaky zobrazene
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
	;mvi d,0
	;pus d
		
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

CakajNaPustenie:
pus b
nav:
inn b,0x000B
ani b,0x0f
cmi b,0x0f
jnz nav
pop b
ret

;Cinnosti tlacidiel
Tlacidlo0:
  cal CakajNaPustenie
  mvi d,9
  ldr b,d
  
  mvi d,8
  mmr c,d
  mov d,b
  str d,c 
	
   	

	inc b
	mvi c,9
	str c,b

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
 cal CakajNaPustenie

  mvi d,9
  ldr a,d
  
  mvi d,9
  mmr c,d
  mov d,a
  str d,c 
  	
	
	
	inc a
	mvi c,9
	str c,a

  ;riadok
  ;mov d,c
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
 cal CakajNaPustenie

 mvi d,9
  ldr a,d
  
  mvi d,10
  mmr c,d
  mov d,a
  str d,c 
  	
	
	
	inc a
	mvi c,9
	str c,a 


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
  cal CakajNaPustenie
  	mvi b,10
	ldr d,b
	mvi b,20
    	str b,d

	mvi b,11
	ldr d,b
	mvi b,21
    	str b,d
	
	mvi b,12
	ldr d,b
	mvi b,22
    	str b,d

	mvi b,13
	ldr d,b
	mvi b,23
    	str b,d
	cal pomlcka
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

Pomlcka:
	mvi a,10
	mvi c,9
	str c,a
	; na adresu 9 sa vlozi 10

	; vypísanie 4x poml?ka
	mvi a,0xBF	; konštanta poml?ky

	mvi c,10
	str c,a

	mvi c,11
	str c,a

	mvi c,12
	str c,a

	mvi c,13
	str c,a

ret


Koniec:


