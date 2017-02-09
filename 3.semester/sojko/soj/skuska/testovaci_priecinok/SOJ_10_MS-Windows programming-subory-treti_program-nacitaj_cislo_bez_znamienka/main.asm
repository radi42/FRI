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