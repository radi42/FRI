TITLE MASM Template (main.asm)

INCLUDE Irvine32.inc
.data
R DB 20 dup(0)
Postupnost DW 1,2,3,4,5

F DB 'FALSE',0
T DB 'TRUE',0

.code

; v procedurach zachovame nastavenie registrov v hl. progr.
; nacita cislo ako retazec, prevedie na cislo v ax
Nacitaj PROC
	push ecx
	push edx
	push ebx
	push edi
	; v procedure mame vysledok neskor v eax s kt. sa potom pracuje takze ho nedavam na zasobnik

	mov ecx, 20						; dlzka retazca
	mov edx, offset R				;uloz do edx adresu retazca
	call ReadString
	mov edi, 0						; nastav edi na nulu
	mov cx, 10						; nastav cx na 10
	xor ax, ax						; vymax cely ax register

	cmp R[edi], '-'
	jne PrevedNaCislo
	inc edi

	PrevedNaCislo:
		mov bl, R[edi] ;zober znak do al
		xor bh, bh ;vymaz hornu polovicu ax
		cmp bl, 0 ;porovnaj ax a nula
		je Koniec1 ;ak je ax rone 0 skoc na koniec
		sub bx, 30h ;konvertuj ASCII kod cisla na jeho hodnotu
		mul cx ;inak vynasob ax desiatimi ax*cx
		inc edi ;zvys index o jedna
		add ax, bx ;a pripocitaj dalsie cislo
		jmp PrevedNaCislo

	Koniec1:
		cmp R[0], '-'				; ak neni zaporne nerob dvojk doplnok
		jne Koniec2
		neg ax						; dvojkovy doplnok zaporne cislo

	Koniec2:
		pop edi
		pop ebx
		pop edx
		pop ecx

		ret
Nacitaj ENDP


; vypise obsah ax
Vypis PROC
	push ecx
	push edx
	push ebx
	push edi

	mov edi,length R - 2			; -1=> index, -2=> koniec cisla bez '\0' 
	cmp ax,0 
	jnl Koniec3						; ak je ax vacsie ako nula preskoc na koniec3
	neg ax							; negujeme ax naspat

	mov bx,ax
	mov al,'-'
	call WriteChar
	mov ax,bx

	Koniec3:
		mov bx,10					; delitel
		xor dx,dx					; vynulujeme dx lebo do neho sa uklada vysledok ale iba do dolnej casti lebo je male cislo (zvysok)
		div bx						; ax/bx ; delenie, delenec v ax

		mov R[edi],dl				; v dl je zvysok po deleni
		add R[edi],'0'				; chceme znak takze pripocitame ascii nulu
	
		dec edi						; ideme odzadu retazca takze znizujeme

		cmp ax,0
		jne Koniec3					; opakuj kym sa nerovna nule


		mov edx,offset R			; zober retazec offset
		add edx,edi					; prirataj index zaciatku retazca
		inc edx						; v edx je zaciatok retazca

		call WriteString

	Koniec4:
		pop edi
		pop ebx
		pop edx
		pop ecx

		ret
Vypis ENDP


main PROC
	call Clrscr						; vycisti obrazovku
	call Nacitaj					; cislo je v ax

	; zistime ci sa cislo nachadza v Postupnosti
	mov ecx,5
	Hladaj:
		mov edi,ecx
		dec edi
		cmp ax,Postupnost[2*edi]	; lebo Postupnost je WORD=2B
		je NasloSa

		loop Hladaj

	NenasloSa:
		mov edx,offset F
		call WriteString
		jmp UplnyKoniec
	NasloSa:
		mov edx,offset T
		call WriteString

	UplnyKoniec:

	; call Vypis

	exit
main ENDP
END main