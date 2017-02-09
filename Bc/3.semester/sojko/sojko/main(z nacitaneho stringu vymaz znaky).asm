TITLE MASM Vstup_Vystup					(main.asm)

INCLUDE Irvine32.inc
.data

R DB 20 dup(?)
S DB 20 dup(?)

.code
main PROC

call Clrscr
mov ecx,20;max dlzka stringu
mov edx,offset R
call ReadString ; do premennej na ktoru ukazuje edx
call WriteString ; vypise retazec na ktory uka. edx
call ReadChar ; do al

mov edi,0
mov esi,0

CYKLUS:
	
	cmp R[edi],al
	je PRESKOC
	mov bl,R[edi]
	mov S[esi],bl
	inc esi

	
	PRESKOC:
	cmp R[edi],0
	jz KONIEC
	inc edi

	jmp CYKLUS

KONIEC:
	mov edx,offset S
	call WriteString

exit
main ENDP
END main