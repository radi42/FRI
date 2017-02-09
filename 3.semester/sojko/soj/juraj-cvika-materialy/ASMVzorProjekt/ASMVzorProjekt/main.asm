TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
Retaz DB "No nazdar!", 0dh, 0ah, 0

.code
main PROC
	call Clrscr

	mov edx, offset Retaz
	mov edi,0
	call ReadChar
	mov cl,"0"

	Vypis:
		mov bl, [edx+edi]
		inc edi
		cmp bl, al
		je INKREMENT
		jmp Vypis
	INKREMENT:
		inc cl
		jmp Vypis
	Koniec:
		mov al,cl
		call WriteChar
	exit
main ENDP
END main