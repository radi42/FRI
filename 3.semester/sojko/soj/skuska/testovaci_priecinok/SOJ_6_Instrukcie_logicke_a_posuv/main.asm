TITLE MASM Template(main.asm)

INCLUDE Irvine32.inc
.data
BLPredANDom DB "BL pred ANDom: ",0
BLPoANDe DB "BL po ANDe s maskou 11110111: ",0
Pismeno9 DB "Pismeno ",0
Cislo9 DB "Cislo ",0
VelkeCislo DQ "1234",0

.code
main PROC

Odriadkuj MACRO
	mov al, 0Ah
	call WriteChar
	mov al, 0Dh
	call WriteChar
ENDM

;and register/pamat, register/pamat/cislo
;pouziva sa, ked potrebujeme nastavit niektory bit resp. bity
;laveho operandu na 0. Do preaveho operandu ulozime
;masku, ktora bude mat v urcenych bitoch hodnotu 0,
;v ostatnych bitoch hodnotu 1
;napr. chceme vynulovat 3. bit registra bl
xor ebx, ebx
mov bl, 11111111b
mov edx, offset BLPredANDom
call WriteString
mov eax, ebx
call WriteInt
	Odriadkuj
and bl, 11110111b
mov edx, offset BLPoANDe
call WriteString
mov eax, ebx
call WriteInt
	Odriadkuj

;alebo napr chceme previest ACII kod cislice na hodnotu cisla
;1. sposob pomocou masky 00001111b a operacie AND
xor eax, eax
mov edx, offset Pismeno9
call WriteString
mov al, "9"			;al = "9"
call WriteChar
mov bl, al
	Odriadkuj
mov edx, offset Cislo9
call WriteString
mov al, bl
and al, 00001111b	;z pismena "9" sa stane cislo 9 tj. "9"->9 => al = 9
;v registri eax sa uz nachadza cislo
call WriteInt
	Odriadkuj

;konverzia ASCII kodu cislice na hodnotu cisla
;2. sposob - odcitanim 30h z registra eax
xor eax, eax
xor edx, edx
mov edx, offset Pismeno9
call WriteString
mov al, "9"	;al = "9"
call WriteChar
mov bl, al			;zalohujeme si register al do bl ("9"), lebo makro Odriadkuj meni register al
	Odriadkuj
mov edx, offset Cislo9
call WriteString
mov al, bl			;po odriadkovani vratime register al do povodneho stavu pomocou registra bl("9")
sub al, 30h	;z pismena "9" sa stane cislo 9
call WriteInt
	Odriadkuj

;or register/pamat, register/pamat/cislo
;pouziva sa, ked potrebujeme nastavit niektory bit resp. bity
;laveho operandu na 1. Do praveho operandu ulozime masku, ktora
;bude mat v urcenych bitoch hodnotu 1, v ostatnych bitoch hodnotu 0

;napr. chceme nastavit 3. bit registra bl na 1
xor bl, bl
mov eax, ebx
call WriteInt
	Odriadkuj
or bl, 00001000b
mov eax, ebx
call WriteInt
	Odriadkuj

;alebo chceme previest hodnotu cisla do ASCII kodu
xor eax, eax
mov al, 9		;cislo 9
call WriteInt
mov bl, al
	Odriadkuj
mov al, bl
or al, 110000b	;z cisla 9 sa stane pismeno "9"
call WriteChar
	Odriadkuj

;xor register/pamat, register/pamat/cislo
;pouziva sa, ked potrebujeme invertovat niektory bit resp. bity
;laveho operandu.
;Hodnota 1 v maske bity invertuje, 0 ponecha povodnu hodnotu

;napr. chceme invertovat horne 4 bity registra bl
xor ebx, ebx
mov bl, 01010101b	;85
mov al, bl
call WriteInt
	Odriadkuj
xor bl, 11110000b	;teraz invertujeme horne 4 bity registra bl, vznikne cislo 10100101b = 165
mov al, bl
call WriteInt
	Odriadkuj

;alebo napr nulovanie registra
xor ebx, ebx
mov eax, ebx
call WriteInt
	Odriadkuj
xor eax, eax

;test register/pamat, register/pamat/cislo (logicke porovnanie)
;logicky sucin bez ulozenia vysledku
;pouziva sa, ked chceme zistit, aku hodnotu ma
;zvoleny bit laveho operandu a podla toho vetvit vypocet

