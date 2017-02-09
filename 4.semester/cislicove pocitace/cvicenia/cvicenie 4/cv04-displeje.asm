;byte 0xF9,1
byte 0xA4,2
mvi a,0x00
mmr b,a
out 0xFFFE,b

mvi a,0x0F		;na prvom cisle nezalezi, moze byt lubovolne, druhe cislo ovlada displeje (1 - nesvieti, 0 - svieti)
out 0x0001,a