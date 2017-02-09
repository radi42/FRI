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