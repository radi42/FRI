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