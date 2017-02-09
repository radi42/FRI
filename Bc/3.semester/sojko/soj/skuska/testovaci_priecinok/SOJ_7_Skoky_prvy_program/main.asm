TITLE MASM Template(main.asm)

INCLUDE Irvine32.inc
.data
Retaz DB "No nazdar!", 0Dh, 0Ah, 0
Adr DD ?

.code
main PROC

;instrukcie skoku
;nemenia priznaky

;nepodmienene skoky
;priamy skok

;jmp navestie
;skoci na dane navestie za kazdych okolnosti

;nepriamy skok
;jmp navestie
;zase to iste? o.O

		mov Adr, offset Koniec
		mov ecx, offset Vypis
		mov ebx, offset Retaz	;do ebx sa ulozi prvy znak retazca Retaz
		mov edi, 0
Vypis:	mov al, [ebx + edi]
		cmp al, 0
		jne Dalej; ak nie je nula, pokracuj dalej
		jmp Adr
Dalej:	call WriteChar
		inc edi
		jmp ecx
Koniec:
exit
main ENDP
END main