TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
R DB 20 dup(?); deklaracia viacerych bajtov - viacnasobna deklaracia
slovo DB ?; ? - je neinicializovany

.code
main PROC
	call Clrscr; vycisti obrazovku
	
	mov ecx, 20; dlzka retazca
	mov edx, offset R;	uloz do edx adresu retazca
	call ReadString
	call WriteString


	;odriadkuj
	mov al, 0dh
	call WriteChar
	mov al, 0ah
	call WriteChar


exit
main ENDP
END main