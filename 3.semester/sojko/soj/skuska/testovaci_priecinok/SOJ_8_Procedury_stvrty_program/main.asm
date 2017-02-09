TITLE MASM Template(main.asm)

INCLUDE Irvine32.inc
.data
Pole DB 0, 1, 2, 3, 4
Dlzka DD $-Pole
Cislo EQU 1

.code
Pripocitaj PROC pascal USES eax ebx ecx paOffset,
paDlzka, paCislo:byte
	LOCAL Sucet: byte
	mov ebx, paOffset
	mov ecx, paDlzka
	mov al, paCislo
	mov Sucet, 0
Cyklus:
	add [ebx], al	;pripocitaj paCislo k nultemu prvku pola
	mov ah, [ebx]	;cislo (paCislo) ulozene v pamati na adrese
	add Sucet, ah

	xor eax, eax
	mov al, Sucet
	call WriteInt

	mov al, 0Dh
	call WriteChar
	mov al, 0Ah
	call WriteChar

	inc ebx
	loop Cyklus
	ret
Pripocitaj ENDP

;prekladac automaticky doplni
;push ebp
;mov ebp, esp
;push eax
;push ebx
;push ecx

;a na konci procedury
;pop ecx
;pop ebx
;pop eax
;leave
;ret 0Ch


main PROC

;Lokalne premenne
;Lokalne premenne existuju len pocas vykonavania
;procedury
;zanikaju pred navratom z procedury.
;Su ulozene v zasobniku nad navratovou adresou a
;odlozenym registrom EBP

;Syntax
;LOCAL premenna1 [,premenna2] ... [=symbol]

	push offset Pole
	push Dlzka  
	push Cislo  
	call Pripocitaj
	add esp, 0Ch
	exit
main ENDP
END main