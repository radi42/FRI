byte 0x88,A
byte 0x89,H
byte 0xC0,O
byte 0xF0,J

mvi c,0x04 ; pocet displejov 
mvi a,0x0E ;na prvom cisle nezalezi, moze byt lubovolne, druhe cislo ovlada displeje (1 - nesvieti, 0 - svieti)
mvi d,0x00 ;ktory riadok byte sa vyberie

Cyklus:

mmr b,d
out 0xFFFE,b

out 0x0001,a

dec a
inc d
dec c
cmi c,0x00
jzr Koniec
jmp Cyklus

Koniec: