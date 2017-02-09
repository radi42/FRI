TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
R DB 20 dup(?); deklaracia viacerych bajtov - viacnasobna deklaracia
S DB 20 dup(?); novy retazec - bude kratsi

.code
main PROC
	call Clrscr; vycisti obrazovku
	
	;nacitanie retazca
	mov ecx, 20; dlzka retazca
	mov edx, offset R;	uloz do edx adresu retazca
	call ReadString

	;odriadkuj
	mov al, 0dh
	call WriteChar
	mov al, 0ah
	call WriteChar

	mov edi, 0; prvy index retazca R
	mov esi, 0; prvy index retazca S

	Vypis:

		;testovanie na koniec
		cmp R[edi], 0
		je Koniec

		cmp edi, 2
		je Preskoc_S

		;mov S[esi], R[edi]	;do retazca S pridaj pismeno z retazca R
		mov al, R[edi]
		mov S[esi], al

		inc edi
		inc esi
		jmp Vypis

	Preskoc_S:
		mov S[edi], '*'
		add edi, 2
		mov al, R[edi]
		mov S[edi-1], al

	Koniec:
		mov edx, offset S
		call WriteString

		;odriadkuj
		mov al, 0dh
		call WriteChar
		mov al, 0ah
		call WriteChar


		exit

main ENDP
END main