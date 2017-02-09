TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
retazec DB 7 DUP (?)

.code
main PROC
	call Clrscr

	mov  edx, offset retazec
	mov  ecx, 7
	call ReadString
	call WriteString


	exit
main ENDP

END main