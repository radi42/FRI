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