TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
R DB 20 dup(?); deklaracia viacerych bajtov - viacnasobna deklaracia
S DB 20 dup(?); novy retazec - bude kratsi
NahradAS DB "as"
PomR DB 2 dup(?); pomocny retazec k retazcu R - do neho nacitam dva znaky a budem ich porovnavat s retazcom NahradAS

.code
main PROC
	call Clrscr; vycisti obrazovku
	
	;nacitanie retazca
	mov ecx, 20; dlzka retazca
	mov edx, offset R;	uloz do edx adresu retazca
	call ReadString


	;nacitanie nahradzaneho retazca
	mov ebx, offset NahradAS
	mov edx, ebx
	call WriteString

	;odriadkuj
	mov al, 0dh
	call WriteChar
	mov al, 0ah
	call WriteChar

	mov edi, 0; prvy index retazca R
	mov esi, 0; prvy index retazca S
	
	;vytvorenie pomocneho retazca
	mov ecx, 2
	mov eax, offset PomR

	Vypis:
		;do pomocneho retazca zadaj prve dva znaky retazca R
		mov al, R[edi]		;zober prve pismeno
		mov PomR[edi], al	;a daj ho na prve miesto pomocneho retazca
		mov al, R[edi+1]	;zober druhe pismeno
		mov PomR[edi+1], al	;a daj ho na druhe miesto pomocneho retazca

		cmp ebx, eax		;ak je NahradAS rovnake ako eax
		je Nahrad			;skoc na navestie Nahrad

		;testovanie na koniec
		cmp R[edi], 0
		je Koniec

		;mov S[esi], R[edi]	;inak na prve miesto vysledneho retazca pridaj prve z dvojice pismen v retazci R
		mov al, R[edi]
		mov S[esi], al

		inc edi
		inc esi
		jmp Vypis

	Nahrad:	
		mov S[esi], '*'
		;mov S[esi+1], ' '
		
		add edi, 2
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