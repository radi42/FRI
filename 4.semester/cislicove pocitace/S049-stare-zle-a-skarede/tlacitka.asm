Byte 0xFE,1 ; ktory riadok sa aktivuje -na najvyssich 4 bytoch nezalezi
Byte 0xFD,2
Byte 0xFB,3
Byte 0xF7,4

Init:
mvi c,0x00 ; riadok - prvy riadok kodu

Cyklus:
	mmr b,c
	out 0xFFFD,b
	inn a,0x0001
	cmi a,0x0F
	jzr Preskoc
		mov d,a
		scall dsp
	Preskoc:
	inc c
	cmi c,0x04
	jzr Init
jmp Cyklus