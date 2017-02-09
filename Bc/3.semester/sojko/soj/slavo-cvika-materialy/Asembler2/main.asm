







TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
myMessage BYTE 20 dup(?)
myMessage2 BYTE 20 dup(?)
.code
main PROC
	call Clrscr

	mov edx, OFFSET myMessage
	mov ecx, 19
	call ReadString
	call WriteString

	mov edi,0
	mov esi,0

	call ReadChar; nacita znak, ulozi do al
	call WriteChar

	mov bl,al
	mov ecx, offset myMessage2

Porovnaj:
	mov al,[edx+edi];
	cmp al,0; porovnaj al s nulou
	je Koniec;
	cmp al,bl; porovnaj al s nulou
	je Dvihni;

	mov [ecx+esi],al;
	inc edi; zvýš index o 1
	inc esi; zvýš index o 1
	jmp Porovnaj;

Dvihni:
	inc edi; zvýš index o 1
	jmp Porovnaj;

Koniec:
	mov al, 0
    mov [ecx+esi],al;
	mov edx, ecx
	call WriteString
	exit
main ENDP

END main