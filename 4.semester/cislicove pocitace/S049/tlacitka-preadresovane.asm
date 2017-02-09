Byte 0xFE,1 ; ktory riadok tlacidiel sa aktivuje -na najvyssich 4 bytoch nezalezi
Byte 0xFD,2
Byte 0xFB,3
Byte 0xF7,4

Init:
mvi c,0x00 ; riadok - prvy riadok kodu

Cyklus:
	mmr b,c
	out 0xFFFB,b
	inn a,0x000B
	cmi a,0x0F
	jzr Preskoc
		mov d,a	;a je od veci
		adi d,0x22
pus d
		scall dsp

		mov d,c
		adi d,0x30
pus d
		scall dsp
	Preskoc:
	inc c
	cmi c,0x04
	jzr Init
jmp Cyklus