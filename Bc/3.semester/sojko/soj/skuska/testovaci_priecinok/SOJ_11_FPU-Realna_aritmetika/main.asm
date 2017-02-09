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