;napr. chceme vetvit vypocet podla 3. bitu registra bl
test bl, 00001000b
jz Nula; v 3. bite je 0
Jedna:	;radsej prazdne navestia nech sa nic nevykonava
Nula:

;not register/pamat (negacia jednotkovym doplnkom)
;invertuje vsetky bity operandu
;nemeni priznaky
xor ebx, ebx
mov bl, 11110000b	;240
mov al, bl
call WriteInt
	Odriadkuj
not bl				;teraz invertujeme vsetky bity registra bl, vznikne cislo 15
mov al, bl
call WriteInt
	Odriadkuj
	Odriadkuj

;instrukcie pre posuv a rotaciu
;lavym operandom je register alebo pamatove miesto
;(velkost bajtu, slova alebo dvojslova), ktoreho bity sa
;posuvaju doprava alebo dolava.
;Pravym operandom moze byt konstanta alebo register cl.
;Pravy operand urcuje, o kolko miest sa posunu bity laveho operandu

;shl register/pamat, cislo/cl (shift logical left)
;sal register/pamat, cislo/cl (shift arithmetic left)
;pouzivaju sa na rychle nasobenie cisel bez znamienka dvoma resp. 4-, 8- alebo 16-mi
xor eax, eax
mov eax, 2
call WriteInt
mov ebx, eax
	Odriadkuj
mov eax, ebx
shl ax, 4	;ax = (2^4) * ax = 16*ax
call WriteInt
	Odriadkuj

xor eax, eax
mov eax, 2
call WriteInt
mov ebx, eax
	Odriadkuj
mov eax, ebx
sal ax, 3	;ax = (2^3) * ax = 8*ax
call WriteInt
	Odriadkuj
	Odriadkuj
;JE ZREJME, ZE obidva prikazy shl a sal davaju rovnaky vysledok

;shr register/pamat, cislo/CL (shift logical right)
;celociselne delenie cisel BEZ ZNAMIENKA 2-, 4-,8- alebo 16-mi
;shr register/pamat, cislo/CL (shift logical right)
;celociselne delenie cisel SO ZNAMIENKOM 2-,4-,8- alebo 16-mi
xor eax, eax
xor ebx, ebx

mov bl, -4	; bl = -4 = 11111100b
mov eax, ebx
sub eax, 256
call WriteInt
	Odriadkuj
sar bl, 1	; bl = -2 = 11111110b
mov eax, ebx
sub eax, 256
call WriteInt
	Odriadkuj

mov bl, 32	; bl = 32 = 00010000b
mov eax, ebx
call WriteInt
	Odriadkuj
shr bl, 1	; bl = 16 = 00001000b
mov eax, ebx
call WriteInt
	Odriadkuj
	Odriadkuj

;instrukcie pre rotaciu
;menia flagy carry a overflow

;rol register/pamat, cislo/cl (rotate left)
;robi to iste ako shl resp. sal
;ror register/pamat, cislo/cl (rotate right)
;robi to iste ako shr resp. sar
mov bl, 32	; bl = 32 = 00100000b
mov eax, ebx
call WriteInt
	Odriadkuj
rol bl, 1	; bl = 64 = 01000000b
mov eax, ebx
call WriteInt
	Odriadkuj

mov bl, 32	; bl = 32 = 00100000b
mov eax, ebx
call WriteInt
	Odriadkuj
ror bl, 1	; bl = 16 = 00010000b
mov eax, ebx
call WriteInt
	Odriadkuj
	Odriadkuj

;rcl register/pamat, cislo/cl (rotate left through carry)
;rcr register/pamat, cislo/cl (rotate right through carry)
;pouziva sa pri posuvoch operandov ulozenych vo viac ako dvoch slovach
;pretoze naraz mozeme posunut nanajvys operand dlzky 32 bitov
;musime posuv dlhsich operandov robit po castiach (per bartez ;)

;napr chceme vynasobit dvoma premennu VelkeCislo typu qword
xor eax, eax
xor ebx, ebx

mov edx, offset VelkeCislo
call WriteString
	Odriadkuj
shl dword ptr VelkeCislo, 1
rcl dword ptr VelkeCislo + 4, 1
mov edx, offset VelkeCislo
call WriteString
	Odriadkuj
	Odriadkuj
;tu som trosku trolloval, lebo som pouzil retazec namiesto cisla v premennej VelkeCislo,
;aby som to nemusel prekonvertovat na retazec pre vypis



Koniec:
exit
main ENDP
END main