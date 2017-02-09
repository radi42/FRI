TITLE MASM Template(main.asm)

INCLUDE Irvine32.inc
.data
Rozmer EQU 4
Matica DW Rozmer*Rozmer	dup(?)

.code
GenerujMaticu PROC USES eax ecx esi
	mov esi, 0
	mov ecx, Rozmer*Rozmer
Generuj:
	mov eax, 10000h
	call RandomRange	;generuje nahodne cislo <0; n-1>
	mov Matica[esi*type Matica], ax
	inc esi
	loop Generuj
	ret
GenerujMaticu ENDP

VypisMaticu PROC USES eax ebx ecx esi
	mov ebx, 0
	mov ecx, Rozmer		;pocet riadkov
VypisRiadok:
	mov esi, 0			;index stlpca
	push ecx			;odloz pocitadlo riadkov
	mov ecx, Rozmer		;pocet stlpcov
Vypis:
	movzx eax, Matica[ebx+esi*type Matica]	;rozsirime 16-bitovy prvok matice na 32 bitov
	call WriteInt		;vypiseme prvok
	mov al, 9			;Tab - zarovnaj do stlpcov
	call WriteChar
	inc esi
	loop Vypis
		mov al, 0Dh
		call WriteChar
		mov al, 0Ah
		call WriteChar
	pop ecx				;obnov pocitadlo riadkov
	add ebx, Rozmer*type Matica	;aktualizuj offset riadku
	loop VypisRiadok
	ret
VypisMaticu ENDP

main PROC
;Priklad
;Vygenerujte maticu 4x4 celych cisel bez znamienka
;typu word. Ulozte ju do pamati a vypiste ju
;na obrazovku

	call GenerujMaticu
	call VypisMaticu
	exit

exit
main ENDP
END main