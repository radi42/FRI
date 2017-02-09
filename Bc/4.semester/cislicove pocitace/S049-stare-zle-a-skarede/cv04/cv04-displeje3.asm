byte 0x88,A
byte 0x89,H
byte 0xC0,O
byte 0xE1,J

Reset:
mvi a,0x00
mvi d,0x0E		;na prvom cisle nezalezi, moze byt lubovolne, druhe cislo ovlada displeje (1 - nesvieti, 0 - svieti)

out 0x0001,d
mmr b,a
out 0xFFFE,b

mvi a,0x01
mvi d,0x0D

out 0x0001,d
mmr b,a
out 0xFFFE,b

mvi a,0x02
mvi d,0x0B

out 0x0001,d
mmr b,a
out 0xFFFE,b

mvi a,0x03
mvi d,0x07

out 0x0001,d
mmr b,a
out 0xFFFE,b
