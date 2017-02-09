TITLE MASM Template(main.asm)

INCLUDE Irvine32.inc
.data
DialogBoxCaption DB 'Warning',0
DialogBoxText DB 'Tento program trva prilis dlho!',0


.code
main PROC

;Funkcia MessageBox
; vytvor message box
push MB_OK or MB_ICONWARNING
push offset DialogBoxCaption
push offset DialogBoxText
push NULL
call MessageBoxA



exit
main ENDP
END main