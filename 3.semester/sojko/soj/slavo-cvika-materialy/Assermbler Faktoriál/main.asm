TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

aCislo DB 7


.code
main PROC
	call Clrscr

	mov eax, 0
	movzx ax, aCislo
	movzx ecx, aCislo
	dec ecx

	Cyklus:

		mul cx

	loop Cyklus

	call WriteInt
	

	exit
main ENDP

END main