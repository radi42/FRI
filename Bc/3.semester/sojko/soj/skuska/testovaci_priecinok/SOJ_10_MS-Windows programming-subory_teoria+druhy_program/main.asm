TITLE MASM Template(main.asm)

INCLUDE Irvine32.inc
.data
MenoSub		DB 'Retaz.txt',0
Text		DB 'Ahoj!',0Dh,0Ah
PocetZnakov	DD $-Text
FileHandle	DD ?
PocetBytov	DD ?

.code
main PROC

;suborove sluzby windows
;Pri prvej operacii so suborom (pri vytvoreni noveho
;alebo otvoreni existujuceho suboru) musime ako
;vstupny parameter odovzdat sluzbe meno suboru

;Meno suboru je retazec ukonceny nulou. Moze
;obsahovat specifikaciu disku a cestu napr

;File1 DB 'MOJ.ASM',0
;File2 DB 'C:\USERS\JANOSIK\TEST.TXT',0

;sluzba prideli suboru 32 bitove identifikacne
;cislo-popisovac (file handle). Musime si ho zapamatat,
;pretoze pri dalsich operaciach (citani, zapise,
;zatvoreni) identifikujeme subor pomocou tohto
;cisla, a nie jeho menom

;HANDLE CreateFile(
	;LPCTSTR lpFileName, 
	;DWORD dwDesiredAccess, 
	;DWORD dwShareMode,	
	;LPSECURITY_ATTRIBUTES lpSecurityAttributes, 
	;DWORD dwCreationDisposition,	
	;DWORD dwFlagsAndAttributes,	
	;HANDLE hTemplateFile 	
;); 

;Parameter hTemplateFile - popisovac suboru, ktoreho atributy sa prevezmu
;- moze byt bud popisovac otvoreneho suboru, alebo moze mat hodnotu NULL. 
;Ak sa vytvara novy subor, funkcia ignoruje atributy odovzdane v parametri dwFlagsAndAttributes a pouzije atributy suboru urceneho tymto popisovacom. 
;Ak funkcia otvara existujuci subor, parameter sa ignoruje.

;Parameter dwFlagsAndAttributes
;Vybrane atributy:
;Hodnota						Vyznam
;FILE_ATTRIBUTE_READONLY (1)		Aplikacia moze citat zo suboru, ale nemoze donho zapisovat alebo ho vymazat.
;FILE_ATTRIBUTE_HIDDEN (2)		Subor sa nezobrazi v listingu adresara.
;FILE_ATTRIBUTE_ARCHIVE (20h)	Aplikacie pouzivaju tento atribut na oznacenie suborov, ktore sa maju zalohovat.
;FILE_ATTRIBUTE_NORMAL (80h)		Najcastejsia hodnota. Nemoze sa kombinovat s inymi atributmi.
;FILE_ATTRIBUTE_TEMPORARY (100h)	Docasny subor. Operacny system sa snazi udrziavat data v pamati a neukladat ich na disk (kvoli rychlejsiemu pristupu). Aplikacia by mala docasny subor vymazat, ked ho uz nepotrebuje.

;Parameter dwCreationDisposition - co sa ma robit, ak subor uz existuje, resp. neexistuje
;Hodnota				Vyznam
;CREATE_NEW (1)			Funkcia vytvori novy subor. Ak subor rovnakeho mena uz existuje, vyhlasi chybu.
;CREATE_ALWAYS (2)		Vytvori novy subor. Ak subor rovnakeho mena uz existuje, funkcia ho prepise.
;OPEN_EXISTING (3)		Otvori existujuci subor. Ak subor neexistuje, funkcia vyhlasi chybu. 
;OPEN_ALWAYS (4)			Otvori existujuci subor. Ak subor neexistuje, funkcia ho vytvori.
;TRUNCATE_EXISTING (5)	Otvori existujuci subor a nastavi jeho dlzku na 0 bajtov. Ak subor neexistuje, funkcia vyhlasi chybu. Subor musi byt otvoreny so sposobom pristupu GENERIC_WRITE.

;Parameter lpSecurityAttributes - adresa struktury SECURITY_ATTRIBUTES
;- nastavuje prava pristupu k suboru a urcuje, ci popisovac suboru bude dedicny (cim by pristup k suboru ziskali aj synovske procesy). 
;Ak chceme pouzit implicitne hodnoty zabezpecenia (k objektu ma pristup ten, kto ho vytvoril a administrator) a popisovac sa nema dedit => NULL.

;Parameter dwShareMode - rezim zdielania, napriklad:
;Hodnota								Vyznam
;0										Aplikacia pozaduje vyhradny pristup k suboru.
;FILE_SHARE_READ (1)					Ine procesy mozu subor otvorit pre citanie.
;FILE_SHARE _WRITE (2)					Ine procesy mozu subor otvorit pre zapis.
;FILE_SHARE_READ or FILE_SHARE_WRITE	Subor bude zdielany v rezime citania aj zapisu.

;Parameter dwDesiredAccess  - pozadovany pristup
;Hodnota						Vyznam
;0								Aplikacia chce zistit, ci subor existuje alebo ake ma atributy, napr. cas poslednej zmeny. 
;GENERIC_READ (80000000h)		zo suboru sa bude citat
;GENERIC_WRITE (40000000h)		do suboru sa bude zapisovat
;GENERIC_READ or GENERIC_WRITE	subor je urceny aj na citanie aj na zapis


;ReadFile
;- cita udaje zo suboru od pozicie danej hodnotou ukazovatela v subore. Ak citanie prebehlo bez chyby, vrati true, inak false.
;---------------------------------------------------------
;BOOL ReadFile(
;HANDLE hFile, // popisovac suboru 
;LPVOID lpBuffer, // adresa premennej, do ktorej sa ulozia
;  precitane data  
;DWORD nNumberOfBytesToRead, // pocet bajtov, ktore sa maju
;  precitat 
;LPDWORD lpNumberOfBytesRead, // adresa premennej, do 
;  ktorej sa ulozi pocet precitanych bajtov 
;LPOVERLAPPED lpOverlapped   // adresa struktury, ktora sa
;  pouziva pri asynchronnom pristupe (pri synchronnom pristupe
;  k suboru je hodnota tohto parametra NULL)
;); 


;WriteFile
;zapisuje do suboru od pozicie danej hodnotou
;ukazovatela v subore
;parametre a navratova hodnota ako ReadFile
;-----------------------------------------
;BOOL  WriteFile(
;HANDLE hFile, 
;LPVOID lpBuffer, 
;DWORD nNumberOfBytesToWrite, 
;LPDWORD lpNumberOfBytesWritten, 
;LPOVERLAPPED lpOverlapped );



;CloseHandle
;zatvori subor
;----------------------------------
;BOOL CloseHandle(
;    HANDLE hObject 	// popisovac suboru  
;   ); 


;PRIKLAD
;Zapiste do suboru retazec ulozeny v premennej Text

;vytvor subor MenoSub	(HANDLE CreateFile vid 31. riadok kodu)
	push NULL	
	push FILE_ATTRIBUTE_NORMAL	
	push CREATE_ALWAYS	
	push NULL	
	push 0; nezdielat	
	push GENERIC_WRITE	
	push offset MenoSub	
	call CreateFileA 	
	mov FileHandle,eax; odloz popisovac

;zapis Text do suboru	(BOOL WriteFile)
	push NULL	
	push offset PocetBytov	
	push PocetZnakov	
	push offset Text	
	push FileHandle	
	call WriteFile	; zatvor subor	
	push FileHandle	
	call CloseHandle

exit
main ENDP
END main