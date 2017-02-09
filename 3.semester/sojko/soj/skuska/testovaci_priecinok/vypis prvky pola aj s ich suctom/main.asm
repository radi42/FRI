INCLUDE Irvine32.inc
.data
		A		dword	10, 20, 35, 442, 5	; int A[] = {10, 20, 35, 442, 5}
		n		dword	5			; int n = 5
		Total	dword	?			; int Total;
		TotalString byte	"Total: ", 0	; String TotalString="Total: "
.code

	;procedura Sum	- sucet vsetkych prvkov pola
	Sum	PROC NEAR							; void Sum() { 
			mov		eSi, 0				;	eSi = 0
			mov		eAx, 0				;	total = 0
			mov		eCx, n				;	eCx = n
	@do:		add		eAx, A[eSi*4]			;	do{ 
			inc		eSi					;	   total = total + A[eSi]
	@while:	loop		@do					;	   eSi++
			mov		Total, eAx			;	} while( --eCx != 0 )	
			ret							;	return
	Sum		ENDP						

	;Procedura print - vypis jedotlivych prvkov pola a ich suctu
	print	PROC NEAR						; void print() {
			mov		eSi, 0				;	eSi = 0			
			mov		eCx, n				;	eCx = n

	;tymto cyklom sa vypisuju jednotlive prvky
	 @@do:								;	do {
			mov		eAx, A[ eSi ]		;		write( A[ eSi ] )
			Call	WriteDec			;		write( CRLF )
			Call	CrLf				;	} while( --eCx != 0 )
			add		eSi, 4
	@@while:	loop		@@do
			
			;teraz sa vypise sucet vsetkych prvkov pola
			mov		eDx, OFFSET TotalString	;	write("Total: ")
			call	WriteString
			mov		eAx, Total				;	write( Total )
			call	WriteDec
			call	CrLf
			ret								;	return
	print	ENDP		  					;	}

	;procedura main
	main	PROC							; void main() {
			call	Sum						;	Sum()
			call	print					;	print()
			exit							; }
	main		ENDP

END 		main