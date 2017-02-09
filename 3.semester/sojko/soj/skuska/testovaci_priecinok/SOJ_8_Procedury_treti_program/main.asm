TITLE MASM Template(main.asm)

INCLUDE Irvine32.inc
.data
Pole DB 0, 1, 2, 3, 4
Dlzka DD $-Pole
Cislo EQU 1

.code
Pripocitaj PROC pascal USES eax ebx ecx paOffset,
paDlzka, paCislo:byte
	mov ebx, paOffset
	mov ecx, paDlzka
	mov al, paCislo
Cyklus:
	add [ebx], al

	mov eax, ebx
	call WriteInt

	mov al, 0Ah
	call WriteChar
	mov al, 0Dh
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

;Uchovanie registrov v procedure
;vykonava sa pomocou klucoveho slova USES
;v deklaracii procedury

	push offset Pole
	push Dlzka  
	push Cislo  
	call Pripocitaj
	add esp, 0Ch
	exit
main ENDP
END main