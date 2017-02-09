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