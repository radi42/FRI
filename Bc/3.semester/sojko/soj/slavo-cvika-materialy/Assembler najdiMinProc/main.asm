TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

aPostupnostCislel DW 9999, 9999, 881, 9999, 9998; Pole typ Word, alokuje sa 10 B (5*2) v pamati

.code

NajdiNajvetse PROC
	Cyklus:
		mov ax, aPostupnostCislel[ecx*2-2]; potrebujeme prechadzat cele pole, Word je v 2B, takze *2 
		cmp ax, bx; porovnáme ax a bx
		ja PreskocPrepisanie; ak je ax mensie, tak sa prepise bx na ax
			mov bx, ax
		PreskocPrepisanie:

	LOOP Cyklus

ret 
NajdiNajvetse ENDP


main PROC

	mov bx, 200h
	mov ax, 32ABh
	inc ax
	;mov [bx], ax


	call Clrscr; vymaze obrazovku

	mov ecx,5; priradi ecx 5 - dlzka pola
	mov bx, aPostupnostCislel[0]; do bx sa priradi 0 prvok pola 
	call NajdiNajvetse
	mov eax, 0; vynuluje cele eax
	mov ax, bx; vlozi sa hodnota z bx do ax
	call WriteInt; vypise obsah eax

	exit
main ENDP

END main