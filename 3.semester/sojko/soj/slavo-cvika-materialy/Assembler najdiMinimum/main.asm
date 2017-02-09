TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

aPostupnostCislel DW 9999, 9999, 881, 9999, 9998; Pole typ Word, alokuje sa 10 B (5*2) v pamati

.code

main PROC
	call Clrscr; vymaze obrazovku

	mov ecx,5; priradi ecx 5 - dlzka pola
	mov bx, aPostupnostCislel[0]; do bx sa priradi 0 prvok pola 

	Cyklus:
		mov ax, aPostupnostCislel[ecx*2-2]; potrebujeme prechadzat cele pole, Word je v 2B, takze *2 
		cmp ax, bx; porovnáme ax a bx
		jb PrepisCislo; ak je ax mensie, tak sa prepise bx na ax
    Navrat:

	LOOP Cyklus

	mov eax, 0; vynuluje cele eax
	mov ax, bx; vlozi sa hodnota z bx do ax
	call WriteInt; vypise obsah eax
	jmp Koniec;


	PrepisCislo:
		mov bx, ax
	jmp Navrat

Koniec:

	exit
main ENDP

END main