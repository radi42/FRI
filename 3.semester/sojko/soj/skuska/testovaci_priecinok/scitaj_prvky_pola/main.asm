TITLE MASM Template(main.asm)

INCLUDE Irvine32.inc
.data
Z dword 1, 2, 3, 4, 5	;int z[] = {1, 2, 3, 4, 5}
j dword 5				;int j = 5 -> dlzka pola

.code
Sum PROC NEAR			;void Sum() {
Odriadkuj MACRO
	mov al, 0Dh
	call WriteChar
	mov al, 0Ah
	call WriteChar
ENDM

	mov esi, 0			;	esi = 0
	mov ecx, j			;	ecx = j
	mov eax, 0			;	eax = 0

;aj tymto sa da nahradit navestie Pripocitavaj
;@@do:					;	do{
;	add eax, Z[esi]		;		eax = eax + Z[esi]
;	add esi, 4			;		esi++
;@@while: loop @@do		;	} while (--ecx != 0)

Pripocitavaj:
	add eax, Z[esi]
	add esi, 4
	call WriteDec
	mov ebx, eax
	Odriadkuj
	mov eax, ebx
	loop Pripocitavaj

	ret					;	return	
Sum ENDP				;}

main PROC				;void main() {
	call Sum			;	Sum()
	;call WriteDec		;	write(eax)
	exit				;
main ENDP				;}
END main