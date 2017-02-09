byte 0x88,A
byte 0x89,H
byte 0xC0,O
byte 0xE1,J


Cyklus:
	;vypis 'A'
	mvi a,0x00		;ktory 'byte' riadok sa zvoli
	mmr b,a
	out 0xFFFE,b

	;vypis 'A' na displej A1
	mvi a,0x0E		;na prvom cisle nezalezi, moze byt lubovolne, druhe cislo ovlada displeje (1 - nesvieti, 0 - svieti)
	out 0x0001,a
	
	;zhasni displeje
	mvi a,0x0F
	out 0x0001,a

	
	






	;vypis 'H'
	mvi a,0x01		
	mmr b,a
	out 0xFFFE,b
	
	;na displej A2
	mvi a,0x0D
	out 0x0001,a
	
	;zhasni displeje
	mvi a,0x0F
	out 0x0001,a


	




	;vypis 'O'
	mvi a,0x02	
	mmr b,a
	out 0xFFFE,b
	
	;na displej A3
	mvi a,0x0B
	out 0x0001,a
	
	;zhasni displeje
	mvi a,0x0F
	out 0x0001,a









	;vypis 'J'
	mvi a,0x03
	mmr b,a
	out 0xFFFE,b
	
	;na displej A3
	mvi a,0x07
	out 0x0001,a
	
	;zhasni displeje
	mvi a,0x0F
	out 0x0001,a


	jmp Cyklus