mvi a,0x10

Navestie:
	dec a

	scall key	
	cmi d,0x0d
	jzr NovyRiadok
Pokracuj:
	scall dsp
	cmi a,0x00
	jzr novyRiadok
	jmp Navestie

NovyRiadok:
	mvi d,0x0d
	scall dsp
	mvi d,0x0a
	mvi a,0x10
jmp Pokracuj
	

