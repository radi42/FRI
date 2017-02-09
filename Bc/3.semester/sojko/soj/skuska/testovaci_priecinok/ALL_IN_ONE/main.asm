;Scitaj dve cisla
TITLE MASM Template(main.asm)

INCLUDE Irvine32.inc
.data
	EnterX DB "Enter X: ", 0		;keby retazce neboli ukoncene nulou, vypisali by sa najprv vsetky tri retazce potom posledne dva a nakoniec posledny retazec
	EnterY DB "Enter Y: ", 0
	Result DB "Result: ", 0
.code
newLine MACRO
	mov al, 0Ah
	call WriteChar
	mov al, 0Dh
	call WriteChar
ENDM
main PROC
	mov edx, offset EnterX
	call WriteString		;metoda WriteString vypisuje register EDX
	call ReadInt			;metoda ReadInt cita z registra EAX cislo so znamienkom
	mov ebx, eax

	mov edx, offset EnterY
	call WriteString
	call ReadInt
	add eax, ebx

	mov edx, offset Result
	call WriteString
	call WriteInt			;metoda WriteInt vypisuje z registra EAX cislo so znamienkom
	newLine

exit
main ENDP
END main




;Scitaj prvky pola
TITLE MASM Template(main.asm)

INCLUDE Irvine32.inc
.data
Z dword 1, 2, 3, 4, 5	;int z[] = {1, 2, 3, 4, 5}
j dword 5				;int j = 5 -> dlzka pola

.code
Sum PROC NEAR			;void Sum() {
Odriadkuj MACRO
	mov al, 0Dh
	call WriteChar
	mov al, 0Ah
	call WriteChar
ENDM

	mov esi, 0			;	esi = 0
	mov ecx, j			;	ecx = j
	mov eax, 0			;	eax = 0

;aj tymto sa da nahradit navestie Pripocitavaj
;@@do:					;	do{
;	add eax, Z[esi]		;		eax = eax + Z[esi]
;	add esi, 4			;		esi++
;@@while: loop @@do		;	} while (--ecx != 0)

Pripocitavaj:
	add eax, Z[esi]
	add esi, 4
	call WriteDec
	mov ebx, eax
	Odriadkuj
	mov eax, ebx
	loop Pripocitavaj

	ret					;	return	
Sum ENDP				;}

main PROC				;void main() {
	call Sum			;	Sum()
	;call WriteDec		;	write(eax)
	exit				;
main ENDP				;}
END main




;Vypis retazec
TITLE MASM Template(main.asm)

INCLUDE Irvine32.inc
.data
Retaz DB "No nazdar!", 0dh, 0ah
DlzkaRetazca EQU $-Retaz	;Konstanta sa deklaruje direktivou EQU.
							;Pocet znakov v retazci zistime tak, ze vytvorime konstantu, ktora bude mat hodnotu $-Retaz

.code
main PROC
mov ebx, offset Retaz; uloz do ebx adresu 1. znaku retazca
mov edi, 0	;prvy znak ma index 0
mov ecx, DlzkaRetazca

Vypis:	mov al, Retaz[edi]
		call WriteChar
		inc edi
		loop Vypis
Koniec:
exit
main ENDP
END main




;Vypis prvky pola (ekvivalent s kodom "Vypis retazec")
TITLE MASM Template(main.asm)

INCLUDE Irvine32.inc
.data
A dword 10,20,30,40,50
n dword 5

.code
print PROC NEAR
	mov esi, 0
	mov ecx, n
Vypisuj:
	mov eax, A[esi]
	call WriteDec
	call CrLf
	add esi, 4
	loop Vypisuj
	ret
print ENDP

main PROC
	call print
	exit
main ENDP
END main



;vypis prvky pola aj s ich suctom
;vypise prvky pola a sucet vsetkych prvkov pola
INCLUDE Irvine32.inc
.data
		A		dword	10, 20, 35, 442, 5	; int A[] = {10, 20, 35, 442, 5}
		n		dword	5			; int n = 5
		Total	dword	?			; int Total;
		TotalString byte	"Total: ", 0	; String TotalString="Total: "
