mvi a,0xAA
mxi m,0x0000

CyklusZapis:
	mvx c,m
	cmi c,0x20
	jzr VynulujA

	smr a
	inx m

	jmp CyklusZapis

VynulujA:
	mvi a,0x00
	jmp CyklusCitaj

CyklusCitaj:
	dcx m
	
	jcy KontrolujChybu

	lmr b

	cmi b,0xAA
	jnz ZvysChybu

	jmp CyklusCitaj

ZvysChybu:
	inc a
	jmp CyklusCitaj

KontrolujChybu:
	cmi a,0x00
	jzr OK
	jmp KO

OK:
	mvi d,0x4f
	scall dsp
	mvi d,0x4b
	scall dsp

	jmp Koniec

KO:
	mvi d,0x4b
	scall dsp
	mvi d,0x4f
	scall dsp

	jmp Koniec

Koniec:
	