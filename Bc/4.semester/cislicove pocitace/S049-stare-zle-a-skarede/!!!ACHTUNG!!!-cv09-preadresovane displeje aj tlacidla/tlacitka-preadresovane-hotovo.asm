Byte 0xFE,1 ; ktory stlpec tlacidiel sa aktivuje -na najvyssich 4 bytoch nezalezi
Byte 0xFD,2
Byte 0xFB,3
Byte 0xF7,4

InitB:
mvi c,0x00 ; riadok - prvy riadok kodu

CyklusB:
	mmr b,c
	out 0xFFFB,b
	inn a,0x000B
	cmi a,0x0F	;este nie je stlacene ziadne tlacidlo
	jzr Preskoc
		
	;najprv porovnavame pred stlpcovym navestim
		;bol stlaceny 1. stlpec?
		cmi a,0x0e
		jzr PrvyStlpec
		jmp DruhyStlpec
	PrvyStlpec:
		
		;riadok
		mov d,c
		adi d,48
		scall dsp

		;stlpec
		mvi d,0x30
		scall dsp

		;odriadkuj, aby to bolo pekne
		mvi d,0x0D
		scall dsp
		mvi d,0x0A
		scall dsp

	;teraz uz treba porovnavat vnutri stlpcoveho navestia
	DruhyStlpec:
		;bol stlaceny 2. stlpec?
		cmi a,0x0d
		jnz TretiStlpec

		;riadok
		mov d,c
		adi d,48
		scall dsp

		;stlpec
		mvi d,0x31
		scall dsp

		;odriadkuj, aby to bolo pekne
		mvi d,0x0D
		scall dsp
		mvi d,0x0A
		scall dsp

	TretiStlpec:
		;bol stlaceny 3. stlpec?
		cmi a,0x0b
		jnz StvrtyStlpec

		;riadok
		mov d,c
		adi d,48
		scall dsp

		;stlpec
		mvi d,0x32
		scall dsp

		;odriadkuj, aby to bolo pekne
		mvi d,0x0D
		scall dsp
		mvi d,0x0A
		scall dsp

	StvrtyStlpec:
		;bol stlaceny 4. stlpec?
		cmi a,0x07
		jnz Preskoc	;ak sa nerovna Preskoc, inak vypis suradnice

		;riadok
		mov d,c
		adi d,48
		scall dsp

		;stlpec
		mvi d,0x33
		scall dsp

		;odriadkuj, aby to bolo pekne
		mvi d,0x0D
		scall dsp
		mvi d,0x0A
		scall dsp

	Preskoc:
		inc c
		cmi c,0x04
		jzr InitB
jmp CyklusB