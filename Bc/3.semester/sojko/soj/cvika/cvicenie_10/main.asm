TITLE MASM Vstup_Vystup					(main.asm)

INCLUDE Irvine32.inc
.data
BitovaMnozina DW 32 dup(0)

.code
Odriadkuj MACRO
	mov al, 0dh
	call WriteChar
	mov al, 0ah
	call WriteChar
ENDM

main PROC
call Clrscr
mov edi, 0
xor ebx, ebx

NaplnMnozinu:
	
    mov eax, 32				;v eax definujeme rozsah 0-31
	call RandomRange		;nahodne cislo je ulozene do registru eax procedurou RandomRange
	call WriteInt			;a daj ho hned vypisat
	Odriadkuj
	cmp edi, 9				;ak sa index edi rovna 9
	je Koniec
	inc edi					;zvysi edi o 1
	jmp NaplnMnozinu		;nepodmieneny skok na vypis
	
Koniec:

exit
main ENDP
END main