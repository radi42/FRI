TITLE MASM Template(main.asm)

INCLUDE Irvine32.inc
.data
Retaz DB "No nazdar!", 0dh, 0ah
DlzkaRetazca EQU $-Retaz	;Konstanta sa deklaruje direktivou EQU.
							;Pocet znakov v retazci zistime tak, ze vytvorime konstantu, ktora bude mat hodnotu $-Retaz

.code
main PROC
mov ebx, offset Retaz; uloz do ebx adresu 1. znaku retazca
mov edi, 0	;prvy znak ma index 0
mov ecx, DlzkaRetazca

Vypis:	mov al, Retaz[edi]
		;cmp ecx, 0
		;je Koniec
		call WriteChar
		inc edi
		loop Vypis
Koniec:
exit
main ENDP
END main