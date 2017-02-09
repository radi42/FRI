INCLUDE Irvine32.inc
.data
		Postupnost dword 62, 31, 84, 96, 19, 47		; int Postupnost[] = {62, 31, 84, 96, 19, 47}
		n		dword	6							; int n = 5
		KolkoMensichPrvkov	dword	6 dup(0)			; int Total[] = {0, 0, 0, 0, 0}
		TotalString byte	"Total: ", 0	; String TotalString="Total: "
.code

	;procedura Porovnaj	- porovnanie vsetkych prvkov pola - ak je lubovolny prvok pola vacsi ako aktualny
	;inkrementuj pocitadlo
	Porovnaj PROC NEAR						
		mov esi, 0
		mov edi, 0
		mov ecx, n
		mov edx, 0	;pocitadlo

		Cyklus:
		mov edi, 0
		mov edx, 0
		mov ecx, n
			@do:
				mov	eAx, Postupnost[ eSi *4]
				mov	eBx, Postupnost[ eDi *4]
				inc eDi
				
				cmp eBx, eAx
				jge @while		;ak je eBx vacsie ako eAx, chod na zaciatok

				inc eDx								;ak je eBx mensie ako eAx, zvys eDx o jedna
				mov KolkoMensichPrvkov[eSi *4], eDx	;a uloz hodnotu do pola KolkoMensichPrvkov na index esi
			@while: loop @do
			
			inc esi
			cmp esi, n
			jne Cyklus
						
		ret								
	Porovnaj ENDP



							





	;Procedura print - vypis jedotlivych prvkov pola a pocet prvkov, ktore su od neho mensie
	print	PROC NEAR						; void print() {
			mov		eSi, 0					;	eSi = 0		
			mov		eCx, n					;	eCx = n

	;tymto cyklom sa vypisuju jednotlive prvky pola Postupnost 
	 @@do:									;	do {
			mov		eAx, Postupnost[ eSi ]	;		write( A[ eSi ] )
			Call	WriteDec				
			call CrLf						;		write( CRLF )
			add		eSi, 4
	@@while:	loop		@@do

			call CrLf
			call CrLf						





	;teraz sa vypise pole, ktore obsahuje, kolko je pre kazdy prvok v postupnosti mensich prvkov
	;tymto cyklom sa vypisuju jednotlive prvky pola KolkoMensichPrvkov
			mov		eSi, 0					;	eSi = 0		
			mov		eCx, n					;	eCx = n
	 @@do2:									;	do {
			mov		eAx, KolkoMensichPrvkov[ eSi ]
			Call	WriteDec	
			call CrLf							
			add		eSi, 4
	@@while2:	loop		@@do2
			call	CrLf
			ret										
	print	ENDP		  			






	;procedura main
	main	PROC							
			call	Porovnaj				
			call	print					
			exit							
	main		ENDP

END 		main