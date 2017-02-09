TITLE MASM Template(main.asm)

INCLUDE Irvine32.inc
.data
Pole DB 0, 1, 2, 3, 4
Dlzka DD $-Pole
Cislo EQU 1

.code
;procedura pripocitaj pripocita ku kazdemu
;prvku pola zvolenu konstantu
Pripocitaj PROC
	mov ebp, esp
	mov ebx, [ebp+12];	offset pola
	mov ecx, [ebp+8];   Dlzka
	mov al, [ebp+4];	Cislo
	mov edi, 0
Cyklus:
	add [ebx], al		;pripocitame cislo k prvemu prvku z pola
	;snazil som sa prvky pola vypisat, ale nevyslo mi to
	;mov dl, [ebx]
	;or dl, 110000b
	;call WriteString
	inc ebx				;posunieme sa na dalsie miesto v pamati (dalsi prvok)
	loop Cyklus			
	ret 12				;zo zasobnika vyberie navratovu
						;adresu a parametre (12 bajtov)
Pripocitaj ENDP

main PROC

;Instrukcie pre pracu so zasobnikom
;push register/pamat/cislo
;ulozi operand na vrchol zasobnika
;operand musi mat typ word alebo dword
;esp = esp -2(4), [esp] = operand
push 1	;ulozi cislo 1 na vrchol zasobnika

;pop register/pamat
;vyberie operand zo zasobnika
;operand musi mat typ word alebo dword
;operand = [esp], esp = esp+2(4)

;pusha (push all)
;ulozi do zasobnika obsahy vsetkych univerzalnych
;registrov v poradi:
;EAX, ECX, EDX, EBX, ESP (povodny obsah), EBP, ESI, EDI

;popa (pop all)
;vyberie zo zasobnika obsahy vsetkych univerzalnych
;registrov v poradi:
;EDI, ESI, EBP, dalsie slovo sa ignoruje, 
;EBX, EDX, ECX, EAX

;pushf
;ulozi do zasobnika dolnu polovicu registra priznakov
;EFLAGS

;pushfd
;ulozi do zasobnika 32-bitovy register priznakov
;EFLAGS

;popf
;vyberie zo zasobnika dolnu polovicu registra priznakov
;EFLAGS

;popfd
;vyberie zo zasobnika register priznakov EFLAGS

;instrukcie popf a popfd menia priznaky,
;ostatne instrukcie priznaky nemenia

;PROCEDURY
;meno procedury PROC [jazyk] [USES registre] [, parametre]
;	telo procedury
;	ret; navrat
;meno procedury ENDP

;Volanie procedury
;Priame: call meno_procedury
;Nepriame: call register/pamat

;ulozi do zasobnika navratovu adresu a vykona 
;skok na prvu instrukciu procedury
;Navratovou adresou je aktualna hodnota citaca
;instrukcii EIP tj offset instrukcie, ktora
;nasleduje za instrukciou call
;call sa preklada rovnako ako jmp

;Navrat z procedury
;ret
;vyberieme zo zasobnika navratovu adresu a ulozi 
;ju do EIP

;Odovzdavanie parametrov
;v registroch - v cisto assemblerovskych programoch
;v zasobniku

;Odovzdavanie parametrov cez zasobnik
;pred volanim procedury sa parametre ulozia do 
;zasobnika. Typ parametrov MUSI BYT DWORD.
;V procedure sa spristupnia pomocou nepriameho 
;adresovania s pouzitim bazoveho registra EBP

;napr. napiste proceduru, ktora ku vsetkym prvkom 
;pola typu byte pripocita zadanu hodnotu.
;Parametrami procedury budu:
;-adresa pola
;-dlzka pola v bajtoch
;-cislo, ktore sa ma pripocitat

	push offset Pole	;esp + 12
	push Dlzka			;esp + 8
	push Cislo			;esp + 4
	call Pripocitaj		;esp = navratova adresa
	exit

main ENDP
END main