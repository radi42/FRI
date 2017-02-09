TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
pocet=7
postupnost	DW -54, 32000, -1, 546, -31000, 12, -55

;****pre zapis do suboru
FILE1 DB "C:\Users\ADMIN\Desktop\textfile.txt",0
PocetBytov DD ?
FileHandle DD ?
DlzkaStringu DD 0
text BYTE 100 dup(?)



.code
main PROC
Call Generuj

mov eax,0
mov ecx, pocet			;pocet cyklov
dec ecx
mov edx, 0				;poracie prvku ktory porovnavam
Zorad:
Call Najmensie	
							;prehod cisla
mov bx, [postupnost+eax]
push bx
mov bx,[postupnost+edx]
mov [postupnost+eax],bx
pop bx
mov [postupnost+edx],bx


;vypis
push eax
mov ax,[postupnost+edx]		;ak zaprne
cmp ax,0
jl Zaporne
Spaat:
Call WriteINT
pop eax
inc edx
inc edx
loop Zorad

mov ax,[postupnost+edx]
Call WriteINT


mov ecx, pocet
mov edx, 0
PrevodNaString: 
	mov ebx, 0
	mov bx, [postupnost+edx]
	Call CisloNaString
	push eax
	push edx
	mov al, 20h
	mov edx, dlzkaStringu
	mov [Text+edx],al
	add DlzkaStringu,1
	
	pop edx
	pop eax
	inc edx
	inc edx
loop PrevodNaString

call Uloz				;zavolam proceduju na ulozenie


exit
Zaporne:
push ax
mov eax,-1
pop ax
jmp Spaat


main ENDP

Najmensie PROC USES ECX EDX EBX
mov eax, edx
inc eax
inc eax
Prehladaj:
mov bx, [postupnost+eax]
cmp [postupnost+edx], bx
jg NastavPoziciu

NavestieNaspat:
	inc eax
	inc eax
loop Prehladaj

mov eax,edx

ret

NastavPoziciu:
	mov edx, eax
jmp NavestieNaspat
Najmensie ENDP

;***********************************vygenerovanie
Generuj PROC uses ECX EDX
mov ecx, pocet
mov eax, 32000

mov edx, 0
Call Randomize
Generujj:
	push eax
	Call RandomRange
	mov [postupnost+edx],ax

	pop eax

	inc edx
	inc edx
loop Generujj
ret
Generuj ENDP

;********************do suboru************************
uloz PROC

push NULL
push FILE_ATTRIBUTE_NORMAL
push OPEN_EXISTING
push NULL
push 0; nezdieæaù
push GENERIC_WRITE
push offset FILE1
call CreateFileA 
mov FileHandle,eax;

push NULL					;*******Komentare su pre nacitanie zo suboru****************
push offset PocetBytov		;adresa premennej, do ktorej sa uloûÌ poËet nacitanych bajtov 
push DlzkaStringu			;poËet bajtov, ktorÈ sa maj˙ zapisat 
push offset Text			;adresa premennej z ktorej budem zapisovat
push FileHandle			;popisovaË s˙boru 

call WriteFile	


push FileHandle
call CloseHandle


uloz ENDP

;******************cislo na String***************
CisloNaString PROC USES ECX EAX EDX
push ebx
	mov esi, offset Text   ; esi ukazuje na string
	add esi, DlzkaStringu
	cmp bx, 0
	jl Zaporne
	Spat:

	mov eax, ebx     ; cislo ktore sa ma konvertovat
    mov ecx, 10         ; delitel
	mov ebx, 0		; pocet znakov kolko ma string

divide:
    mov edx, 0        ; vysia cast registra  = 0
    div ecx             ; eax = edx:eax/ecx, edx = zvysok
    push dx             ; DL je cislo od 0 do 9
    inc bx              ; pocet cisel
    cmp eax, 0       ; je EAX 0?
    jne divide          ; ak nie pokracuj

    ; POP digits from stack in reverse order
    mov cx, bx          ; pocet cisel
dalsie_cislo:
    pop ax
    add al, '0'         ; prevod do ASCII
    mov [esi], al        ; zapise do stringu text
    inc si
    loop dalsie_cislo

	mov eax,ebx
	pop ebx
	cmp bx,0
	jl ZvysPocetZnakov	;zvysim pocet znakov ktore treba vypisat ked je zaporne
Naspat:
	mov EDX, offset text
	add DlzkaStringu, eax
	ret
Zaporne: ;*ak je zaporne pridame znak'-' *
	neg bx
	mov al, '-'
	mov [esi], al
	inc si
	jmp Spat
ZvysPocetZnakov:
	add eax,1
	jmp Naspat

CisloNaString ENDP


END main