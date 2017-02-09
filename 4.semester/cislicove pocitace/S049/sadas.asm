byte 0x88,A
byte 0x89,H
byte 0xC0,O
byte 0xF0,J

Cyklus:
mvi c,0x04 ; pocet displejov 

mvi d,0x00   ; ktory riadok kodu sa vyberie
mmr b,d
out 0xFFFE,b

mvi a,0x0F		;na prvom cisle nezalezi, moze byt lubovolne, druhe cislo ovlada displeje (1 - nesvieti, 0 - svieti)
out 0x0001,a

inc a
dec b
dec c
cmi c,0x00
jzr Koniec
jmp Cyklus

Koniec: