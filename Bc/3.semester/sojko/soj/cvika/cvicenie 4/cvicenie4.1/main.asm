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
	;call WriteString


	;nacitanie znaku
	call ReadChar
	mov bl, al
	call WriteChar

	;odriadkuj
	mov al, 0dh
	call WriteChar
	mov al, 0ah
	call WriteChar


	mov edi, 0; prvy index retazca R
	mov esi, 0; prvy index retazca S
	
	Vypis:
		cmp R[edi], bl
		je Vynechaj

		;mov S[esi], R[edi] pomocny prikaz
		mov al, R[edi]
		mov S[esi], al
		inc esi

	Vynechaj:
		cmp R[edi], 0
		je Koniec
		inc edi
		jmp Vypis

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