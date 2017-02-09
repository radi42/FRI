TITLE MASM Vstup_Vystup					(main.asm)

INCLUDE Irvine32.inc
.data
Retaz DB "No nazdar!",0
ZadajPismeno DB "Zadajte pismeno: ",0

.code
main PROC

Odriadkuj MACRO
	mov al, 0Dh
	call WriteChar
	mov al, 0Ah
	call WriteChar
ENDM

call Clrscr

mov edx, offset ZadajPismeno
call WriteString
xor eax, eax
xor edx, edx

mov	 edx,OFFSET Retaz; do edx da offset reùazca tj adresa
mov  edi,0;
call ReadChar
call WriteChar
mov bl,al  ; z reg al do bl - to co zadame z klavesnice zapiseme do bl
Odriadkuj
mov al, bl
mov cl,"0" ; pocitadlo - do cl d· asi hodnotu 0 preto uvodzovky

Vypis: 
		   mov al,[edx+edi]; ; do al da adresu retùazca spolu s adresou 1 znaku
		   cmp al,0; ; zisti ci je 0 = koniec
		   je Koniec; ; podmieneny skok ak plati vyööie
		   cmp al,bl ; skontroluje al a bl
		   je Zhoda ; ak plati tak skoci na Zhoda
Nove:
		   call WriteChar; Vypiöe pismeno z reùtazca
		   inc al			;prikazy na vypisanie nasledujuceho pismena v asci tabulke
		   call WriteChar
		   Odriadkuj
		   inc edi;         zvysi edi o 1, cize sa dostaneme na dalöie pismeno v reùazci
		   jmp Vypis;       nepodmieneny skok na vypis 

Zhoda:
		inc cl  ; ak je zhoda zvyöi pocitadlo
		jmp Nove; nepodmieneny skok na Nove
      
Koniec:
		Odriadkuj
		Odriadkuj
		mov al,cl	; do al da cl na vypis
		call WriteChar
		Odriadkuj

exit
main ENDP
END main