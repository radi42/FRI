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
		movzx ecx, bx
			Odriadkuj
		mov eax, ecx
		call WriteInt
			Odriadkuj
		mov eax, ebx
		call WriteInt
			Odriadkuj
		;movsx skopiruje pravy operand do dolnej polovice laveho operandu a hornu polovicu laveho operandu naplni hodnotou znamienkoveho bitu praveho operandu
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
		sub eax, 256
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