TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

string DB 7 DUP (?)
.code

skuska PROC [uses eax]
	mov al, '5'
	call WriteString
	ret
skuska ENDP





main PROC
	call Clrscr

	mov  edx, offset string
	mov  ecx, 7
	call ReadString
	
	mov ax, 0	
	mov ebx, 0
	mov edi, 0

Cyklus:
	mov cl,[string + edi]
	cmp cl, 0

	je KoniecRetazca

	cmp cl, "-"
	je OstranMinus
	mov bx,10
	mul bx

	sub cl,48
	mov ch,0
	add ax,cx

	call skuska

	inc edi
	jmp Cyklus


OstranMinus:
    inc edi
	jmp Cyklus


KoniecRetazca:
	cmp [string], "-"
	jne Koniec
	neg ax

Koniec:
	exit
main ENDP

END main
                        