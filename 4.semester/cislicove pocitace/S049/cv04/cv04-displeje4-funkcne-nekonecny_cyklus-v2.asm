;byte 0x88,A
;byte 0x89,H
;byte 0xC0,O
;byte 0xE1,J


Cyklus:
	;vypis 'A'
	mvi a,0x88
	out 0xFFFE,a

	;vypis 'A' na displej A1
	mvi a,0x0E		;na prvom cisle nezalezi, moze byt lubovolne, druhe cislo ovlada displeje (1 - nesvieti, 0 - svieti)
	out 0x0001,a
	
	;zhasni displeje
	mvi a,0x0F
	out 0x0001,a

	
	






	;vypis 'H'
	mvi a,0x89		
	out 0xFFFE,a
	
	;na displej A2
	mvi a,0x0D
	out 0x0001,a
	
	;zhasni displeje
	mvi a,0x0F
	out 0x0001,a


	




	;vypis 'O'
	mvi a,0xC0	
	out 0xFFFE,a
	
	;na displej A3
	mvi a,0x0B
	out 0x0001,a
	
	;zhasni displeje
	mvi a,0x0F
	out 0x0001,a









	;vypis 'J'
	mvi a,0xE1
	out 0xFFFE,a
	
	;na displej A3
	mvi a,0x07
	out 0x0001,a
	
	;zhasni displeje
	mvi a,0x0F
	out 0x0001,a


	jmp Cyklus