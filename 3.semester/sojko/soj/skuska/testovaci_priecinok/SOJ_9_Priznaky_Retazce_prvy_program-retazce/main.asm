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