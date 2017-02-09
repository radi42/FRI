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