.code

	;procedura Sum	- sucet vsetkych prvkov pola
	Sum	PROC NEAR							; void Sum() { 
			mov		eSi, 0				;	eSi = 0
			mov		eAx, 0				;	total = 0
			mov		eCx, n				;	eCx = n
	@do:	add		eAx, A[eSi*4]		;	do{ 
			inc		eSi					;	   total = total + A[eSi]
	@while:	loop		@do				;	   eSi++
			mov		Total, eAx			;	} while( --eCx != 0 )	
			ret							;	return
	Sum		ENDP						

	;Procedura print - vypis jedotlivych prvkov pola a ich suctu
	print	PROC NEAR						; void print() {
			mov		eSi, 0				;	eSi = 0			
			mov		eCx, n				;	eCx = n

	;tymto cyklom sa vypisuju jednotlive prvky
	 @@do:								;	do {
			mov		eAx, A[ eSi ]		;		write( A[ eSi ] )
			Call	WriteDec			;		write( CRLF )
			Call	CrLf				;	} while( --eCx != 0 )
			add		eSi, 4
	@@while:	loop		@@do
			
			;teraz sa vypise sucet vsetkych prvkov pola
			mov		eDx, OFFSET TotalString	;	write("Total: ")
			call	WriteString
			mov		eAx, Total				;	write( Total )
			call	WriteDec
			call	CrLf
			ret								;	return
	print	ENDP		  					;	}

	;procedura main
	main	PROC							; void main() {
			call	Sum						;	Sum()
			call	print					;	print()
			exit							; }
	main		ENDP

END 		main




;SOJ_5_Instrukcie_presunu_a_aritmeticke_operacie
TITLE MASM Template(main.asm)

INCLUDE Irvine32.inc
.data
Pocet DB 10 dup(0)
EnterECX DB "Zadajte cislo do ECX: ", 0
EnterEBX DB "Zadajte cislo do EBX: ", 0
TextECX DB "V registri ECX je ",0
TextEBX DB "V registri EBX je ",0
XchgECX DB "(xchg) V registri ECX je teraz ",0
XchgEBX DB "(xchg) V registri EBX je teraz ",0
StyristoPatDeleno10 DB "405 div 10 = ",0
StyristoStyriIDeleno10 DB "404 idiv 10 = ",0
Zvysok DB " zvysok ",0

.code
Odriadkuj MACRO
	mov al, 0Ah
	call WriteChar
	mov al, 0Dh
	call WriteChar
ENDM

main PROC
mov ebx, offset Pocet
mov edi, 0

Vypis:	mov al, Pocet[edi]
		;Chceme do EBX ulozit adresu premennej Pocet zvacsenu o EDI
		;mov ebx, offset Pocet[edi];toto nebude fungovat, treba pouzit metodu lea
		lea ebx, Pocet[edi]
		mov eax, ebx
		call WriteInt	;metoda WriteInt pracuje s registrom eax
		Odriadkuj

		;testovanie operacii movzx, movsx, xchg
		xor ecx, ecx
		xor ebx, ebx
		mov edx, offset EnterECX
		call WriteString
		call ReadInt		;prve cislo bude v ECX
		call WriteInt
		mov ecx, eax
			Odriadkuj
		mov edx, offset EnterEBX
		call WriteString
		call ReadInt
		call WriteInt
		mov ebx, eax		;druhe cislo bude v EBX
			Odriadkuj
		
		;xchg vymeni obsahy operandov
		xchg ecx, ebx
		mov edx, offset XchgECX
		call WriteString
		mov eax, ecx
		call WriteInt
			Odriadkuj
		mov edx, offset XchgEBX
		call WriteString
		mov eax, ebx
		call WriteInt
			Odriadkuj

		;movzx skopiruje pravy operand do dolnej polovice laveho operandu a hornu polovicu laveho operandu naplni nulami
		;najlepsie vidiet pri vacsich cislach
		movzx ecx, bx
			Odriadkuj
		mov eax, ecx
		call WriteInt
			Odriadkuj
		mov eax, ebx
		call WriteInt
			Odriadkuj

		;movsx skopiruje pravy operand do dolnej polovice laveho operandu a hornu polovicu laveho operandu naplni hodnotou znamienkoveho bitu praveho operandu
		;najlepsie vidiet pri vacsich cislach
		movsx ecx, bx
			Odriadkuj
		mov eax, ecx
		call WriteInt
			Odriadkuj
		mov eax, ebx
		call WriteInt
			Odriadkuj
			Odriadkuj
		;add, scita dva operandy, vysledok ulozi do laveho operandu
		add ebx, ecx
		mov edx, offset TextEBX
		call WriteString
		mov eax, ebx
		call WriteInt
			Odriadkuj

		;sub, odcita pravy operand od laveho, vysledok ulozi do laveho operandu
		sub ecx, ebx
		mov edx, offset TextEBX
		call WriteString
		mov eax, ecx
		call WriteInt
			Odriadkuj
		
		;adc scita operandy a carry flag, vysledok ulozi do laveho operandu
		;pouziva sa pri scitani operandov dlhsich nez je velkost registra
		;bohuzial priklad z prednasky nefunguje
		;mov eax, dword ptr A
		;add eax dword ptr B
		;mov dword ptr C, eax

		;mov eax, dword ptr A+4
		;adc eax, dword ptr B+4
		;mov dword ptr c+4, eax

		;sbb odcita pravy operand a carry flag od laveho operandu, vysledok ulozi do laveho operandu
		;pouziva sa pri scitani operandov dlhsich nez je velkost registra

		;mul nasobenie cisel bez znamienka
		;mul register/pamat (unsigned) tj nasobenie cisel urcene pre cisla bez znamienka
		;typ operandu	cim sa nasobi	vysledok sa ulozi do
		;byte (DB)		al				ax
		;word (DW)		ax				dx:ax
		;dword (DD)		eax				edx:eax

		xor eax, eax
		xor ebx, ebx
		mov al, 10
		mov bl, 3
		mul bl; vynasobi al=al*bl, vysledok ulozi do al
		call WriteInt
			Odriadkuj
		
		;imul register/pamat (signed)
		;platia tie iste implicitne registre ako pre mul, len je to urcene pre cisla so znamienkom
		mov ax, 9
		mov bx, 5
		imul bx; ax = bx*ax
		call WriteInt
			Odriadkuj

		;imul register, register/pamat/konstanta
		;lavy operand = lavy * pravy
		;obidva operandy musia mat rovnaky typ (word / dword)
		mov edi, 3
		imul ax, di
		call WriteInt
			Odriadkuj

		;imul register, register/pamat, konstanta
		;lavy operand = prostredny * pravy
		;lavy a prostredny operand musia mat rovnaky typ
		imul eax, edi, 5
		call WriteInt
			Odriadkuj

		;div register/pamat (unsigned)
		;celociselne delenie cisel bez znamienka
		;delenec	typ operandu (delitela)		podiel	zvysok
		;ax			byte						al		ah
		;dx:ax		word						ax		dx
		;edx:eax	dword						eax		edx
		mov ax, 405	;delenec
		mov bx, 10	;delitel
		mov dx, 0
		div bx;		bx = ax div bx => vysledok sa uklada do delitela
		mov edx, offset StyristoPatDeleno10
		call WriteString
		mov eax, ebx
		call WriteInt
			Odriadkuj

		;idiv register/pamat
		;celociselne delenie cisel so znamienkom
		;implicitne operandy rovnake ako pri div
		mov ax, 404	;delenec
		mov bx, 10	;delitel
		mov dx, 0
		idiv bx;	bx = ax div bx => vysledok sa uklada do delitela
		mov edx, offset StyristoStyriIDeleno10
		call WriteString
		mov eax, ebx
		call WriteInt
			Odriadkuj

		;znamienkove rozsirenia
		;pred delenim operandov rovnakeho typu so znamienkom
		;musime zabezpecit, aby horna polovica delenca bola 
		;znamienkovym rozsirenim dolnej
			;cbw (convert byte to word)
		;konvertuje AL do AX, pricom sa vsetky bity registra ah naplnia
		;hodnotou najvyssieho bitu registra al
		;napr ked chceme vydelit cislo -15 v registri BH
		;cislom 2 v registri BL
		mov bh, -15	;bh = F1h
		mov bl, 2
		mov al, bh	;al = F1h
		cbw			;ax = FFF1h
		idiv bl		;al = ax idiv bl = -15 idiv 2 = F9h
					;ah = FFh = -1
		xor ebx, ebx
		xor ecx, ecx
		mov bl, al
		mov cl, ah
		mov eax, ebx
		sub eax, 256	;treba odcitat 2^n, kde n je pocet bitov registra (al: n=8, ax: n=16, eax: n=32)
		call WriteInt

		mov edx, offset Zvysok
		call WriteString
		mov eax, ecx
		sub eax, 256
		call WriteInt
			Odriadkuj

		;cwd (convert word to doubleword)
		;konvertuje ax do dx:ax

		;cwde (convert word to doubleword extended)
		;konvertje ax do eax

		;instrukcie typu cbw nemenia priznaky

		;cdq (convert dword to qword)
		;konvertuje eax do edx:eax

		;neg register/pamat (negacia dvojkovym doplnkom)
		;zmeni znamienko perandu (nahradi operand 
		;jeho dvojkovym doplnkom)
		mov al, -15	;al = -15 = 11110001b = F1h
		neg al		;al =  15 = 00001110b + 00000001 = 00001111b = 0Fh
		mov bl, al	;bl =  15 = 00001111b = 0Fh
		neg bl		;bl = -15 = 11110001b = F1h

Koniec:
exit
main ENDP
END main




;SOJ_6_Instrukcie_logicke_a_posuv
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




;SOJ_7_Skoky_prvy_program
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




;SOJ_7_Skoky_druhy_program
TITLE MASM Template(main.asm)

INCLUDE Irvine32.inc
.data
MaxPocet EQU 80
Retaz DB MaxPocet dup(?)

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

;podmienene skoky
;umoznuju vetvit program v zavislosti od nastavenia flagov zero, carry, overflow, pl a pe

;jcc navestie
;kde cc je condition code (napr be (jbe))

;Porovnanie cisel BEZ ZNAMIENKA
;instr.		vyznam - jump if		podmienka
;jb			below					cy(carry) = 1
;jnae		not above or equal		
;jc			carry					

;jae		above or equal			cy = 0
;jnb		not below				
;jnc		not carry				
		
;jbe		below or equal			cy = 0 alebo zr (zero) = 1
;jna		not above				
		
;ja			above					cy = 0 a zr = 0
;jnbe		not below or equal		

;Porovnanie cisel SO ZNAMIENKOM
;instr.		vyznam - jump if		podmienka
;jl			less					PL (zrejme sign flag) != OV
;jnge		not greater or equal

;jge			greater or equal		pl = ov
;jnl			not less

;jle			less or equal			zr = 1 alebo PL != OV
;jng			not greater

;jg			greater					zr = 0 a pl = ov
;jnle		not less or equal

;je		equal						zr = 1
;jz		zero

;jne		not equal					zr = 0
;jnz		not zero

;jp		parity						pe (parity even flag) = 1
;jpe		parity even

;jnp		not parity					pe = 0
;jpo		parity odd

;js		sign						pl = 1
;jns		not sing					pl = 0
;jo		overflow					ov = 1
;jno		not overflow				ov = 0
;jcxz	cx = 0						cx = 0
;jecxz	ecx = 0						ecx = 0

;Instrukcie cyklu
;nemenia priznaky

;loop navestie
;dekrementuje register ecx a porovna ho s 0, pricom
;NEZMENI PRIZNAKOVE BITY. ak je novy ecx != 0, vykona sa skok na navestie.
;Inak spracovanie programu pokracuje nasledujucou instrukciou
;navestie oznacuje prvu instrukciu cyklu

;loope navestie
;loopz navestie
;dekrementuju ecx a porovnaju ho s 0
;ak je novy obsah registra ecx != 0 a zr = 1, vykona
;sa skok na navestie

;loopne navestie
;loopnz navestie
;dekrementuju ecx a porovnaju ho s 0
;ak je novy obsah registra ecx != 0 a zr = 0, vykona
;sa skok na navestie

;napr. citajte znaky zadavane z klavesnice a 
;ukladajte ich do premennej Retaz, kym nestlacite
;enter alebo nezadate MaxPocet znakov
;nacitanie znakov z klavesnice do pola

		mov ecx, MaxPocet
		jcxz Koniec
		mov ebx, offset Retaz	;uloz do ebx adresu 1. znaku Retazca
		mov edi, 0				;prvy znak ma index 0

Citaj:	call ReadChar			;nacita znak do al
		call WriteChar			;vypise znak z al na terminal
		mov [ebx + edi], al		;uloz znak do premennej retaz
		inc edi					;posun sa o jeden znak dopredu
		cmp al, 0Dh
		loopne Citaj			;ak nie je enter, pokracuj dalej

Koniec:
exit
main ENDP
END main




;SOJ_8_Procedury_prvy_program
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




;SOJ_8_Procedury_druhy_program
TITLE MASM Template(main.asm)

INCLUDE Irvine32.inc
.data
Pole DB 0,1,2,3,4 
Dlzka DD $-Pole
Cislo EQU 1

.code
Pripocitaj PROC pascal paOffset, paDlzka, paCislo:byte
	mov ebx, paOffset
	mov ecx, paDlzka
	mov al, paCislo
Cyklus:
	add [ebx], al

	;skoda, ze to vypisuje adresu v pamati a nie prvok z pola
	mov eax, ebx
	call WriteInt

	mov al, 0Dh
	call WriteChar
	mov al, 0Ah
	call WriteChar

	inc ebx
	loop cyklus
	ret
Pripocitaj ENDP
;prekladac automaticky doplni ramec zasobnika
;push ebp
;mov ebp, esp
;a na konci procedury
;leave
;ret 0Ch

main PROC

Odriadkuj MACRO
	mov al, 0Dh
	call WriteChar
	mov al, 0Ah
	call WriteChar
ENDM
;Formalne parametre a specifikacia jazyka
;Pri deklaracii procedury v direktive PROC mozeme
;parametrom procedury priradit symbolicke mena.
;Potom k parametrom mozeme pristupovat pomocou 
;tychto mien, a nie cez nepriamu adresu s registrom EBP

;Vyhody:
;-citatelnejsi kod procedury
;-nemusime si pamatat vzialenost parametrov od
;vrcholu zasobnika

;Kazdemu formalnemu parametru mozeme predpisat typ
;Ak neuvedieme typ parametra, predpoklada sa dword

;Specifikacia programovacieho jazyka pri volani
;procedury

;Jazyk			parametre sa ukladaju	parametre vyberie
;				do zasobnika			zo zasobnika
;------------------------------------------------------------
;pascal			zlava doprava			procedura (v prikaze ret n)
;basic
;fortran

;C				sprava dolava			volajuci program (add, sp.n)
;Prolog

;stdcall			sprava dolava			procedura
;(v 32-bit
;aplikaciach,
;pri volani
;sluzieb 
;Windows)

	push offset Pole
	push Dlzka  
	push Cislo  
	call Pripocitaj
	add esp, 0Ch
	exit
main ENDP
END main




;SOJ_8_Procedury_treti_program
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




;SOJ_8_Procedury_stvrty_program
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




;SOJ_9_Priznaky_Retazce_prvy_program-retazce
TITLE MASM Template(main.asm)

INCLUDE Irvine32.inc
.data
zdroj DD 20 dup(0FFFFFFFFh)
ciel DD 20 dup(0)

.code
main PROC

;Instrukcie pre nastavenie priznakovych bitov
;nastavuju jeden priznakovy bit, ostatne priznaky
;nemenia
;nemaju operandy

;clc (clear carry flag)
;CF = 0

;stc (set carry flag)
;CF = 1

;cmc (complement carry flag)
;CF nefunguje

;cld (clear directoin flag)
;DF = 0

;std (set direction flag)
;DF = 1

;cli (clear interrupt flag)
;IF = 1

;sti (set interrupt flag)
;IF = 1

;lahf (load flags into AH register)
;skopiruje dolnych 8 bitov registra EFLAGS
;do registra AH

;sahf (store AH register to flags)
;skopiruje AH do dolneho bajtu refistra EFLAGS


;Retazcove instrukcie
;Sluzia na spracovanie poli typu byte, word a dword
;Pred vykonanim retazcovej instrukcie musime
;do ESI ulozit adresu (offset) zdrojoveho retazca
;a do EDI adresu cieloveho retazca
;Registre ESI a EDI sluzia ako indexi - po
;vykonani operacie s jednym prvkom retazca
;(skopirovani , porovnani, ...) sa index
;automaticky aktualizuje, tj. k registru ESI
;resp EDI sa pripocita alebo odpocita tolko bajtov,
;ktore zabera jeden prvok retazca (1, 2 alebo 4 v
;zavislosti od typu retazca).

;hodnota DF		vplyv na ESI a EDI		Smer spracovania retazca	Poradie adries
;0				zvysuje sa				dopredu						od nizsich k vyssim
;1				znizuje sa				dozadu						od vyssich k nizsim

;Typ retazca oznamime instrukcii bud tak, ze meno retazca
;uvedieme ako operand instrukcie, alebo zapiseme
;instrukciu bez operandov, ale s priponou b, w, resp d

;Prefix rep opakuje retazcovu instrukciu, kym sa nevynuluje 
;register ECX. Ak je na zaciatku ecx = 0, instrukcia
;sa nevykona ani raz

;movs ciel. retazecm zdroj. retazec (move data from string to string)
;movsb
;movsw
;movsd
;skopiruje data z pamati, na ktoru ukazuje ESI
;do pamati, na ktoru ukazuje EDI
;nemeni priznaky ani AL, ani AX, ani EAX

;instrukcia		kopiruje		ESI a EDI sa zvysi/znizi o
;movsb			byte			1
;movsw			word			2
;movsd			dword			4

;PRIKLAD
;skopirujte pole 20 celych cisel typu dword
;z premennej zdroj do premennej ciel

cld		;smer = dopredu
mov ecx, LENGTH zdroj	;nastavi pocet opakovani
mov esi, OFFSET zdroj	;ESI ukazuje na zdroj
mov edi, OFFSET ciel	;EDI ukazuje na ciel
rep movs ciel, zdroj
mov eax, offset ciel
call WriteInt
exit

main ENDP
END main




;SOJ_9_Priznaky_Retazce_druhy_program-retazce
TITLE MASM Template(main.asm)

INCLUDE Irvine32.inc
.data
Dlzka EQU 20
Pole DW Dlzka dup(0FFFFh)

.code
main PROC

;lods zdrojovy retazec (load data from string)
;lodsb
;lodsw
;lodsd
;skopiruje bajt retazca do AL resp do AX resp do EAX
;nemenia priznaky

;cld
;mov esi, offset Retazec
;lodsb		;efektivnejsie

;je to iste ako

;mov al, [esi]
;inc esi


;stos ciel. retazec (store data to string)
;stosb
;stosw
;stosd
;skopiruje obsah al resp ax resp eax do retazca
;nemeni priznaky

;priklad
;pomocou retazcovej instrukcie stosw vynulujte Pole
cld		;smer = dopredu
mov edi, offset Pole
mov ecx, Dlzka
xor ax, ax		;ax = 0
rep stosw




exit
main ENDP
END main




;SOJ_9_Priznaky_Retazce_treti_program-retazce
TITLE MASM Template(main.asm)

INCLUDE Irvine32.inc
.data
menoSuboru DB 20 dup(?)

.code
main PROC

;scas ciel. retazec	(scan string)
;scasb
;scasw
;scasd
;porovna bajt /slovo /dvojslovo retazca s obsahom
;registra al / ax / eax tak ze odcita prvok
;retazca od al /ax / eax a nastavi priznaky

;cmps ciel. retazec, zdroj retazec (compare string operands)
;cmpsb
;cmpsw
;cmpsd
;porovna retazce tak, ze bajt / slovo/dvojslovo
;cieloveho retazca odcita od bajtu / slova/dvojslova
;zdrojoveho retazca a nastavi priznaky

;Prefix repe (repz) opakuje retazovu instrukciu, kym
;ECX != 0 a zaroven ZF = 1. Ak je na zaciatku ECX = 0
;instrukcia sa nevykona ani raz

;Prefix repne (repnz) opakuje retazovu instrukciu, kym
;ECX != 0 a zaroven ZF = 0. Ak je na zaciatku ECX = 0
;instrukcia sa nevykona ani raz

;priklad
;nacitajte meno suboru. najdite v nom bodku

	mov edx,offset menoSuboru
	mov ecx,20
	call ReadString; nacitaj meno suboru

	mov ecx,eax; uloz skutocnu dlzku mena do ecx
	mov al,'.'
	cld
	mov edi,edx
	repne scasb; edi ukazuje za '.', ak tam je
	jne NieJe
	dec edi; edi ukazuje na bodku

NieJe:

exit
main ENDP
END main




;SOJ_9_Priznaky_Retazce_stvrty_program-matice
TITLE MASM Template(main.asm)

INCLUDE Irvine32.inc
.data
Matica DW 10h, 20h, 30h, 40h, 50h
DlzkaRiadku EQU $-Matica
DW 60h, 70h, 80h, 90h, 0A0h
DW 0B0h, 0C0h, 0D0H, 0E0h, 0F0h

.code
main PROC

;Dvojrozmerne polia
;obvykle ulozene po riadkoch
;na pristup k prvkom pola sa pouziva nepriame
;adresovanie s bazou, indexom a posunutim,
;kde posunutie je meno pola

;meno_pola[baza+index]

;baza je offset riadku v ramci pola
;index je offset stlpca v ramci riadku

;tj. meno_pola[riadok + stlpec]

;aj riadku aj stlpce su cislovane od nuly

;Priklad
;ulozte do registra AX zvoleny prvok dvojrozmerneho
;pola Matica

IndexRiadku EQU 1
IndexStlpca EQU 2

mov ebx, DlzkaRiadku * IndexRiadku
mov esi, IndexStlpca
mov ax, Matica[ebx + esi*type Matica]	;AX = 80h

exit
main ENDP
END main




;SOJ_9_Priznaky_Retazce_piaty_program-matice
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




;SOJ_10_MS-Windows programming-prvy_program_MessageBox
TITLE MASM Template(main.asm)

INCLUDE Irvine32.inc
.data
DialogBoxCaption DB 'Warning',0
DialogBoxText DB 'Tento program trva prilis dlho!',0


.code
main PROC

;Funkcia MessageBox
; vytvor message box
push MB_OK or MB_ICONWARNING
push offset DialogBoxCaption
push offset DialogBoxText
push NULL
call MessageBoxA



exit
main ENDP
END main




;SOJ_10_MS-Windows programming-subory_teoria+druhy_program
TITLE MASM Template(main.asm)

INCLUDE Irvine32.inc
.data
MenoSub		DB 'Retaz.txt',0
Text		DB 'Ahoj!',0Dh,0Ah
PocetZnakov	DD $-Text
FileHandle	DD ?
PocetBytov	DD ?

.code
main PROC

;suborove sluzby windows
;Pri prvej operacii so suborom (pri vytvoreni noveho
;alebo otvoreni existujuceho suboru) musime ako
;vstupny parameter odovzdat sluzbe meno suboru

;Meno suboru je retazec ukonceny nulou. Moze
;obsahovat specifikaciu disku a cestu napr

;File1 DB 'MOJ.ASM',0
;File2 DB 'C:\USERS\JANOSIK\TEST.TXT',0

;sluzba prideli suboru 32 bitove identifikacne
;cislo-popisovac (file handle). Musime si ho zapamatat,
;pretoze pri dalsich operaciach (citani, zapise,
;zatvoreni) identifikujeme subor pomocou tohto
;cisla, a nie jeho menom

;HANDLE CreateFile(
	;LPCTSTR lpFileName, 
	;DWORD dwDesiredAccess, 
	;DWORD dwShareMode,	
	;LPSECURITY_ATTRIBUTES lpSecurityAttributes, 
	;DWORD dwCreationDisposition,	
	;DWORD dwFlagsAndAttributes,	
	;HANDLE hTemplateFile 	
;); 

;Parameter hTemplateFile - popisovac suboru, ktoreho atributy sa prevezmu
;- moze byt bud popisovac otvoreneho suboru, alebo moze mat hodnotu NULL. 
;Ak sa vytvara novy subor, funkcia ignoruje atributy odovzdane v parametri dwFlagsAndAttributes a pouzije atributy suboru urceneho tymto popisovacom. 
;Ak funkcia otvara existujuci subor, parameter sa ignoruje.

;Parameter dwFlagsAndAttributes
;Vybrane atributy:
;Hodnota						Vyznam
;FILE_ATTRIBUTE_READONLY (1)		Aplikacia moze citat zo suboru, ale nemoze donho zapisovat alebo ho vymazat.
;FILE_ATTRIBUTE_HIDDEN (2)		Subor sa nezobrazi v listingu adresara.
;FILE_ATTRIBUTE_ARCHIVE (20h)	Aplikacie pouzivaju tento atribut na oznacenie suborov, ktore sa maju zalohovat.
;FILE_ATTRIBUTE_NORMAL (80h)		Najcastejsia hodnota. Nemoze sa kombinovat s inymi atributmi.
;FILE_ATTRIBUTE_TEMPORARY (100h)	Docasny subor. Operacny system sa snazi udrziavat data v pamati a neukladat ich na disk (kvoli rychlejsiemu pristupu). Aplikacia by mala docasny subor vymazat, ked ho uz nepotrebuje.

;Parameter dwCreationDisposition - co sa ma robit, ak subor uz existuje, resp. neexistuje
;Hodnota				Vyznam
;CREATE_NEW (1)			Funkcia vytvori novy subor. Ak subor rovnakeho mena uz existuje, vyhlasi chybu.
;CREATE_ALWAYS (2)		Vytvori novy subor. Ak subor rovnakeho mena uz existuje, funkcia ho prepise.
;OPEN_EXISTING (3)		Otvori existujuci subor. Ak subor neexistuje, funkcia vyhlasi chybu. 
;OPEN_ALWAYS (4)			Otvori existujuci subor. Ak subor neexistuje, funkcia ho vytvori.
;TRUNCATE_EXISTING (5)	Otvori existujuci subor a nastavi jeho dlzku na 0 bajtov. Ak subor neexistuje, funkcia vyhlasi chybu. Subor musi byt otvoreny so sposobom pristupu GENERIC_WRITE.

;Parameter lpSecurityAttributes - adresa struktury SECURITY_ATTRIBUTES
;- nastavuje prava pristupu k suboru a urcuje, ci popisovac suboru bude dedicny (cim by pristup k suboru ziskali aj synovske procesy). 
;Ak chceme pouzit implicitne hodnoty zabezpecenia (k objektu ma pristup ten, kto ho vytvoril a administrator) a popisovac sa nema dedit => NULL.

;Parameter dwShareMode - rezim zdielania, napriklad:
;Hodnota								Vyznam
;0										Aplikacia pozaduje vyhradny pristup k suboru.
;FILE_SHARE_READ (1)					Ine procesy mozu subor otvorit pre citanie.
;FILE_SHARE _WRITE (2)					Ine procesy mozu subor otvorit pre zapis.
;FILE_SHARE_READ or FILE_SHARE_WRITE	Subor bude zdielany v rezime citania aj zapisu.

;Parameter dwDesiredAccess  - pozadovany pristup
;Hodnota						Vyznam
;0								Aplikacia chce zistit, ci subor existuje alebo ake ma atributy, napr. cas poslednej zmeny. 
;GENERIC_READ (80000000h)		zo suboru sa bude citat
;GENERIC_WRITE (40000000h)		do suboru sa bude zapisovat
;GENERIC_READ or GENERIC_WRITE	subor je urceny aj na citanie aj na zapis


;ReadFile
;- cita udaje zo suboru od pozicie danej hodnotou ukazovatela v subore. Ak citanie prebehlo bez chyby, vrati true, inak false.
;---------------------------------------------------------
;BOOL ReadFile(
;HANDLE hFile, // popisovac suboru 
;LPVOID lpBuffer, // adresa premennej, do ktorej sa ulozia
;  precitane data  
;DWORD nNumberOfBytesToRead, // pocet bajtov, ktore sa maju
;  precitat 
;LPDWORD lpNumberOfBytesRead, // adresa premennej, do 
;  ktorej sa ulozi pocet precitanych bajtov 
;LPOVERLAPPED lpOverlapped   // adresa struktury, ktora sa
;  pouziva pri asynchronnom pristupe (pri synchronnom pristupe
;  k suboru je hodnota tohto parametra NULL)
;); 


;WriteFile
;zapisuje do suboru od pozicie danej hodnotou
;ukazovatela v subore
;parametre a navratova hodnota ako ReadFile
;-----------------------------------------
;BOOL  WriteFile(
;HANDLE hFile, 
;LPVOID lpBuffer, 
;DWORD nNumberOfBytesToWrite, 
;LPDWORD lpNumberOfBytesWritten, 
;LPOVERLAPPED lpOverlapped );



;CloseHandle
;zatvori subor
;----------------------------------
;BOOL CloseHandle(
;    HANDLE hObject 	// popisovac suboru  
;   ); 


;PRIKLAD
;Zapiste do suboru retazec ulozeny v premennej Text

;vytvor subor MenoSub	(HANDLE CreateFile vid 31. riadok kodu)
	push NULL	
	push FILE_ATTRIBUTE_NORMAL	
	push CREATE_ALWAYS	
	push NULL	
	push 0; nezdielat	
	push GENERIC_WRITE	
	push offset MenoSub	
	call CreateFileA 	
	mov FileHandle,eax; odloz popisovac

;zapis Text do suboru	(BOOL WriteFile)
	push NULL	
	push offset PocetBytov	
	push PocetZnakov	
	push offset Text	
	push FileHandle	
	call WriteFile	; zatvor subor	
	push FileHandle	
	call CloseHandle

exit
main ENDP
END main




;SOJ_10_MS-Windows programming-subory-treti_program-nacitaj_cislo_bez_znamienka
TITLE MASM Template(main.asm)

INCLUDE Irvine32.inc
.data
MenoSub		DB 'Cislo.txt',0
Znak		DB ?
PocetZnakov	DD 1
FileHandle	DD ?
PocetBytov	DD ?
Desat		DW 10

.code
main PROC

;PRIKLAD
;Nacitajte cele cislo bez znamienka ako retazec 
;z textoveho suboru Cislo.txt. Vypocitajte jeho
;hodnotu a ulozte ju do registra AX.

;otvor subor na citanie
	push NULL
	push FILE_ATTRIBUTE_NORMAL
	push OPEN_EXISTING
	push NULL
	push 0		;nezdielat
	push GENERIC_READ
	push offset MenoSub
	call CreateFileA
	mov FileHandle, eax		;odloz popisovac

	xor eax, eax
;citaj po jednej cislici a konvertuj na cislo
Citaj:
	push eax ; odloz docasny vysledok
	push NULL
	push offset PocetBytov
	push PocetZnakov
	push offset Znak
	push FileHandle
	call ReadFile
	pop eax
	cmp Znak,0Dh; je Enter?
	je Koniec
	mul Desat; ax = ax*10
	movzx cx,Znak
	sub cl,'0'
	add ax,cx
	jmp Citaj

Koniec:
	push FileHandle
	call CloseHandle
	exit
main ENDP
END main




;SOJ_11_FPU-Realna_aritmetika
TITLE MASM Template(main.asm)

INCLUDE Irvine32.inc
.data
sPrompt DB "zadaj cislo: ",0

.code
pytagor PROC pascal a:word, b:word
	finit;		st(0)	st(1)	st(2)
	fild a;		a
	fild a;		a		a
	fmul;		a*a
	fild b;		b		a*a
	fild b;		b		b		a*a
	fmul;		b*b		a*a
	fadd; (a*a)+(b*b)
	fsqrt; odmocnina z vyrazu zostane v st(0)
	ret
pytagor ENDP

main PROC

;Realna aritmetika
;Operacie s desatinnnymi cislami
;spracovana cez FPU (Floating Point Unit)

; 8 univerzalnych 80-bitovych registrov R0 az R7
; obsahuju operandy instrukcii
; su organizovane ako zasobnik
; v instrukciach sa oznacuju st(0) az st(7), pricom index je relativny voci vrcholu zasobnika

;zaokruhenie na 3 des. miesta
;Metoda					1.0111		-1.0111
;k najblizsiemu cislu	1.100		-1.100
;dole (k -nekonecnu)	1.011		-1.100
;hore (k +nekonecnu)	1.100		-1.011
;odrezanie (k 0)		1.011		-1.011

;Instrukcny subor FPU

;Instrukcie pre kopirovanie udajov

;fld real32 / real64 / real80 / st(i)	(load)
;fild int16 / int32 / int64		(integer load)
;fbld BCD							(BCD load)
;ulozi (skopiruje) operand do st(0)
;autoaticky sa vykona konverzia do interneho formatu FPU
;operand: premenna/register st(i)

;fst real32 / real64 / st(i)		(store)
;fist int16 / int32		(integer store)
;skopiruje hodnotu z registra st(0) do operandu
;automaticky sa vykona konverzia do potrebneho 
;formatu

;fstp real32 / real64 / real80 / st(i)	(store and pop)
;fistp int16 / int32 / int64	(integer store and pop)
;fbstp BCD							(BCD store and pop)
;skopiruje hodnotu z registra st(0) do zadaneho
;operandu a vyberie polozku z vrcholu zasobnika
;i je index PRED vyberom

;fxch st(i)		(exchange registers)
;vymeni obsahy registrov st(0) a st(i)
;fxch bez operandu vymeni obsahy registrov st(0) a st(1)

;Aritmeticke instrukcie

;fadd real32/real64
;fiadd int16/int32
;pripocita operand k st(0)

;fadd st(0), st(i)
;fadd st(i), st(0)
;scita operandy a vysledok ulozi do praveho operandu

;faddp st(i), st(0)
;st(i) = st(i) + st(0) a odstrani polozku z vrcholu
;zasobnika

;fadd a faddp bez operandov urobia to iste ako
;faddp st(1), st(0)

;odcitanie: fsub
;nasobenie:	fmul
;delenie:	fdiv
;reverzne odcitanie: fsubr (prehodi sa poradie
;operandov)

;fsub urobi: st(1) = st(1) - st(0) a vyberie st(0)
;fsubr urobi:st(1) = st(0) - st(1) a vyberie st(0)

;reverzne delenie: fdivr (prehodi sa delenec a 
;delitel)

;Instrukcia		Operacia s st(0)
;fchs			st(0) = -st(0)	zneguje cislo
;fsqrt			st(0) = druha odmocnina z st(0)
;fabs			st(0) = |st(0)| absolutna hodnota st(0)
;fsin			st(0) = sin(st(0))
;fcos			st(0) = cos(st(0))

;Instrukcie porovnavacie
;fcom real32/real64/st(i)	(compare)
;ficom int16/int32	(integer compare)
;porovna operand s registrom st(0) a nastavi
;bity c0, c2 a c3 v stavovom registri

;fcomp real32/real64/st(i)	(compare and pop)
;ficomp int16/int32	(integer compare and pop)
;porovna operand s registrom st(0), nastavi bity
;c0, c2 a c3 v stavovom registri a odstrani polozku
;zo zasobnika

;fcom a fcomp maju implicitny operand st(1)

;fcompp	(compare and pop twice)
;porovna st(1) s st(0), nastavi bity c0, c2 a c3
;v stavovom registri a odstrani obidve polozky
;zo zasobnika

;ftst	(test stack top)
;porovna st(0) s 0
;Nastavenie bitov c3, c2 a c0 podla vysledku
;porovnania:
;c3  c2  c1		vysledok operacie
;0   0   0		st(0) > operand
;0   0   1		st(0) < operand
;1   0   0		st(0) = operand
;1   1   1		nemozno porovnat

;Riadiace instrukcie

;finit
;inicializuje fpu - stavovy register nastavi na 0,
;riadiaci register nastavuje tiez

;fldcw pamat
;skopiruje (riadiace) slovo z premennej v pamati
;do riadiaceho registra

;fstcw pamat
;ulozi riadiaci register do premennej

;fstsw pamat/ax
;ulozi stavovy register o premennej alebo do AX


;Vyhodnotenie vyrazov

;FPU pouziva POSTFIXOVU (reverznu/polsku) notaciu,
;ktora dava operatory za operandy na rozdiel od
;bezne pouzivanej INFIXOVEJ notacie, ktora
;umiestnuje operatory medzi operandy
;a+b -> ab+
;V infixovej notácii potrebujeme zátvorky, aby 
;sme prepísali štandardné poradie operátorov, 
;v postfixovej zátvorky netreba:
;(a+b)*(c+d) -> ab+cd+*

;PRIKLAD
;napiste program, ktory nacita dlzky stran
;pravouhleho trojuholnika (cele cisla), pomocou
;pytagorovej vety vypocita dlzku prepony a vypise
;ju na obrazovku

	;a
	mov edx, offset sPrompt	;ukaze vyzvu (prompt)
	call WriteString
	call ReadInt	;vstup cisla a sa uklada do eax
	push eax		;uloz do zasobnika 1. parameter

	;b
	mov edx, offset sPrompt	;ukaze vyzvu(prompt)
	call WriteString
	call ReadInt	;vstup cisla b sa uklada do eax
	push eax
	call pytagor
	call WriteFloat	;vypise obsah st(0) na terminal
					;vo formate desatinneho cisla
	call crlf

exit
main ENDP
END main




;JURAJ-MEGA_PROCEDURY
TITLE MASM Template(main.asm)

INCLUDE Irvine32.inc
.data

;// sledovanie poli: debug-windows-memory-memory1, address: &menoPola
R DB 20 dup(0)
Postupnost DW 1,2,3,4,-5
VelkostPostupnosti DB 5
IndexPrvku DB ?

PostupnostUzivatelska DW 20 dup(0)
PocetPU DB ?

F DB 'FALSE',0
T DB 'TRUE',0

Min DB 'MIN=',0
Idx DB 'INDEX=',0
ZP DB 'Zadana postupnost: ',0

X DD 0								;// bitovo reprezentovana mnozina X s 10 cislami v intervale <0,31>, index=hodnota, nastaveny bit=pritomny prvok, 0=nepritomny, DD=double word=dword=4B=32b
Y DD 0
Maska EQU 80000000h;				;// Zakladna maska s nastavenym najvyssim bitom ktory sa bude posuvat neskor (1000 0000 0000 0000 0000 0000 0000 0000 b)
MnozinaVysledna DD 0

Odriadkuj MACRO
	call Crlf						;// z irvine32.inc procedura na odriadkovanie
ENDM

UlozRegistre MACRO
	push eax
	push ebx
	push ecx
	push edx
	push esi
	push edi
	push ebp
	push esp
ENDM

ObnovRegistre MACRO
	pop esp
	pop ebp
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
ENDM

.code

;//  v procedurach zachovame nastavenie registrov v hl. progr.
;//  nacita cislo ako retazec,prevedie na cislo v ax
Nacitaj PROC
	UlozRegistre					;// ulozime registre na zasobnik

	;//  v procedure mame vysledok neskor v eax s kt. sa potom pracuje takze ho nedavam na zasobnik

	mov ecx,20						;//  dlzka retazca
	mov edx,offset R				;//  uloz do edx adresu retazca
	call ReadString
	mov edi,0						;//  nastav edi na nulu
	mov cx,10						;//  nastav cx na 10
	xor ax,ax						;//  vymax cely ax register

	cmp R[edi],'-'
	jne PrevedNaCislo
	inc edi

	PrevedNaCislo:
		mov bl,R[edi]				;//  zober znak do al
		xor bh,bh					;//  vymaz hornu polovicu ax
		cmp bl,0					;//  porovnaj ax a nula
		je Koniec1					;//  ak je ax rone 0 skoc na koniec
		sub bx,30h					;//  konvertuj ASCII kod cisla na jeho hodnotu
		mul cx						;//  inak vynasob ax desiatimi ax*cx
		inc edi						;//  zvys index o jedna
		add ax,bx					;//  a pripocitaj dalsie cislo
		jmp PrevedNaCislo

	Koniec1:
		cmp R[0],'-'				;//  ak neni zaporne nerob dvojk doplnok
		jne Koniec2
		neg ax						;//  dvojkovy doplnok zaporne cislo

	Koniec2:
		ObnovRegistre				;// vybere zo zasobnika povodne hodnoty do registrov
		ret
Nacitaj ENDP

;//  vypise obsah ax
Vypis PROC
	UlozRegistre

	mov edi,length R - 2			;//  -1=> index,-2=> koniec cisla bez '\0' 
	cmp ax,0 
	jnl Koniec3						;//  ak je ax vacsie ako nula preskoc na koniec3
	neg ax							;//  negujeme ax naspat

	mov bx,ax
	mov al,'-'
	call WriteChar
	mov ax,bx

	Koniec3:
		mov bx,10					;//  delitel
		xor dx,dx					;//  vynulujeme dx lebo do neho sa uklada vysledok ale iba do dolnej casti lebo je male cislo (zvysok)
		div bx						;//  ax/bx ;//  delenie,delenec v ax

		mov R[edi],dl				;//  v dl je zvysok po deleni
		add R[edi],'0'				;//  chceme znak takze pripocitame ascii nulu
	
		dec edi						;//  ideme odzadu retazca takze znizujeme

		cmp ax,0
		jne Koniec3					;//  opakuj kym sa nerovna nule


		mov edx,offset R			;//  zober retazec offset
		add edx,edi					;//  prirataj index zaciatku retazca
		inc edx						;//  v edx je zaciatok retazca

		call WriteString

	Koniec4:
		ObnovRegistre
		ret
Vypis ENDP

;// najde minimum v uzivatelskej postupnosti a vypise
NajdiMinimum PROC
	UlozRegistre

	xor edx,edx
	xor ebx,ebx
	xor ecx, ecx
	mov bx,32000					;//  ebx docasne minimum,init na max bx=(2^16)-1=65535 ALE KED DAM TOTO, TAK SA PO CMP V JGE ZLE VYHODNUCUJE PODMIENKA??? OVERFLOW?
	mov cl,PocetPU
	mov edi,ecx
	Hladaj:
		dec edi

		mov dx,PostupnostUzivatelska[2*edi]
		cmp dx,bx
		jge neboloMinimum
		mov bx,dx
		mov IndexPrvku,cl
		dec IndexPrvku
		NeboloMinimum:

		loop Hladaj

	xor edx,edx
	mov edx,offset Min
	call WriteString
	xor eax,eax
	mov ax,bx						;//  vypis najmensi prvok
	call Vypis
	Odriadkuj
	
	xor edx,edx
	mov edx,offset Idx
	call WriteString
	xor eax,eax
	mov al,IndexPrvku				;//  vypis index prvku
	call Vypis
	Odriadkuj

	ObnovRegistre
	ret
NajdiMinimum ENDP

;// zisti ci sa cislo zadane z klavesnice nachadza v Postupnosti, vypise true/false
NachadzaSaVPostupnosti PROC
	UlozRegistre

	xor ecx,ecx						;// vymazem si ecx
	mov cl,VelkostPostupnosti		;// do dolnej 1B polovice ulozim velkost postupnosti kt. je v 1B
	Hladaj:
		mov edi,ecx					;// cele ecx si nahram do edi na indexovanie pola
		dec edi
		cmp ax,Postupnost[2*edi]	;//  lebo Postupnost je WORD=2B
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

	ObnovRegistre
	ret
NachadzaSaVPostupnosti ENDP

;// nacitava postupne cisla z terminalu, ukoncovacie cislo je 0 (buffer = max 20 DW cisel)
NacitajPostupnost PROC
	UlozRegistre

	xor ebx,ebx
	Nacitavaj:
		call Nacitaj

		cmp ax,0
		je Koniec

		mov di,bx

		mov PostupnostUzivatelska[2*edi],ax
		inc bl
		jmp Nacitavaj

	Koniec:

	mov PocetPU,bl

	ObnovRegistre
	ret
NacitajPostupnost ENDP

VypisPostupnost PROC
	UlozRegistre

	mov edx,offset ZP
	call WriteString

	xor ecx,ecx
	xor eax,eax
	xor edi,edi
	Vypisuj:
		mov cl,PocetPU
		cmp di,cx
		jge Koniec

		mov ax,PostupnostUzivatelska[2*edi]
		call Vypis
		mov al,','
		call WriteChar

		inc di
		jmp Vypisuj
	Koniec:

	Odriadkuj

	ObnovRegistre
	ret
VypisPostupnost ENDP

;// vygeneruje 10 prvkovu mnozinu cisiel v rozsahu <0,n-1>, ROVNAKE CISLA SA GENERUJU AJ OPAKOVANE, v mnozine prvok len raz
;// param: eax=offset mnozina:dword, bl=n:byte
GenerujMnozinu PROC, mnozina:dword, n:byte
	UlozRegistre

	;//SPYTAT SA AKO SA ODKAZOVAT NA ADRESU ULOZENU V LOKALNEJ PREMENNEJ mnozina definovanej cez LOCAL//////////////////
	;//mov [mnozina], dword ptr 0;// ?????vynuluje bity
	mov edx, mnozina
	mov [edx],dword ptr 0

	xor eax,eax
	xor ecx,ecx
	mov cl,10						;// 10 prvkova mnozina

	Generuj:
		mov al,n
		call RandomRange			;//vygeneruje od <0,n-1> do eax

		;// ----TEST--vypis vygenerovanych cisel v eax--
		;//call WriteInt
		;//push eax
		;//mov al,','
		;//call WriteChar
		;//pop eax
		;//--------------------------------------------

		push ecx					;// ecx si hodim na zasobnik lebo shr pri velkosti posunutia moze byt len const, alebo cl register
		mov cl,al					;// v al (1B) je vlastne index prvku

		mov ebx,Maska				;// do ebx skopirujem zakladnu masku s nastavenym najvyssim bitom
		shr ebx,cl					;// posuniem najvyssi bit o eax miest doprava cim ziskam vyslednu masku

		pop ecx						;// vyberem spat riadiacu premennu cyklu zo zasobnika do ecx

		or [edx], ebx				;// pridam nastaveny bit z masky do X
									;// lebo mnozina ma bitovu reprezentaciu kde index=hodnota, nastaveny bit=pritomny prvok s hodnotou=index

		loop Generuj
	Koniec:

	ObnovRegistre
	ret
GenerujMnozinu ENDP

;// vypise mnozinu, ak d!=0 potom vypise doplnok mnoziny
VypisMnozinu PROC mnozina:dword,d:byte
	UlozRegistre

	mov edx,mnozina

	;// for (int=0;i<32;i++)
	xor ebx,ebx
	mov bl,32
	xor ecx,ecx
	Vypisuj:
		cmp cl,bl
		jge Koniec

		mov eax,Maska
		shr eax,cl

		cmp d,0
		jne Doplnok					;// ak je paramater nenulovy rob doplnok

		Normalne:					;// vypis mnoziny normalne
		test [edx],eax				;// testujeme "i-ty" (cl) bit v mnozine zlava doprava
		jz Nevypisuj				;// ak je nulovy potom nevypisuj lebo prvok nie je nastaveny
		jmp Dalej

		Doplnok:					;// vypis doplnku mnoziny
		test[edx], eax
		jnz Nevypisuj				;// vypisuj ak NEnulovy => doplnok

		Dalej:
		mov ax,cx
		call Vypis
		mov al,','
		call WriteChar

		Nevypisuj:

		inc cl
		jmp Vypisuj
	Koniec:

	ObnovRegistre
	ret
VypisMnozinu ENDP

;// vypise vysledok binarnej mnozinovej operacie. param: 1: offset mnozina1, 2: offset mnozina2, 3: operacia 'Z'=zjednotenie | 'P'=prienik
MnozinovaOperacia PROC m1:dword,m2:dword,o:byte
	UlozRegistre
	
	mov MnozinaVysledna,dword ptr 0

	mov eax,[m1]
	mov ebx,[m2]

	xor ecx,ecx

	SpravOperaciu:
		cmp cl,32
		jge Koniec

		mov edx, Maska							;// dam si masku do registra
		shr edx, cl								;// a posuniem 1 na prislusnu poziciu

		cmp o,'Z'
		je Zjednotenie

		cmp o,'P'
		je Prienik

		jne NeplatnaOperacia

		Zjednotenie:
			test[eax], edx						;// otestujem na pozicii ci je 1 v m1
			jnz Zapis							;// ak je uz tu 1 nastavena, mozem rovno zapisat

			test[ebx], edx						;// otestujem m2
			jz Nepatri							;// ak nebola nastavena ani tu, tak tam nepatri
			jnz Zapis							;// ak bola nastavena tak zapis

		Prienik:
			test[eax], edx
			jz Nepatri

			test[ebx], edx
			jz Nepatri
			jnz Zapis							;// ak su obe nastavene na 1 tak zapis

		Zapis:
			or MnozinaVysledna, edx				;// ak vsetko preslo, pridam 1 z masky do vyslednej mnoziny prieniku


		Nepatri:
		inc cl
		jmp SpravOperaciu
	Koniec:

	VypisVysledok:
		invoke VypisMnozinu, offset MnozinaVysledna, 0

	NeplatnaOperacia:

	ObnovRegistre
	ret
MnozinovaOperacia ENDP

main PROC
	call Clrscr							;// vycisti obrazovku

	;//call Nacitaj						;// nacitaj cislo do ax
	;//call NachadzaSaVPostupnosti

	;//call NacitajPostupnost
	;//call NajdiMinimum				;// najde minimum v uzivatelskej postupnosti
	;//call VypisPostupnost

	call Randomize;// init random generator

	invoke GenerujMnozinu, offset X, 32
	invoke VypisMnozinu, offset X, 0

	Odriadkuj

	invoke GenerujMnozinu, offset Y, 32
	invoke VypisMnozinu, offset Y, 0

	Odriadkuj

	invoke MnozinovaOperacia, offset X, offset Y, 'P'
	Odriadkuj
	invoke MnozinovaOperacia, offset X, offset Y, 'Z'

	Odriadkuj
	exit
main ENDP
END main




;Slavove procedury a programy All-In-One
;nacitanie retazca
TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
retazec DB 7 DUP (?)

.code
main PROC
	call Clrscr

	mov  edx, offset retazec
	mov  ecx, 7
	call ReadString
	call WriteString


	exit
main ENDP

END main




;zmena znakov nacitanych z klavesnice
TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

.code

nacitaj PROC
	call ReadChar; nacita znak, ulozi do AL
	ret
nacitaj ENDP

zvysZnak PROC
	sub al,'0'; prevod z ASCI kódu znaku na znak
	add al,2
	ret
zvysZnak ENDP


main PROC
odriadkuj MACRO
	mov al, 0Dh
	call WriteChar
	mov al, 0Ah
	call WriteChar
ENDM

	mov ax,0
	call Clrscr; vymaže obrazovku
Pokracuj:
	call nacitaj
	call WriteChar; vypise znak z AL

	cmp al,'k'; porovná znak s k
	je Koniec; aj znak je k, tak sa program ukoncí
	call zvysZnak
	add al,'0'
	call WriteChar; vypise znak z AL
	odriadkuj

	jmp Pokracuj


Koniec:
	exit
main ENDP

END main




;najmensi prvok mnoziny - minimum mnoziny
;funguje iba na pevne zadanu mnozinu a iba pre kladne cisla
TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

aPostupnostCislel DW 9999, 9999, 881, 9999, 9998; Pole typ Word, alokuje sa 10 B (5*2) v pamati

.code

main PROC
	call Clrscr; vymaze obrazovku

	mov ecx,5; priradi ecx 5 - dlzka pola
	mov bx, aPostupnostCislel[0]; do bx sa priradi 0 prvok pola 

	Cyklus:
		mov ax, aPostupnostCislel[ecx*2-2]; potrebujeme prechadzat cele pole, Word je v 2B, takze *2 
		cmp ax, bx; porovnáme ax a bx
		jb PrepisCislo; ak je ax mensie, tak sa prepise bx na ax
    Navrat:

	LOOP Cyklus

	mov eax, 0; vynuluje cele eax
	mov ax, bx; vlozi sa hodnota z bx do ax
	call WriteInt; vypise obsah eax
	jmp Koniec;


	PrepisCislo:
		mov bx, ax
	jmp Navrat

Koniec:

	exit
main ENDP

END main

;Moje cvicenia
;konvertuj cislo zadane ako retazec na jeho hodnotu a vypis ho
TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
R DB 20 dup(?)

.code
Odriadkuj MACRO
		mov al, 0dh
		call WriteChar
		mov al, 0ah
		call WriteChar
ENDM

;do hlavicky procedury NacitajCislo sme doplnili registre parametre, ktore ma procedura pouzivat, direktiva pascal
NacitajCislo PROC pascal USES ecx edx edi ebx
	call Clrscr			;vycisti obrazovku

	Odriadkuj

	mov ecx, 20			; dlzka retazca
	mov edx, offset R	;uloz do edx adresu retazca
	call ReadString		;vyziadaj vstup od uzivatela
	mov edi, 0		;nastav edi na nulu
	mov cx, 10		;nastav cx na 10
	xor ax, ax		;vymax cely ax register
	cmp R, '-'		;R je nulty znak pola R
	jne PrevedNaCislo
	inc edi

PrevedNaCislo:
	mov bl, R[edi]	;zober znak do bl
	xor bh, bh		;vymaz hornu polovicu bx
	cmp bl, 0		;porovnaj bl a nula
	je Koniec		;ak je bl rovne 0 skoc na koniec
	sub bx, 30h		;konvertuj ASCII kod cisla na jeho hodnotu
	mul cx			;inak vynasob ax desiatimi ax*cx, cx=10, ax=
	inc edi			;zvys index o jedna
	add ax, bx		;a pripocitaj dalsie cislo
	jmp PrevedNaCislo

Koniec:
	cmp R, '-'			;porovnaj R s minuskom
	jne Koniec_koncov	;skoc na koniec koncov
	neg ax				;a vytvor dvojkovy doplnok celeho registra ax
	
Koniec_koncov:
	ret
	

NacitajCislo ENDP

main PROC

	call NacitajCislo

PrevedKladneNaRetazec:
	movsx eax, ax		;zober ax a rozsir ho na 32 bitov
	call WriteInt		;vypis cislo z registra eax
	Odriadkuj

exit
main ENDP
END main