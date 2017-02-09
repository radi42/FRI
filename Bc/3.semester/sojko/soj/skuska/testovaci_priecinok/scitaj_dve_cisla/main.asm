TITLE MASM Template(main.asm)

INCLUDE Irvine32.inc
.data
	EnterX DB "Enter X: ", 0		;keby retazce neboli ukoncene nulou, vypisali by sa najprv vsetky tri retazce potom posledne dva a nakoniec posledny retazec
	EnterY DB "Enter Y: ", 0
	Result DB "Result: ", 0
.code
newLine MACRO
	mov al, 0Ah
	call WriteChar
	mov al, 0Dh
	call WriteChar
ENDM
main PROC
	mov edx, offset EnterX
	call WriteString		;metoda WriteString vypisuje register EDX
	call ReadInt			;metoda ReadInt cita z registra EAX cislo so znamienkom
	mov ebx, eax

	mov edx, offset EnterY
	call WriteString
	call ReadInt
	add eax, ebx

	mov edx, offset Result
	call WriteString
	call WriteInt			;metoda WriteInt vypisuje z registra EAX cislo so znamienkom
	newLine

exit
main ENDP
END main